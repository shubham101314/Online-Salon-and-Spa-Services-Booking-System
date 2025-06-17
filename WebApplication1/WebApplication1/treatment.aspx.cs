using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication1
{
    public partial class treatment : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadTreatmentData();
            }
        }

        private void LoadTreatmentData()
        {
            string connectionString = @"Data Source=DESKTOP-PITMH04;Initial Catalog=saloondb;Integrated Security=True";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT TreatmentID, Name, ImagePath, Price FROM Treatment";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    try
                    {
                        conn.Open();
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);

                            rptTreatment.DataSource = dt.Rows.Count > 0 ? dt : null;
                            rptTreatment.DataBind();
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
