 
//dotnet add package Microsoft.Data.SqlClient;
//Install-Package Microsoft.Data.SqlClient

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using Microsoft.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CustomerGridEntry
{
    public partial class frmCustGridEntry : Form
    {
        private SqlConnection connection;
        private SqlDataAdapter dataAdapter;
        private DataTable dataTable;
        public frmCustGridEntry()
        {
            InitializeComponent();
            InitializeDatabaseConnection();
            LoadDataIntoGrid();
        }

        private void InitializeDatabaseConnection()
        {
            // Replace with your actual connection string
            string connectionString = "Data Source=HYPE\\SQL_2022;Initial Catalog=OLTP;User ID=sa;Password=D@1ry$2014";
            connection = new SqlConnection(connectionString);
        }S

        private void LoadDataIntoGrid()
        {
            try
            {
                connection.Open();
                // Replace 'YourTable' with your actual table name
                string selectQuery = "SELECT * FROM YourTable";
                dataAdapter = new SqlDataAdapter(selectQuery, connection);
                dataTable = new DataTable();
                dataAdapter.Fill(dataTable);
                dataGridView1.DataSource = dataTable;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error loading data: " + ex.Message);
            }
            finally
            {
                if (connection.State == ConnectionState.Open)
                {
                    connection.Close();
                }
            }
        }
        private void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                SqlCommandBuilder commandBuilder = new SqlCommandBuilder(dataAdapter);
                dataAdapter.Update(dataTable);
                MessageBox.Show("Changes saved successfully!");
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error saving changes: " + ex.Message);
            }
        }
        private void frmCustGridEntry_Load(object sender, EventArgs e)
        {

        }
    }
}