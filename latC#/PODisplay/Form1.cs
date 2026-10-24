//using System.Data;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PODisplay
{
    public partial class Form1 : Form
    {
        
        public Form1()
        {
            InitializeComponent();
        }
        private void btnLoadDetails_Click(object sender, EventArgs e)
        {
            // Ensure the POID text box is not empty
            if (!string.IsNullOrEmpty(txtPOID.Text))
            {
                LoadPODetails(txtPOID.Text);
            }
            else
            {
                MessageBox.Show("Please enter a POID.");
            }
        }

        private void ConfigureDataGridViewColumns()
        {
            // Ensure AutoGenerateColumns is true or manually define all columns first

            // Make "Description", "Qty", "Price", and "Amount" columns read-only
            // Adjust column names to match your DataTable column names
            if (dataGridView1.Columns.Contains("Description"))
            {
                dataGridView1.Columns["Description"].ReadOnly = true;
            }
            if (dataGridView1.Columns.Contains("Amount"))
            {
                dataGridView1.Columns["Amount"].ReadOnly = true;
            }
        }
        private void LoadPODetails(string poID)
        {
            // SQL query to select data from the PODetail table where POID matches the textbox value
            // Using a parameterized query prevents SQL injection
            // Define your connection string here
            string connectionString = "Data Source=HYPE\\SQL_2022;Initial Catalog=OLTP;User ID=sa;Password=D@1ry$2014";
            string query = @"
                SELECT  pd.ItemID, im.ItemName as Description, pd.Qty, pd.Price
                FROM  PODetail pd
                JOIN ItemMaster im ON pd.ItemID = im.ItemID
                WHERE pd.POID = @POID";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Add the parameter for the POID textbox value
                    command.Parameters.AddWithValue("@POID", poID);

                    // Use a SqlDataAdapter to fill a DataTable
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dataTable = new DataTable();

                    try
                    {
                        connection.Open();
                        adapter.Fill(dataTable);
                        // Add the calculated "Amount" column to the DataTable
                        dataTable.Columns.Add("Amount", typeof(decimal));
                        foreach (DataRow row in dataTable.Rows)
                        {
                            decimal qty = Convert.ToDecimal(row["Qty"]);
                            decimal price = Convert.ToDecimal(row["Price"]);
                            row["Amount"] = qty * price;
                        }

                        // Bind the DataTable to the DataGridView
                        dataGridView1.DataSource = dataTable;
                        // Configure columns in the DataGridView
                        ConfigureDataGridViewColumns();
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show("Error loading data: " + ex.Message);
                    }
                }
            }
        }

        private void dataGridView1_CellEndEdit(object sender, DataGridViewCellEventArgs e)
        {
            // Check if the edited cell was Qty or ItemCode
            if (dataGridView1.Columns[e.ColumnIndex].Name == "Qty" || dataGridView1.Columns[e.ColumnIndex].Name == "ItemCode")
            {
                DataGridViewRow row = dataGridView1.Rows[e.RowIndex];

                // Ensure ItemCode and Qty have values before processing
                if (row.Cells["ItemCode"].Value != null && row.Cells["Qty"].Value != null)
                {
                    string itemCode = row.Cells["ItemCode"].Value.ToString();
                    // Get item details for the new/edited item
                    DataRow itemMasterRow = GetItemDetails(itemCode);

                    if (itemMasterRow != null)
                    {
                        // Auto-populate description and price
                        row.Cells["Description"].Value = itemMasterRow["Description"];
                        row.Cells["Price"].Value = itemMasterRow["Price"];

                        // Calculate amount for the specific row
                        // Directly manipulate the cell values here if not using DataTable expressions
                        decimal price = Convert.ToDecimal(row.Cells["Price"].Value);
                        int qty = Convert.ToInt32(row.Cells["Qty"].Value);
                        row.Cells["Amount"].Value = price * qty; //
                    }
                }
            }
        }

        private DataRow GetItemDetails(string itemCode)
        {
            // Implement your database call to retrieve the single item's details (Description, Price)
            // using a query like "SELECT Description, Price FROM ItemMaster WHERE ItemCode = @ItemCode"
            // Return a DataRow or a custom object with the details.

            // Placeholder for database operation:
            // In a real scenario, this would involve a database query. 
            // For this example, assume you get a row back:
            DataTable itemTable = new DataTable();
            // Fill itemTable from DB...
            // Example: itemTable.Rows.Add("ItemA", "Description A", 10.50m);

            // Assuming you have the logic to return the specific DataRow
            // For demonstration, just return dummy data
            DataRow dummyRow = itemTable.NewRow();
            dummyRow["Description"] = "Sample Description";
            dummyRow["Price"] = 10.50m;
            return dummyRow;
        }
        private void Form1_Load(object sender, EventArgs e)
        {

        }


    }
}
