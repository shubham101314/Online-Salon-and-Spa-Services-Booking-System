using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1.Admin
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnAdminLogin_Click(object sender, EventArgs e)
        {
            string email = txtAdminEmail.Text.Trim();
            string password = txtAdminPassword.Text.Trim();

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

            // Database authentication for admin
            string connectionString = @"Data Source=DESKTOP-PITMH04;Initial Catalog=saloondb;Integrated Security=True;";
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "SELECT COUNT(*) FROM AdminUsers WHERE Email = @Email AND Password = @Password";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Password", password);
                        int count = (int)cmd.ExecuteScalar();

                        if (count == 1)
                        {
                            Session["AdminEmail"] = email;
                            Response.Redirect("dashboard.aspx");
                        }
                        else
                        {
                            // Show error message
                            ScriptManager.RegisterStartupScript(this, GetType(), "invalidLogin",
                                "document.getElementById('passwordError').innerText = 'Incorrect admin credentials!';", true);
                            // Add shake animation
                            ScriptManager.RegisterStartupScript(this, GetType(), "shake",
                                "$('.login-container').addClass('shake'); setTimeout(function(){$('.login-container').removeClass('shake');}, 500);", true);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Admin login error: {ex.Message}");
                ScriptManager.RegisterStartupScript(this, GetType(), "error",
                    "alert('An error occurred during admin login. Please try again.');", true);
            }
        }

        private bool IsValidEmail(string email)
        {
            return Regex.IsMatch(email, @"^[^@\s]+@[^@\s]+\.[^@\s]+$");
        }
    }
}