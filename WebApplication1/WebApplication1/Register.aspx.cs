using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication1
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim().ToLower(); // Convert email to lowercase
            string password = txtPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();

            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "error", "alert('All fields are required.');", true);
                return;
            }

            if (password.Length < 8)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "error", "alert('Password must be at least 8 characters long.');", true);
                return;
            }

            if (password != confirmPassword)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "error", "alert('Passwords do not match.');", true);
                return;
            }

            string connectionString = "Data Source=DESKTOP-PITMH04;Initial Catalog=saloondb;Integrated Security=True";

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string checkEmailQuery = "SELECT COUNT(*) FROM Users WHERE LOWER(Email) = @Email";
                    using (SqlCommand cmd = new SqlCommand(checkEmailQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@Email", email);
                        int count = (int)cmd.ExecuteScalar();

                        if (count > 0)
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "error", "alert('Email already exists.');", true);
                        }
                        else
                        {
                            string insertQuery = "INSERT INTO Users (Name, Email, Password) VALUES (@Name, @Email, @Password)";
                            using (SqlCommand insertCmd = new SqlCommand(insertQuery, conn))
                            {
                                insertCmd.Parameters.AddWithValue("@Name", name);
                                insertCmd.Parameters.AddWithValue("@Email", email);
                                insertCmd.Parameters.AddWithValue("@Password", password);

                                insertCmd.ExecuteNonQuery();
                                Response.Redirect("login.aspx");
                            }
                        }
                    }
                }
            }
            catch (Exception)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "error", "alert('An error occurred. Try again.');", true);
            }
        }
    }
}
