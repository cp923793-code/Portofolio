// See https://aka.ms/new-console-template for more information
dotnet add package Microsoft.Data.SqlClient;
using System;
using Microsoft.Data.SqlClient; // Use Microsoft.Data.SqlClient for modern .NET applications
//using System.Data.SqlClient;
public class SqlConnectionTester
{
    public static void Main(string[] args)
    {
        // Define your connection string
        // IMPORTANT: Replace with your actual server, database, user ID, and password
        // Consider using a secure method for storing credentials in a real application
        string connectionString = "Server=HYPE\\SQL_2022;Database=OLTP;User ID=sa;Password=D@1ry$2014;TrustServerCertificate=True;";

        Console.WriteLine("Attempting to connect to SQL Server...");

        try
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                Console.WriteLine("Successfully connected to SQL Server!");

                // You can optionally execute a simple query to further test the connection
                string query = "SELECT GETDATE()";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    DateTime serverTime = (DateTime)command.ExecuteScalar();
                    Console.WriteLine($"Current server time: {serverTime}");
                }
            }
        }
        catch (SqlException ex)
        {
            Console.WriteLine($"SQL Connection Error: {ex.Message}");
            Console.WriteLine($"Error Code: {ex.Number}");
        }
        catch (Exception ex)
        {
            Console.WriteLine($"General Error: {ex.Message}");
        }

        Console.WriteLine("Press any key to exit.");
        Console.ReadKey();
    }
}