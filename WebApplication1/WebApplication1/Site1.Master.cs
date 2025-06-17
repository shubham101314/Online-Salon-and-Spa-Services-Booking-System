using System;
using System.Web;

namespace WebApplication1
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CheckUserLoginStatus();
            }
        }

        /// <summary>
        /// Checks if the user is logged in and updates the UI accordingly.
        /// </summary>
        private void CheckUserLoginStatus()
        {
            if (Session["UserEmail"] != null)
            {
                // User is logged in, show logout panel and set email
                lnkLogin.Visible = false;
                loggedInPanel.Visible = true;
                lblUserEmail.Text = Session["UserEmail"].ToString();
            }
            else
            {
                // User is not logged in, show login button
                lnkLogin.Visible = true;
                loggedInPanel.Visible = false;
            }
        }

        /// <summary>
        /// Handles the logout action, clears session, and redirects to login page.
        /// </summary>
        protected void Logout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}
