using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1.Admin
{
    public partial class Site2 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Logout_Click(object sender, EventArgs e)
        {
            // Copy the same logout logic from your Site1.Master.cs
            // For example:
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Login.aspx");
        }
    }

}