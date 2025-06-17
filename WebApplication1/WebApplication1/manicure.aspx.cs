using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication1
{
    public partial class manicure : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadManicureServices();
            }
        }

        private void LoadManicureServices()
        {
            string connectionString = @"Data Source=DESKTOP-PITMH04;Initial Catalog=saloondb;Integrated Security=True";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT ManicureID, Name, ImagePath, Price FROM Manicure";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        rptManicure.DataSource = dt;
                        rptManicure.DataBind();
                    }
                }
            }
        }
    }
}
