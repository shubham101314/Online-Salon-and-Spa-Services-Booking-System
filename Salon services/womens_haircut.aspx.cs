using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication1
{
    public partial class womens_haircut : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadWomensHaircuts();
            }
        }

        private void LoadWomensHaircuts()
        {
            string connectionString = @"Data Source=DESKTOP-PITMH04;Initial Catalog=saloondb;Integrated Security=True";
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT WHaircutID, Name, ImagePath, Price FROM WomensHaircuts";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    rptWomensHaircuts.DataSource = cmd.ExecuteReader();
                    rptWomensHaircuts.DataBind();
                }
            }
        }
    }
}