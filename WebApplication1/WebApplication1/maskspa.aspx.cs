using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication1
{
    public partial class maskspa : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMaskSpaServices();
            }
        }

        private void LoadMaskSpaServices()
        {
            string connectionString = @"Data Source=DESKTOP-PITMH04;Initial Catalog=saloondb;Integrated Security=True";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT MaskSpaID, Name, ImagePath, Price FROM MaskSpa";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    try
                    {
                        conn.Open();
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);

                            rptMaskSpa.DataSource = dt.Rows.Count > 0 ? dt : null;
                            rptMaskSpa.DataBind();
                        }
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine("Database Error: " + ex.Message);
                    }
                }
            }
        }
    }
}
