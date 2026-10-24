using ExcelDataReader;
using Microsoft.Data.SqlClient;
using System;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;

class Program
{
    // Class to hold dynamic configuration parameters from SQL
    public class DistributorConfig
    {
        public string DistCode { get; set; }
        public string FileLoc { get; set; }
        public string FlNm { get; set; }
        public int ProdNameColumnIndex { get; set; }
        public int CustIdColumnIndex { get; set; }
        public int MaxBlankRows { get; set; }
        public string DtcColHdr { get; set; } // The column header used for end condition check
    }

    // Inside the Program class
    public class ItemMapKey : IEquatable<ItemMapKey>
    {
        public string DistCode { get; set; }
        public string ItemDistDsc { get; set; }

        public override int GetHashCode() => HashCode.Combine(DistCode, ItemDistDsc);

        public override bool Equals(object obj) => Equals(obj as ItemMapKey);

        public bool Equals(ItemMapKey other)
        {
            if (other is null) return false;
            if (ReferenceEquals(this, other)) return true;
            return DistCode == other.DistCode && ItemDistDsc == other.ItemDistDsc;
        }
    }

    // Method to fetch item conversion map
    private static Dictionary<ItemMapKey, string> GetItemMap(string connectionStr, string distCode)
    {
        var itemMap = new Dictionary<ItemMapKey, string>();
        string query = "SELECT DistCode, ItemIdDst, ItemDistDsc, ItemId FROM ItemConversion WHERE DistCode = @DistCode";

        using (SqlConnection connection = new SqlConnection(connectionStr))
        {
            connection.Open();
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                command.Parameters.AddWithValue("@DistCode", distCode);
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        var key = new ItemMapKey
                        {
                            DistCode = reader["DistCode"].ToString(),
                            ItemDistDsc = reader["ItemDistDsc"].ToString()
                        };
                        string itemId = reader["ItemId"].ToString();

                        if (!itemMap.ContainsKey(key))
                        {
                            itemMap.Add(key, itemId);
                        }
                    }
                }
            }
        }
        return itemMap;
    }

    static void Main(string[] args)
    {
        Encoding.RegisterProvider(CodePagesEncodingProvider.Instance);

        // --- Hardcoded Configuration (Connection details and Target Distributor) ---
        string connectionString = "Data Source=HYPE\\SQL_2022;Initial Catalog=DWH;User ID=sa;Password=D@1ry$2014";
        string targetTableName = "sales";
        string hardcodedDistributorCode = "150030255"; // The key to fetch config from DB

        try
        {
            // 1. Retrieve configuration from SQL Server using the hardcoded key
            DistributorConfig config = GetDistributorConfig(connectionString, hardcodedDistributorCode);

            if (config == null)
            {
                Console.WriteLine($"Error: Configuration not found for distributor code {hardcodedDistributorCode}. Ensure it is in Dim_Distributor.");
                return;
            }

            // Construct the full file path dynamically
            string fullExcelFilePath = Path.Combine(config.FileLoc, config.FlNm);

            if (!File.Exists(fullExcelFilePath))
            {
                Console.WriteLine($"Error: File not found at {fullExcelFilePath}");
                return;
            }
            // *** NEW: Load the item conversion map ***
            var itemMap = GetItemMap(connectionString, hardcodedDistributorCode);

            // *** UPDATED CALL: Pass the itemMap to ReadExcelData ***


            // 2. Read the Excel data using dynamic parameters
            DataTable salesData = ReadExcelData(
                fullExcelFilePath,
                config.ProdNameColumnIndex,
                config.CustIdColumnIndex,
                config.MaxBlankRows,
                config.DtcColHdr, // Pass the column header for the blank check
                config.DistCode, // Pass the retrieved DistCode
                itemMap); // Pass the map

            // 3. Bulk insert the data
            if (salesData.Rows.Count > 0)
            {
                BulkInsertToSql(salesData, connectionString, targetTableName);
                Console.WriteLine($"Successfully imported {salesData.Rows.Count} rows into SQL Server for {config.DistCode}.");
            }
            else
            {
                Console.WriteLine("No data found to import.");
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"An error occurred: {ex.Message}");
        }
    }

    // New method to fetch configuration from Dim_Distributor table
    private static DistributorConfig GetDistributorConfig(string connectionStr, string distCode)
    {
        string query = "SELECT DistCode, FileLoc, FlNm, prodNameColumnIndex, custIdColumnIndex, maxBlankRows, DtcColHdr FROM Dim_Distributor WHERE DistCode = @DistCode";
        DistributorConfig config = null;

        using (SqlConnection connection = new SqlConnection(connectionStr))
        {
            connection.Open();
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                command.Parameters.AddWithValue("@DistCode", distCode);
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        config = new DistributorConfig
                        {
                            DistCode = reader["DistCode"].ToString(),
                            FileLoc = reader["FileLoc"].ToString(),
                            FlNm = reader["FlNm"].ToString(),
                            ProdNameColumnIndex = Convert.ToInt32(reader["prodNameColumnIndex"]),
                            CustIdColumnIndex = Convert.ToInt32(reader["custIdColumnIndex"]),
                            MaxBlankRows = Convert.ToInt32(reader["maxBlankRows"]),
                            DtcColHdr = reader["DtcColHdr"].ToString()
                        };
                    }
                }
            }
        }
        return config;
    }

    // Method signature updated to accept 'dtcColHdr' (for finding the correct column index for the blank check)
    private static DataTable ReadExcelData(string filePath, int prodNameColIndex, int custIdColIndex, int maxBlankRows, string dtcColHdr, string distCode,Dictionary<ItemMapKey, string> itemMap)
    {
        var resultTable = new DataTable();
        resultTable.Columns.Add("DistCode", typeof(string));
        resultTable.Columns.Add("InvDate", typeof(DateTime));
        resultTable.Columns.Add("InvNo", typeof(string));
        resultTable.Columns.Add("CustId", typeof(string));
        resultTable.Columns.Add("ItemId", typeof(string));
        resultTable.Columns.Add("Qty", typeof(long));

        using (var stream = File.Open(filePath, FileMode.Open, FileAccess.Read))
        {
            using (var reader = ExcelReaderFactory.CreateReader(stream))
            {
                bool foundHeader = false;
                int blankCellCount = 0;
                int blankCheckColumnIndex = prodNameColIndex; // Default to ProdName column index

                while (reader.Read())
                {
                    // 1. Find the header row by searching for "ProdName" in the specified column
                    if (!foundHeader)
                    {
                        try
                        {
                            // *** UPDATED STATEMENT ***
                            if (reader.GetValue(prodNameColIndex)?.ToString().Trim().Equals(dtcColHdr, StringComparison.OrdinalIgnoreCase) ?? false)
                            {
                                foundHeader = true;
                                Console.WriteLine($"Header '{dtcColHdr}' found. Starting data read.");
                                // We can assume blankCheckColumnIndex remains correct
                            }
                        }
                        catch (IndexOutOfRangeException)
                        {
                            // Ignore rows that don't have enough columns for the check
                        }
                        continue;
                    }

                    // 2. Data reading logic after the header
                    // Blank cell check is determined by the DtcColHdr/ProdName column
                    if (string.IsNullOrWhiteSpace(reader.GetValue(blankCheckColumnIndex)?.ToString()))
                    {
                        blankCellCount++;
                        if (blankCellCount >= maxBlankRows) { break; }
                        continue;
                    }
                    else { blankCellCount = 0; }

                    // ... (Data mapping logic remains the same) ...
                    DataRow newRow = resultTable.NewRow();
                    newRow["DistCode"] = distCode;
                    newRow["InvDate"] = GetValueOrDefault<DateTime>(reader, 0);
                    newRow["InvNo"] = GetValueOrDefault<string>(reader, 1);
                    //newRow["ItemId"] = GetValueOrDefault<string>(reader, 2);
                    newRow["Qty"] = GetValueOrDefault<long>(reader, 3);
                    newRow["CustId"] = GetValueOrDefault<string>(reader, custIdColIndex);
                    // *** NEW: Lookup the correct ItemId using the ProdName column value ***
                    string itemDistDscFromExcel = GetValueOrDefault<string>(reader, prodNameColIndex); // Get the 'ProdName' from Excel
                    var keyForLookup = new ItemMapKey { DistCode = distCode, ItemDistDsc = itemDistDscFromExcel };

                    if (itemMap.TryGetValue(keyForLookup, out string mappedItemId))
                    {
                        newRow["ItemId"] = mappedItemId; // Set the SQL ItemId using the mapped value
                    }
                    else
                    {
                        Console.WriteLine($"Warning: No ItemId mapping found for Distributor {distCode} and Description '{itemDistDscFromExcel}'.");
                        // Handle cases where a mapping isn't found (e.g., skip row, use default, or throw error)
                        // For now, setting it to DBNull.Value or skipping is safer than inserting bad data.
                        newRow["ItemId"] = DBNull.Value;
                    }
                    resultTable.Rows.Add(newRow);
                }
            }
        }
        return resultTable;
    }

    // Helper method GetValueOrDefault and BulkInsertToSql methods remain the same as the previous response
    private static T GetValueOrDefault<T>(IExcelDataReader reader, int columnIndex)
    {
        // ... (omitted for brevity, remains the same as the previous code block)
        try
        {
            if (reader.IsDBNull(columnIndex)) { return default(T); }
            object value = reader.GetValue(columnIndex);
            if (typeof(T) == typeof(DateTime) && value is double)
            {
                return (T)(object)DateTime.FromOADate((double)value);
            }
            if (typeof(T) == typeof(long) && value is double)
            {
                return (T)(object)Convert.ToInt64(Math.Floor((double)value));
            }
            if (typeof(T) == typeof(long) && value is int)
            {
                return (T)(object)Convert.ToInt64(value);
            }
            return (T)Convert.ChangeType(value, typeof(T));
        }
        catch (IndexOutOfRangeException) { return default(T); }
        catch (Exception ex)
        {
            Console.WriteLine($"Error converting value '{reader.GetValue(columnIndex)}' in column index {columnIndex} to type {typeof(T).Name}: {ex.Message}");
            return default(T);
        }
    }

    private static void BulkInsertToSql(DataTable data, string connectionStr, string tableName)
    {
        // ... (omitted for brevity, remains the same as the previous code block)
        using (SqlConnection connection = new SqlConnection(connectionStr))
        {
            connection.Open();
            using (SqlBulkCopy bulkCopy = new SqlBulkCopy(connection))
            {
                bulkCopy.DestinationTableName = tableName;
                bulkCopy.ColumnMappings.Add("DistCode", "DistCode");
                bulkCopy.ColumnMappings.Add("InvDate", "InvDate");
                bulkCopy.ColumnMappings.Add("InvNo", "InvNo");
                bulkCopy.ColumnMappings.Add("CustId", "CustId");
                bulkCopy.ColumnMappings.Add("ItemId", "ItemId");
                bulkCopy.ColumnMappings.Add("Qty", "Qty");
                bulkCopy.WriteToServer(data);
            }
        }
    }
}