using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication1
{
    public partial class nailart : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadNailArt();
            }
        }

        private void LoadNailArt()
        {
            string connectionString = @"Data Source=DESKTOP-PITMH04;Initial Catalog=saloondb;Integrated Security=True";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT NailArtID, Name, ImagePath, Price FROM NailArt";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        rptNailArt.DataSource = dt;
                        rptNailArt.DataBind();
                    }
                }
            }
        }
    }
}
