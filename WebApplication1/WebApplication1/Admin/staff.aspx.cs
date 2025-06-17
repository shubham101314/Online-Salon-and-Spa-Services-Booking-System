using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1.Admin
{
    public partial class staff : System.Web.UI.Page
    {
        // Connection string from web.config
        private string connectionString = "Data Source=DESKTOP-PITMH04;Initial Catalog=saloondb;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check for any success messages in the session
                if (Session["SuccessMessage"] != null)
                {
                    DisplayMessage(Session["SuccessMessage"].ToString(), true);
                    Session["SuccessMessage"] = null; // Clear the message
                }

                // Load stylists data when page first loads
                BindStylistsData();
            }
        }

        // Method to bind data to GridView
        private void BindStylistsData()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT StylistID, Name FROM Stylists ORDER BY Name", conn))
                {
                    try
                    {
                        conn.Open();
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        gvStylists.DataSource = dt;
                        gvStylists.DataBind();
                    }
                    catch (Exception ex)
                    {
                        lblMessage.CssClass = "text-danger";
                        lblMessage.Text = "Error loading stylists: " + ex.Message;
                    }
                }
            }
        }

        private void DisplayMessage(string message, bool isSuccess)
        {
            messageContainer.Visible = true;
            lblMessage.Text = message;

            if (isSuccess)
            {
                messageContainer.Attributes["class"] = "success-message";
                lblMessage.CssClass = "text-success";
            }
            else
            {
                messageContainer.Attributes["class"] = "error-message";
                lblMessage.CssClass = "text-danger";
            }
        }
        protected void btnAddStylist_Click(object sender, EventArgs e)
        {
            string stylistName = txtStylistName.Text.Trim();

            if (string.IsNullOrEmpty(stylistName))
            {
                DisplayMessage("Stylist name cannot be empty.", false);
                return;
            }

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("INSERT INTO Stylists (Name) VALUES (@Name)", conn))
                {
                    try
                    {
                        cmd.Parameters.AddWithValue("@Name", stylistName);

                        conn.Open();
                        int result = cmd.ExecuteNonQuery();

                        if (result > 0)
                        {
                            // Store success message in session
                            Session["SuccessMessage"] = "Stylist added successfully!";

                            // Redirect to same page (GET request)
                            Response.Redirect(Request.Url.PathAndQuery, false);
                            Context.ApplicationInstance.CompleteRequest();
                            return;
                        }
                        else
                        {
                            DisplayMessage("Failed to add stylist.", false);
                        }
                    }
                    catch (Exception ex)
                    {
                        DisplayMessage("Error adding stylist: " + ex.Message, false);
                    }
                }
            }
        }

        // Handle row commands (delete)
        protected void gvStylists_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteStylist")
            {
                int stylistId = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("DELETE FROM Stylists WHERE StylistID = @StylistID", conn))
                    {
                        try
                        {
                            cmd.Parameters.AddWithValue("@StylistID", stylistId);

                            conn.Open();
                            int result = cmd.ExecuteNonQuery();

                            if (result > 0)
                            {
                                lblMessage.CssClass = "text-success";
                                lblMessage.Text = "Stylist deleted successfully!";
                                BindStylistsData(); // Refresh the grid
                            }
                            else
                            {
                                lblMessage.CssClass = "text-danger";
                                lblMessage.Text = "Failed to delete stylist.";
                            }
                        }
                        catch (Exception ex)
                        {
                            lblMessage.CssClass = "text-danger";
                            lblMessage.Text = "Error deleting stylist: " + ex.Message;
                        }
                    }
                }
            }
        }
    }
}