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
        //Encoding.RegisterProvider(CodePagesEncodingProvider.Instance);
        System.Text.Encoding.RegisterProvider(System.Text.CodePagesEncodingProvider.Instance);

        // --- Configuration ---
        string excelFilePath = @"c:\Etl_Danone\KaryaSuksesPrima\sales.xls";
        string distributorCode = "123456";
        // REMINDER: Update YourSqlServerName in the connection string
        string connectionString = "Data Source=HYPE\\SQL_2022;Initial Catalog=DWH;User ID=sa;Password=D@1ry$2014";

        string targetTableName = "Sales"; // Table name is lowercase in your SQL
        int prodNameColumnIndex = 2; // Column C for ItemId/ProdName
        int custIdColumnIndex = 10; // Column K for CustId
        int maxBlankRows = 29;

        if (!File.Exists(excelFilePath))
        {
            Console.WriteLine($"Error: File not found at {excelFilePath}");
            return;
        }

        try
        {
            DataTable salesData = ReadExcelData(excelFilePath, prodNameColumnIndex, custIdColumnIndex, maxBlankRows, distributorCode);
            if (salesData.Rows.Count > 0)
            {
                BulkInsertToSql(salesData, connectionString, targetTableName);
                Console.WriteLine($"Successfully imported {salesData.Rows.Count} rows into SQL Server.");
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

    private static DataTable ReadExcelData(string filePath, int prodNameColIndex, int custIdColIndex, int maxBlankRows, string distCode)
    {
        var resultTable = new DataTable();
        // Updated DataTable Columns to match the new SQL Schema
        resultTable.Columns.Add("DistCode", typeof(string));
        resultTable.Columns.Add("InvDate", typeof(DateTime));
        resultTable.Columns.Add("InvNo", typeof(string));
        resultTable.Columns.Add("CustId", typeof(string));
        resultTable.Columns.Add("ItemId", typeof(string));
        resultTable.Columns.Add("Qty", typeof(long)); // Changed to long (numeric(10,0))

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
                        if (reader.GetValue(prodNameColIndex)?.ToString().Trim().Equals("NMBR", StringComparison.OrdinalIgnoreCase) ?? false)
                        {
                            foundHeader = true;
                        }
                        continue;
                    }

                    if (string.IsNullOrWhiteSpace(reader.GetValue(prodNameColIndex)?.ToString()))
                    {
                        blankCellCount++;
                        if (blankCellCount >= maxBlankRows) { break; }
                        continue;
                    }
                    else { blankCellCount = 0; }

                    DataRow newRow = resultTable.NewRow();
                    newRow["DistCode"] = distCode;

                    // Column Mappings: A=TransDate, B=InvNo/InvDate, C=ProdName(ItemId), D=Qty, K=CustId
                    // Assuming Excel Col A is your InvDate/TransDate
                    newRow["InvDate"] = GetValueOrDefault<DateTime>(reader, 0);
                    // Assuming Excel Col B is your InvNo
                    newRow["InvNo"] = GetValueOrDefault<string>(reader, 1);
                    newRow["ItemId"] = GetValueOrDefault<string>(reader, 2); // ProdName column in Excel is ItemId in SQL
                    newRow["Qty"] = GetValueOrDefault<long>(reader, 3); // Must be long to match numeric(10,0)
                    newRow["CustId"] = GetValueOrDefault<string>(reader, custIdColIndex); // Column K

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
                bulkCopy.ColumnMappings.Add("InvDate", "InvDate");
                bulkCopy.ColumnMappings.Add("InvNo", "InvNo");
                bulkCopy.ColumnMappings.Add("CustId", "CustId");
                bulkCopy.ColumnMappings.Add("ItemId", "ItemId");
                bulkCopy.ColumnMappings.Add("Qty", "Qty");

                Console.WriteLine("Starting SQL Bulk Insert...");
                bulkCopy.WriteToServer(data);
            }
        }
    }
}
