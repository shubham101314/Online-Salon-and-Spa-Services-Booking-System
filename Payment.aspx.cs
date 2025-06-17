using System;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class Payment : Page
    {
        private string connectionString = "Data Source=DESKTOP-PITMH04;Initial Catalog=saloondb;Integrated Security=True";

        // PayU Integration Constants - replace with your actual credentials
        private readonly string MERCHANT_KEY = "YOUR_MERCHANT_KEY"; // Replace with your PayU key
        private readonly string MERCHANT_SALT = "YOUR_MERCHANT_SALT"; // Replace with your PayU salt
        private readonly string PAYU_BASE_URL = "https://test.payu.in/_payment"; // Use https://secure.payu.in/_payment for production

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if user is logged in
                if (Session["UserEmail"] == null)
                {
                    Response.Redirect("login.aspx");
                    return;
                }

                // Load user's unpaid bookings
                LoadUnpaidBookings();
                CalculateTotalAmount();
            }
        }

        private void LoadUnpaidBookings()
        {
            string userEmail = Session["UserEmail"].ToString();

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                // First, get the UserID from the email
                SqlCommand userCmd = new SqlCommand("SELECT UserID FROM Users WHERE Email = @Email", con);
                userCmd.Parameters.AddWithValue("@Email", userEmail);

                con.Open();
                object userIdObj = userCmd.ExecuteScalar();

                if (userIdObj != null && userIdObj != DBNull.Value)
                {
                    int userId = Convert.ToInt32(userIdObj);

                    // Now get unpaid bookings for this user
                    SqlCommand cmd = new SqlCommand(@"
                    SELECT B.BookingID, S.Name AS StylistName, B.BookingDate, T.SlotTime AS TimeSlot, 
                           B.ServiceName, B.ServicePrice
                    FROM Bookings B
                    INNER JOIN Stylists S ON B.StylistID = S.StylistID
                    INNER JOIN TimeSlots T ON B.SlotID = T.SlotID
                    WHERE B.UserID = @UserID AND (B.PaymentStatus = 'Pending' OR B.PaymentStatus IS NULL)
                    ORDER BY B.BookingDate, T.SlotTime", con);

                    cmd.Parameters.AddWithValue("@UserID", userId);

                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        gvOrderSummary.DataSource = dt;
                        gvOrderSummary.DataBind();

                        // Store booking IDs in session for payment processing
                        Session["PendingBookingIDs"] = GetBookingIDsFromDataTable(dt);

                        pnlPayment.Visible = true;
                        pnlNoBookings.Visible = false;
                    }
                    else
                    {
                        // No unpaid bookings found
                        pnlPayment.Visible = false;
                        pnlNoBookings.Visible = true;
                    }
                }
                else
                {
                    // User email not found in database
                    Response.Redirect("login.aspx");
                }
            }
        }

        private string GetBookingIDsFromDataTable(DataTable dt)
        {
            StringBuilder bookingIds = new StringBuilder();

            foreach (DataRow row in dt.Rows)
            {
                if (bookingIds.Length > 0)
                    bookingIds.Append(",");

                bookingIds.Append(row["BookingID"].ToString());
            }

            return bookingIds.ToString();
        }

        protected void CalculateTotalAmount()
        {
            decimal totalAmount = 0;

            // Iterate through the bookings to calculate total
            foreach (GridViewRow row in gvOrderSummary.Rows)
            {
                string priceString = row.Cells[4].Text.Replace("₹", "").Trim();

                if (decimal.TryParse(priceString, out decimal servicePrice))
                {
                    totalAmount += servicePrice;
                }
            }

            // Update the total amount label
            lblTotalAmount.Text = $"₹{totalAmount:N2}";

            // Store total amount in session for payment processing
            Session["TotalAmount"] = totalAmount;
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("booking1.aspx");
        }

        protected void btnBackToBookings_Click(object sender, EventArgs e)
        {
            Response.Redirect("booking1.aspx");
        }

        protected void btnPay_Click(object sender, EventArgs e)
        {
            string paymentMethod = rblPaymentMethods.SelectedValue;

            if (paymentMethod == "card")
            {
                // Basic validation
                if (string.IsNullOrEmpty(txtCardNumber.Text.Trim()) ||
                    string.IsNullOrEmpty(txtExpiry.Text.Trim()) ||
                    string.IsNullOrEmpty(txtCVV.Text.Trim()) ||
                    string.IsNullOrEmpty(txtCardName.Text.Trim()))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "alert('Please fill all card details.');", true);
                    return;
                }
            }
            else if (paymentMethod == "upi" && string.IsNullOrEmpty(txtUPIID.Text.Trim()))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    "alert('Please enter your UPI ID.');", true);
                return;
            }

            // Initiate payment
            InitiatePayUTransaction();
        }

        private void InitiatePayUTransaction()
        {
            try
            {
                string userEmail = Session["UserEmail"].ToString();

                // Get user details
                string firstName = string.Empty;
                string phone = string.Empty;

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand("SELECT FirstName, Phone FROM Users WHERE Email = @Email", con);
                    cmd.Parameters.AddWithValue("@Email", userEmail);

                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        firstName = reader["FirstName"].ToString();
                        phone = reader["Phone"].ToString();
                    }
                    reader.Close();
                }

                // Prepare payment parameters
                string txnId = "TXN_" + DateTime.Now.ToString("yyyyMMddHHmmssfff");
                decimal amount = Convert.ToDecimal(Session["TotalAmount"]);
                string productInfo = "Salon Services";

                // Generate hash
                string hashString = $"{MERCHANT_KEY}|{txnId}|{amount}|{productInfo}|{firstName}|{userEmail}|||||||||||{MERCHANT_SALT}";
                string hash = ComputeSha512Hash(hashString);

                // Set hidden fields
                hdnKey.Value = MERCHANT_KEY;
                hdnHash.Value = hash;
                hdnTxnId.Value = txnId;
                hdnAmount.Value = amount.ToString();
                hdnProductInfo.Value = productInfo;
                hdnFirstName.Value = firstName;
                hdnEmail.Value = userEmail;
                hdnPhone.Value = phone;
                hdnSurl.Value = GetAbsoluteUrl("PaymentSuccess.aspx");
                hdnFurl.Value = GetAbsoluteUrl("PaymentFailure.aspx");

                // Store transaction ID in session for verification
                Session["PaymentTxnId"] = txnId;

                // Submit the form programmatically to PayU
                ClientScript.RegisterStartupScript(this.GetType(), "PayUForm", @"
                    function submitPayUForm() {
                        var form = document.createElement('form');
                        form.setAttribute('method', 'post');
                        form.setAttribute('action', '" + PAYU_BASE_URL + @"');
                        
                        var fields = [
                            { name: 'key', value: '" + MERCHANT_KEY + @"' },
                            { name: 'hash', value: '" + hash + @"' },
                            { name: 'txnid', value: '" + txnId + @"' },
                            { name: 'amount', value: '" + amount + @"' },
                            { name: 'productinfo', value: '" + productInfo + @"' },
                            { name: 'firstname', value: '" + firstName + @"' },
                            { name: 'email', value: '" + userEmail + @"' },
                            { name: 'phone', value: '" + phone + @"' },
                            { name: 'surl', value: '" + hdnSurl.Value + @"' },
                            { name: 'furl', value: '" + hdnFurl.Value + @"' }
                        ];
                        
                        for (var i = 0; i < fields.length; i++) {
                            var input = document.createElement('input');
                            input.setAttribute('type', 'hidden');
                            input.setAttribute('name', fields[i].name);
                            input.setAttribute('value', fields[i].value);
                            form.appendChild(input);
                        }
                        
                        document.body.appendChild(form);
                        form.submit();
                    }
                    
                    setTimeout(function() { submitPayUForm(); }, 100);
                ", true);
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    "alert('Payment error: " + ex.Message.Replace("'", "\\'") + "');", true);
            }
        }

        private string ComputeSha512Hash(string input)
        {
            using (SHA512 sha512 = SHA512.Create())
            {
                byte[] inputBytes = Encoding.UTF8.GetBytes(input);
                byte[] hashBytes = sha512.ComputeHash(inputBytes);

                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < hashBytes.Length; i++)
                {
                    builder.Append(hashBytes[i].ToString("x2"));
                }

                return builder.ToString();
            }
        }

        private string GetAbsoluteUrl(string relativeUrl)
        {
            string appPath = Request.ApplicationPath;
            if (!appPath.EndsWith("/"))
                appPath += "/";

            return Request.Url.GetLeftPart(UriPartial.Authority) + appPath + relativeUrl;
        }
    }
}