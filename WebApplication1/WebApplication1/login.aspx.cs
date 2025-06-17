using System;
using System.Data.SqlClient;
using System.Web.UI;
using System.Text.RegularExpressions;

namespace WebApplication1
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (!IsValidEmail(email))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "invalidEmail",
                    "document.getElementById('emailError').innerText = 'Please enter a valid email address.';", true);
                return;
            }

            if (string.IsNullOrEmpty(password) || password.Length < 6)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "invalidPassword",
                    "document.getElementById('passwordError').innerText = 'Password must be at least 6 characters long.';", true);
                return;
            }

            // Database authentication
            string connectionString = @"Data Source=DESKTOP-PITMH04;Initial Catalog=saloondb;Integrated Security=True;";

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "SELECT COUNT(*) FROM Users WHERE Email = @Email AND Password = @Password";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Password", password);

                        int count = (int)cmd.ExecuteScalar();
                        if (count == 1)
                        {
                            Session["UserEmail"] = email;
                            Response.Redirect("homepage_0.aspx");
                        }
                        else
                        {
                            // Show error message inside password field
                            ScriptManager.RegisterStartupScript(this, GetType(), "invalidLogin",
                                "document.getElementById('passwordError').innerText = 'Incorrect password!';", true);

                            // Add shake animation
                            ScriptManager.RegisterStartupScript(this, GetType(), "shake",
                                "$('.login-container').addClass('shake'); setTimeout(function(){$('.login-container').removeClass('shake');}, 500);", true);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Login error: {ex.Message}");
                ScriptManager.RegisterStartupScript(this, GetType(), "error",
                    "alert('An error occurred during login. Please try again.');", true);
            }
        }

        private bool IsValidEmail(string email)
        {
            return Regex.IsMatch(email, @"^[^@\s]+@[^@\s]+\.[^@\s]+$");
        }
    }
}
