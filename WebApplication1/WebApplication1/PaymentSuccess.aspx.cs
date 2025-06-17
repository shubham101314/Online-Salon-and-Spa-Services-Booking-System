using System;
using System.Web.UI;

namespace WebApplication1
{
    public partial class PaymentSuccess : System.Web.UI.Page
    {
        protected string OrderId { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Get order information from query string or session
                if (Request.QueryString["orderId"] != null)
                {
                    OrderId = Request.QueryString["orderId"].ToString();

                    // In a real application, you would retrieve order details from the database
                    // For this example, we'll just show sample data
                    DisplayOrderDetails(OrderId);
                }
                else
                {
                    // No order ID was passed, redirect to home page or error page
                    Response.Redirect("Default.aspx");
                }
            }
        }

        private void DisplayOrderDetails(string orderId)
        {
            // In a real application, fetch these details from your database
            // based on the order ID

            // Sample data for demonstration purposes
            ltlOrderId.Text = orderId;
            ltlTransactionId.Text = "TXN" + DateTime.Now.ToString("yyyyMMddHHmmss");
            ltlDate.Text = DateTime.Now.ToString("MMMM dd, yyyy");
            ltlAmount.Text = "$199.99";
            ltlPaymentMethod.Text = "Credit Card (XXXX-XXXX-XXXX-1234)";
        }
    }
}