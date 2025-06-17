using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication1
{
    public partial class threading : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadThreading();
            }
        }

        private void LoadThreading()
        {
            string connectionString = @"Data Source=DESKTOP-PITMH04;Initial Catalog=saloondb;Integrated Security=True";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT ThreadingID, Name, ImagePath, Price FROM Threading";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    try
                    {
                        conn.Open();
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);

                            rptThreading.DataSource = dt.Rows.Count > 0 ? dt : null;
                            rptThreading.DataBind();
                        }
                    }
                    catch (Exception ex)
                    {
                        // Display an error message in the console (or log it in a real scenario)
                        Console.WriteLine("Database Error: " + ex.Message);
                    }
                }
            }
        }
    }
}
