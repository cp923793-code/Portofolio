using System;
using System.Collections.Generic;
using System.ComponentModel;
using Microsoft.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PODetail
{
    public partial class FormPO : Form
    {
        // Connection string (modify as needed)
        private string connectionString = "Server=hype\\sql_2022;Database=OLTP;User Id=sa;Password=D@1ry$2014;";
        private DataTable dtPODetails;
        private bool isLoadingData = false; // Add this flag
        private SqlDataAdapter daPODetails; // Add the DataAdapter here
        public FormPO()
        {
            InitializeComponent();
            InitializeDataGridView();
        }

        private void InitializeDataGridView()
        {
            // Configure DataGridView columns
            dgvPODetails.AutoGenerateColumns = false; // Manually add columns for control

            // ItemID column (editable)
            DataGridViewTextBoxColumn itemidColumn = new DataGridViewTextBoxColumn();
            itemidColumn.DataPropertyName = "ItemID";
            itemidColumn.HeaderText = "Item ID";
            dgvPODetails.Columns.Add(itemidColumn);

            // ItemDescription column (read-only)
            DataGridViewTextBoxColumn descColumn = new DataGridViewTextBoxColumn();
            descColumn.DataPropertyName = "ItemName";
            descColumn.HeaderText = "Item Name";
            descColumn.ReadOnly = true;
            dgvPODetails.Columns.Add(descColumn);

            // Qty column (editable)
            DataGridViewTextBoxColumn qtyColumn = new DataGridViewTextBoxColumn();
            qtyColumn.DataPropertyName = "Qty";
            qtyColumn.HeaderText = "Quantity";
            //qtyColumn.ValueType = typeof(decimal); // Explicitly set to decimal type
            dgvPODetails.Columns.Add(qtyColumn);

            // Price column (editable)
            DataGridViewTextBoxColumn priceColumn = new DataGridViewTextBoxColumn();
            priceColumn.DataPropertyName = "Price";
            priceColumn.HeaderText = "Price";
            //qtyColumn.ValueType = typeof(decimal); // Explicitly set to decimal type
            dgvPODetails.Columns.Add(priceColumn);

            // Amount column (read-only and calculated)
            DataGridViewTextBoxColumn amountColumn = new DataGridViewTextBoxColumn();
            amountColumn.DataPropertyName = "Amount";
            amountColumn.HeaderText = "Amount";
            amountColumn.ReadOnly = true;
            dgvPODetails.Columns.Add(amountColumn);

            // Handle cell changes and adding new rows
            dgvPODetails.CellEndEdit += dgvPODetails_CellEndEdit;
            dgvPODetails.RowsAdded += dgvPODetails_RowsAdded;
           // dgvPODetails.UserAddedRow += dgvPODetails_UserAddedRow;
        }

        // Handle adding new rows to the grid
        private void dgvPODetails_RowsAdded(object sender, DataGridViewRowsAddedEventArgs e)
        {

            // Add check to ensure we are not during initial load, and that the POid textbox has a value
            if (isLoadingData || string.IsNullOrEmpty(txtPOId.Text.Trim()))
            {
                return;
            }

            // Check if the added row is the DGV's new row template itself (which might be index Count-1 before it's actual data row in DataTable)
            // The DataGridView.Rows.Count will include the 'new row' placeholder if AllowUserToAddRows is true
            // Need to handle accessing the actual DataRow corresponding to the DGV row

            // The original logic was accessing the DataTable by DGV index, which might be the issue if DataTable.Rows.Count differs from DGV.Rows.Count at that instant.
            // Let's refine the logic to work with the DataTable directly if possible.

            // A simpler approach for the RowsAdded event when bound to a DataTable:
            // This event fires *after* the new DataRow is added to the DataTable via the DGV UI.
            // The previous implementation was fine provided we handle the initial load state.

            for (int i = e.RowIndex; i < e.RowIndex + e.RowCount; i++)
            {
                if (i < dtPODetails.Rows.Count) // Ensure the index is within DataTable bounds
                {
                    DataRow newRow = dtPODetails.Rows[i];
                    if (newRow["POID"] == DBNull.Value || string.IsNullOrEmpty(newRow["POID"].ToString()))
                    {
                        newRow["POID"] = txtPOId.Text.Trim();
                    }
                }
            }
        }

        
        // --- Load Button Logic ---
        private void btnLoad_Click(object sender, EventArgs e)
        {
            string poid =  txtPOId.Text.Trim();
            if (string.IsNullOrEmpty(poid))
            {
                MessageBox.Show("Please enter a PO ID.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            if (POidExists(poid))
            {
                LoadPODetails(poid);
                lblStatus.Text = "PO details loaded.";
            }
            else
            {
                dgvPODetails.DataSource = null; // Empty the grid
                dtPODetails = null;
                MessageBox.Show("PO ID not found in PO Header.", "Not Found", MessageBoxButtons.OK, MessageBoxIcon.Information);
                lblStatus.Text = "PO ID not found.";
            }
        }

        private bool POidExists(string poid)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string query = "SELECT COUNT(1) FROM POHeader WHERE POID = @POid";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@POid", poid);
                    int count = (int)cmd.ExecuteScalar();
                    return count > 0;
                }
            }
        }

        private void LoadPODetails(string poid)
        {
            isLoadingData = true;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                // Select query can remain with the JOIN for display purposes
                string selectQuery = @"
            SELECT pd.ItemID, im.ItemName AS ItemName, pd.Qty, pd.Price, pd.Amount, pd.POid 
            FROM PODetail pd
            JOIN ItemMaster im ON pd.ItemID = im.ItemID
            WHERE pd.POid = @POid";

                // Initialize the DataAdapter with the select command
                daPODetails = new SqlDataAdapter(selectQuery, con);
                daPODetails.SelectCommand.Parameters.AddWithValue("@POid", poid);

                dtPODetails = new DataTable();
                daPODetails.Fill(dtPODetails);

                // --- Remove all SqlCommandBuilder lines here ---
                // e.g., daPODetails.InsertCommand = builder.GetInsertCommand(); // Delete this
            }

            dgvPODetails.DataSource = dtPODetails;
            isLoadingData = false;
        }


        // --- DataGridView Events for dynamic updates ---

        // When a cell value changes (Qty or Price or ItemID)
        /* private void dgvPODetails_CellValueChanged(object sender, DataGridViewCellEventArgs e)
        private void dgvPODetails_CellValueChanged(object sender, DataGridViewCellEventArgs e)
        {
            // Add checks for valid row index and data loading state
            
            if (isLoadingData || e.RowIndex < 0 || e.RowIndex >= dtPODetails.Rows.Count)
            {
                return;
            } 
            //if (e.RowIndex >= 0 && dtPODetails != null)
            //{
                DataRow row = dtPODetails.Rows[e.RowIndex];
                string columnName = dgvPODetails.Columns[e.ColumnIndex].DataPropertyName;

                if (columnName == "ItemID")
                {
                    // Retrieve item description from master table
                    string itemid = row["ItemID"].ToString();
                    string description = GetItemDescription(itemid); // Implement this method
                    row["ItemName"] = description ?? "Invalid Item";
                }

                // Recalculate amount
                if (columnName == "Qty" || columnName == "Price" || columnName == "ItemID")
                {
                    if (decimal.TryParse(row["Qty"].ToString(), out decimal qty) && decimal.TryParse(row["Price"].ToString(), out decimal price))
                    {
                        row["Amount"] = qty * price;
                    }
                }
            //}
        } */

        private void dgvPODetails_CellEndEdit(object sender, DataGridViewCellEventArgs e)
        {
            // Basic checks to ensure a valid DataRow is targeted
            if (dgvPODetails.Rows[e.RowIndex].IsNewRow) return;
            if (dtPODetails == null || e.RowIndex < 0 || e.RowIndex >= dtPODetails.Rows.Count) return;

            DataRow row = dtPODetails.Rows[e.RowIndex];
            string editedColumnName = dgvPODetails.Columns[e.ColumnIndex].DataPropertyName;

            // --- 1. Ensure ItemName is populated if ItemID exists ---
            // This check runs regardless of which cell (Qty, Price, or ItemID) was just edited,
            // as long as an ItemID value is available in the row.
            if (row["ItemID"] != DBNull.Value && !string.IsNullOrEmpty(row["ItemID"].ToString()))
            {
                string itemid = row["ItemID"].ToString();
                string currentItemName = row["ItemName"].ToString();

                // Only perform the expensive DB lookup if the ID just changed OR the Name is currently blank/invalid
                if (editedColumnName == "ItemID" || string.IsNullOrEmpty(currentItemName) || currentItemName == "INVALID")
                {
                    string name = GetItemDescription(itemid);

                    if (string.IsNullOrEmpty(name))
                    {
                        row["ItemName"] = "INVALID";
                    }
                    else
                    {
                        row["ItemName"] = name;
                    }
                }
            }

            // --- 2. Recalculate Amount ---
            // This runs if any relevant column was just edited
            if (editedColumnName == "Qty" || editedColumnName == "Price" || editedColumnName == "ItemID")
            {
                if (decimal.TryParse(row["Qty"].ToString(), out decimal qty) && decimal.TryParse(row["Price"].ToString(), out decimal price))
                {
                    row["Amount"] = qty * price;
                }
            }

            // --- 3. Force UI Refresh of the entire row ---
            // This is vital for showing updates in ReadOnly cells immediately
            dgvPODetails.InvalidateRow(e.RowIndex);

        }


        // Helper method to get item description (to be implemented)
        private string GetItemDescription(string itemid)
        {
            // Create a NEW SqlConnection object locally using the class-level connectionString variable
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                // Assuming the column name is 'ItemName' based on previous conversation
                string query = "SELECT ItemName FROM ItemMaster WHERE ItemID = @ItemID";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ItemID", itemid);
                    object result = cmd.ExecuteScalar();
                    return result?.ToString();
                }
            }
        }


        // --- Save Button Logic ---
        private void btnSave_Click(object sender, EventArgs e)
        {
            if (dtPODetails == null || dtPODetails.Rows.Count == 0)
            {
                // ... (validation code) ...
            }

            // Force pending DGV actions to commit to the DataTable
            dgvPODetails.EndEdit();
            this.BindingContext[dtPODetails].EndCurrentEdit();

            string currentPOid = txtPOId.Text.Trim();

            // Ensure all new/modified rows have the POid assigned
            foreach (DataRow row in dtPODetails.Rows)
            {
                if (row.RowState != DataRowState.Deleted && (row["POid"] == DBNull.Value || string.IsNullOrEmpty(row["POid"].ToString())))
                {
                    row["POid"] = currentPOid;
                }
            }

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                SqlTransaction transaction = con.BeginTransaction();

                try
                {
                    // Iterate manually to execute commands
                    foreach (DataRow row in dtPODetails.Rows)
                    {
                        // Use MERGE/INSERT/UPDATE for added/modified rows targeting PODetail table
                        if (row.RowState == DataRowState.Added || row.RowState == DataRowState.Modified)
                        {
                            string saveQuery = @"MERGE INTO PODetail AS target
                                     USING (SELECT @POid AS POid, @ItemID AS ItemID, @Qty AS Qty, @Price AS Price, @Amount AS Amount) AS source
                                     ON target.POid = source.POid AND target.ItemID = source.ItemID
                                     WHEN MATCHED THEN
                                         UPDATE SET Qty = source.Qty, Price = source.Price, Amount = source.Amount
                                     WHEN NOT MATCHED THEN
                                         INSERT (POid, ItemID, Qty, Price, Amount) VALUES (source.POid, source.ItemID, source.Qty, source.Price, source.Amount);";
                            using (SqlCommand cmd = new SqlCommand(saveQuery, con, transaction))
                            {
                                cmd.Parameters.AddWithValue("@POid", row["POid"]);
                                cmd.Parameters.AddWithValue("@ItemID", row["ItemID"]);
                                cmd.Parameters.AddWithValue("@Qty", row["Qty"]);
                                cmd.Parameters.AddWithValue("@Price", row["Price"]);
                                cmd.Parameters.AddWithValue("@Amount", row["Amount"]);
                                cmd.ExecuteNonQuery();
                            }
                        }
                        else if (row.RowState == DataRowState.Deleted)
                        {
                            // Use DELETE logic targeting only the PODetail table
                            string deleteQuery = "DELETE FROM PODetail WHERE POid = @OriginalPOid AND ItemID = @OriginalItemID";
                            using (SqlCommand cmd = new SqlCommand(deleteQuery, con, transaction))
                            {
                                cmd.Parameters.AddWithValue("@OriginalPOid", row["POid", DataRowVersion.Original]);
                                cmd.Parameters.AddWithValue("@OriginalItemID", row["ItemID", DataRowVersion.Original]);
                                cmd.ExecuteNonQuery();
                            }
                        }
                    }

                    // 2. Recalculate amount in POHeader
                    string updateHeaderQuery = @"
                UPDATE POHeader
                SET Amount = (SELECT SUM(Amount) FROM PODetail WHERE POid = @POid)
                WHERE POid = @POid";
                    using (SqlCommand cmd = new SqlCommand(updateHeaderQuery, con, transaction))
                    {
                        cmd.Parameters.AddWithValue("@POid", txtPOId.Text.Trim());
                        cmd.ExecuteNonQuery();
                    }

                    transaction.Commit();
                    dtPODetails.AcceptChanges(); // Commit local changes

                    MessageBox.Show("Data saved and PO header updated successfully!", "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    lblStatus.Text = "Saved.";
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    dtPODetails.RejectChanges(); // Rollback local changes
                    MessageBox.Show("Save failed: " + ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    lblStatus.Text = "Save failed.";
                }
            }
        }

        private void FormPO_Load(object sender, EventArgs e)
        {

        }


    }
}
