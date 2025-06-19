using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication1
{
    public partial class waxing : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadWaxingServices();
            }
        }

        private void LoadWaxingServices()
        {
            string connectionString = @"Data Source=DESKTOP-PITMH04;Initial Catalog=saloondb;Integrated Security=True";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT WaxingID, Name, ImagePath, Price FROM Waxing";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    rptWaxing.DataSource = cmd.ExecuteReader();
                    rptWaxing.DataBind();
                }
            }
        }
    }
}
