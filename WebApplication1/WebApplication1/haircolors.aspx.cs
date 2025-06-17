using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication1
{
    public partial class haircolors : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadHairColors();
            }
        }

        private void LoadHairColors()
        {
            string connectionString = @"Data Source=DESKTOP-PITMH04;Initial Catalog=saloondb;Integrated Security=True";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT HairColorID, Name, ImagePath, Price FROM HairColors";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    rptHairColors.DataSource = cmd.ExecuteReader();
                    rptHairColors.DataBind();
                }
            }
        }
    }
}
