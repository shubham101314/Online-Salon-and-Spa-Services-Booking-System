using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication1
{
    public partial class haircut : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadHaircuts();
            }
        }

        private void LoadHaircuts()
        {
            string connectionString = @"Data Source=DESKTOP-PITMH04;Initial Catalog=saloondb;Integrated Security=True";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT HaircutID, Name, ImagePath, Price FROM Haircuts";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    rptHaircuts.DataSource = cmd.ExecuteReader();
                    rptHaircuts.DataBind();
                }
            }
        }
    }
}
