using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication1
{
    public partial class facials : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadFacialServices();
            }
        }

        private void LoadFacialServices()
        {
            string connectionString = @"Data Source=DESKTOP-PITMH04;Initial Catalog=saloondb;Integrated Security=True";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT FacialID, Name, ImagePath, Price FROM Facials";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    rptFacials.DataSource = cmd.ExecuteReader();
                    rptFacials.DataBind();
                }
            }
        }
    }
}
