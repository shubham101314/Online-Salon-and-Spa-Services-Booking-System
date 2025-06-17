using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication1
{
    public partial class shaving : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBeardStyles();
            }
        }

        private void LoadBeardStyles()
        {
            string connectionString = @"Data Source=DESKTOP-PITMH04;Initial Catalog=saloondb;Integrated Security=True";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT BeardID, Name, ImagePath, Price FROM Beard";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    rptBeards.DataSource = cmd.ExecuteReader();
                    rptBeards.DataBind();
                }
            }
        }
    }
}
