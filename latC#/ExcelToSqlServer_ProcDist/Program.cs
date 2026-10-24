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
        public string DistName { get; set; }
        public string FileLoc { get; set; }
        public string FlNm { get; set; }
        public int ProdNameColumnIndex { get; set; }
        public int CustIdColumnIndex { get; set; }
        public int MaxBlankRows { get; set; }
        public string DtcColHdr { get; set; } // The column header used for end condition check
                                              // NEW FIELDS
        public int InvNoColumnIndex { get; set; }   // Used for InvNo (B)
        public int TrDateColumnIndex { get; set; }  // Used for InvDate/TransDate (A)
        public int QtyColumnIndex { get; set; }     // Used for Qty (D)
    }
    // Inside the Program class
    private static List<DistributorConfig> GetAllDistributorConfigs(string connectionStr)
    {
        var configs = new List<DistributorConfig>();
        // Query without a WHERE clause to get all records
        string query = "SELECT DistCode, DistName, FileLoc, FlNm, prodNameColumnIndex, custIdColumnIndex, maxBlankRows, DtcColHdr, InvNoColumnIndex, TrDateColumnIndex, QtyColumnIndex FROM Dim_Distributor";

        using (SqlConnection connection = new SqlConnection(connectionStr))
        {
            connection.Open();
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        configs.Add(new DistributorConfig
                        {
                            DistCode = reader["DistCode"].ToString(),
                            DistName = reader["DistName"].ToString(),
                            FileLoc = reader["FileLoc"].ToString(),
                            FlNm = reader["FlNm"].ToString(),
                            ProdNameColumnIndex = Convert.ToInt32(reader["prodNameColumnIndex"]),
                            CustIdColumnIndex = Convert.ToInt32(reader["custIdColumnIndex"]),
                            MaxBlankRows = Convert.ToInt32(reader["maxBlankRows"]),
                            DtcColHdr = reader["DtcColHdr"].ToString(),
                            InvNoColumnIndex = Convert.ToInt32(reader["InvNoColumnIndex"]),
                            TrDateColumnIndex = Convert.ToInt32(reader["TrDateColumnIndex"]),
                            QtyColumnIndex = Convert.ToInt32(reader["QtyColumnIndex"])
                        });
                    }
                }
            }
        }
        return configs;
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
        //tring hardcodedDistributorCode = "150030255"; // The key to fetch config from DB

        try
        {
            // 1. Retrieve ALL configurations from SQL Server
            List<DistributorConfig> distributors = GetAllDistributorConfigs(connectionString);

            if (distributors == null || distributors.Count == 0)
            {
                Console.WriteLine("No distributors found in Dim_Distributor table. Exiting.");
                return;
            }

            Console.WriteLine($"Found {distributors.Count} distributors to process.");
            // 2. Loop through each distributor configuration and process their file
            foreach (var config in distributors)
            {
                Console.WriteLine($"\n--- Starting ETL for Distributor: {config.DistCode} ({config.DistName}) ---");
                ProcessDistributor(config, connectionString, targetTableName);
                Console.WriteLine($"--- Finished ETL for Distributor: {config.DistCode} ---");
            }

            Console.WriteLine("\nAll distributors processed successfully.");

        }
        catch (Exception ex)
        {
            Console.WriteLine($"A critical error occurred in the Main loop: {ex.Message}");
        }


    }

    private static void ProcessDistributor(DistributorConfig config, string connectionString, string targetTableName)
    {
        try
        {
            // Construct the full file path dynamically using config parameters
            string fullExcelFilePath = Path.Combine(config.FileLoc, config.FlNm);

            if (!File.Exists(fullExcelFilePath))
            {
                Console.WriteLine($"Error: File not found at {fullExcelFilePath}. Skipping this distributor.");
                return;
            }

            // Load the item conversion map specific to this distributor
            var itemMap = GetItemMap(connectionString, config.DistCode);

            // Read the Excel data using dynamic parameters
            DataTable salesData = ReadExcelData(
                fullExcelFilePath,
                config.ProdNameColumnIndex,
                config.CustIdColumnIndex,
                config.MaxBlankRows,
                config.DtcColHdr,
                config.DistCode,
                itemMap,
                config.InvNoColumnIndex,
                config.TrDateColumnIndex,
                config.QtyColumnIndex
            );

            // Bulk insert the data
            if (salesData.Rows.Count > 0)
            {
                BulkInsertToSql(salesData, connectionString, targetTableName);
                Console.WriteLine($"Successfully imported {salesData.Rows.Count} rows into SQL Server for {config.DistCode}.");
            }
            else
            {
                Console.WriteLine("No data found to import for this distributor.");
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"An error occurred during processing of {config.DistCode}: {ex.Message}");
        }
    }

    // Method signature updated to accept 'dtcColHdr' (for finding the correct column index for the blank check)
    // Signature updated to use the new dynamic indices
    private static DataTable ReadExcelData(
        string filePath,
        int prodNameColIndex,
        int custIdColIndex,
        int maxBlankRows,
        string headerToFind,
        string distCode,
        Dictionary<ItemMapKey, string> itemMap,
        int invNoColIndex,      // NEW
        int trDateColIndex,     // NEW
        int qtyColIndex         // NEW
        )
    {
        // ... (DataTable column definitions remain the same) ...
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
                // The blank check column index is still prodNameColIndex/DtcColHdr
                int blankCheckColumnIndex = prodNameColIndex;

                while (reader.Read())
                {
                    // ... (Header finding logic remains the same) ...
                    if (!foundHeader)
                    {
                        if (reader.GetValue(prodNameColIndex)?.ToString().Trim().Equals(headerToFind, StringComparison.OrdinalIgnoreCase) ?? false)
                        {
                            foundHeader = true;
                        }
                        continue;
                    }

                    // ... (Blank cell check logic remains the same) ...
                    if (string.IsNullOrWhiteSpace(reader.GetValue(blankCheckColumnIndex)?.ToString()))
                    {
                        blankCellCount++;
                        if (blankCellCount >= maxBlankRows) { break; }
                        continue;
                    }
                    else { blankCellCount = 0; }

                    DataRow newRow = resultTable.NewRow();
                    newRow["DistCode"] = distCode;

                    // *** UPDATED MAPPINGS USING DYNAMIC INDICES ***
                    newRow["InvDate"] = GetValueOrDefault<DateTime>(reader, trDateColIndex); // Use dynamic index
                    newRow["InvNo"] = GetValueOrDefault<string>(reader, invNoColIndex);     // Use dynamic index
                    newRow["Qty"] = GetValueOrDefault<long>(reader, qtyColIndex);           // Use dynamic index

                    // These indices were already dynamic:
                    newRow["CustId"] = GetValueOrDefault<string>(reader, custIdColIndex);
                    string itemDistDscFromExcel = GetValueOrDefault<string>(reader, prodNameColIndex);
                    var keyForLookup = new ItemMapKey { DistCode = distCode, ItemDistDsc = itemDistDscFromExcel };

                    if (itemMap.TryGetValue(keyForLookup, out string mappedItemId))
                    {
                        newRow["ItemId"] = mappedItemId;
                    }
                    else
                    {
                        Console.WriteLine($"Warning: No ItemId mapping found for Distributor {distCode} and Description '{itemDistDscFromExcel}'.");
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

