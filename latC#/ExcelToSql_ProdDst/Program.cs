using ExcelDataReader;
using Microsoft.Data.SqlClient;
using System;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;

class Program
{
    static void Main(string[] args)
    {
        Encoding.RegisterProvider(CodePagesEncodingProvider.Instance); // no need for xlsx

        // --- Configuration ---
        string excelFilePath = @"c:\Etl_Danone\FajarLestari\product.xlsx";
        //string distributorCode = "150001191"; //already at the first column 
        // REMINDER: Update YourSqlServerName in the connection string
        string connectionString = "Data Source=HYPE\\SQL_2022;Initial Catalog=DWH;User ID=sa;Password=D@1ry$2014";
        string targetTableName = "ItemConversion"; // Table name is lowercase in your SQL
        int prodNameColumnIndex = 1; // Column C for ItemId/ProdName
        //int custIdColumnIndex = 10; // Column K for CustId
        int maxBlankRows = 29;
        if (!File.Exists(excelFilePath))
        {
            Console.WriteLine($"Error: File not found at {excelFilePath}");
            return;
        }

        try
        {
            DataTable prodData = ReadExcelData(excelFilePath, prodNameColumnIndex, maxBlankRows);
            if (prodData.Rows.Count > 0)
            {
                BulkInsertToSql(prodData, connectionString, targetTableName);
                Console.WriteLine($"Successfully imported {prodData.Rows.Count} rows into SQL Server.");
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

    private static DataTable ReadExcelData(string filePath, int prodNameColumnIndex, int maxBlankRows)
    {
        var resultTable = new DataTable();
        // Updated DataTable Columns to match the new SQL Schema
        resultTable.Columns.Add("DistCode", typeof(string));
        resultTable.Columns.Add("ItemIdDst", typeof(string));
        resultTable.Columns.Add("ItemDistDsc", typeof(string));
        resultTable.Columns.Add("ItemId", typeof(string));


        using (var stream = File.Open(filePath, FileMode.Open, FileAccess.Read))
        {
            using (var reader = ExcelReaderFactory.CreateReader(stream))
            {
                bool foundHeader = false;
                int blankCellCount = 0;

                while (reader.Read())
                {
                    if (!foundHeader)
                    {
                        if (reader.GetValue(prodNameColumnIndex)?.ToString().Trim().Equals("PROD_CODE", StringComparison.OrdinalIgnoreCase) ?? false)
                        {
                            foundHeader = true;
                        }
                        continue;
                    }

                    if (string.IsNullOrWhiteSpace(reader.GetValue(prodNameColumnIndex)?.ToString()))
                    {
                        blankCellCount++;
                        if (blankCellCount >= maxBlankRows) { break; }
                        continue;
                    }
                    else { blankCellCount = 0; }

                    DataRow newRow = resultTable.NewRow();
                    //newRow["DistCode"] = distCode;

                    // Column Mappings: A=distcode, B=ItemIdDst, C=ItemDistDsc, D=ItemId
                    newRow["DistCode"] = GetValueOrDefault<string>(reader, 0);
                    newRow["ItemIdDst"] = GetValueOrDefault<string>(reader, 1);
                    newRow["ItemDistDsc"] = GetValueOrDefault<string>(reader, 1);
                    newRow["ItemId"] = GetValueOrDefault<string>(reader, 3);

                    resultTable.Rows.Add(newRow);
                }
            }
        }
        return resultTable;
    }

    private static T GetValueOrDefault<T>(IExcelDataReader reader, int columnIndex)
    {
        try
        {
            if (reader.IsDBNull(columnIndex)) { return default(T); }
            object value = reader.GetValue(columnIndex);
            /*
            // Handle Excel numeric date format
            if (typeof(T) == typeof(DateTime) && value is double)
            {
                return (T)(object)DateTime.FromOADate((double)value);
            }
            // Handle numeric(10,0) which needs to be a long
             if (typeof(T) == typeof(long) && value is double)
            {
                return (T)(object)Convert.ToInt64(Math.Floor((double)value));
            }
            if (typeof(T) == typeof(long) && value is int)
            {
                return (T)(object)Convert.ToInt64(value);
            }
              no need this time 
            */
            return (T)Convert.ChangeType(value, typeof(T));
        }
        catch (IndexOutOfRangeException) { return default(T); }
        catch (Exception ex)
        {
            Console.WriteLine($"Error converting value '{reader.GetValue(columnIndex)}' in column index {columnIndex} to type {typeof(T).Name}: {ex.Message}");
            return default(T); // Return default instead of throwing to allow other rows to proceed
        }
    }

    private static void BulkInsertToSql(DataTable data, string connectionStr, string tableName)
    {
        using (SqlConnection connection = new SqlConnection(connectionStr))
        {
            connection.Open();
            using (SqlBulkCopy bulkCopy = new SqlBulkCopy(connection))
            {
                bulkCopy.DestinationTableName = tableName;

                // Updated Column Mappings to match the new SQL Schema
                bulkCopy.ColumnMappings.Add("DistCode", "DistCode");
                bulkCopy.ColumnMappings.Add("ItemIdDst", "ItemIdDst");
                bulkCopy.ColumnMappings.Add("ItemDistDsc", "ItemDistDsc");
                bulkCopy.ColumnMappings.Add("ItemId", "ItemId");

                Console.WriteLine("Starting SQL Bulk Insert...");
                bulkCopy.WriteToServer(data);
            }
        }
    }
}