using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class booking1 : Page
    {
        private string connectionString = "Data Source=DESKTOP-PITMH04;Initial Catalog=saloondb;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if user is logged in
                if (Session["UserEmail"] == null)
                {
                    // Show login message if user is not logged in
                    pnlLogin.Visible = true;
                    pnlBookings.Visible = false;
                }
                else
                {
                    // User is logged in, load their bookings
                    pnlLogin.Visible = false;
                    pnlBookings.Visible = true;

                    LoadStylists();
                    LoadTimeSlots();
                    LoadBookings();
                    CalculateTotalAmount();
                }
            }
        }

        protected void btnGoToLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("login.aspx");
        }

        private void LoadStylists()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT StylistID, Name FROM Stylists", con);
                con.Open();
                ddlStylists.DataSource = cmd.ExecuteReader();
                ddlStylists.DataTextField = "Name";
                ddlStylists.DataValueField = "StylistID";
                ddlStylists.DataBind();
            }
        }

        private void LoadTimeSlots()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT SlotID, SlotTime FROM TimeSlots", con);
                con.Open();
                ddlTimeSlot.DataSource = cmd.ExecuteReader();
                ddlTimeSlot.DataTextField = "SlotTime";
                ddlTimeSlot.DataValueField = "SlotID";
                ddlTimeSlot.DataBind();
            }
        }

        private void LoadBookings()
        {
            if (Session["UserEmail"] == null)
            {
                return; // Don't load bookings if user is not logged in
            }

            string userEmail = Session["UserEmail"].ToString();

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                try
                {
                    // First, get the UserID from the email
                    SqlCommand userCmd = new SqlCommand("SELECT UserID FROM Users WHERE Email = @Email", con);
                    userCmd.Parameters.AddWithValue("@Email", userEmail);

                    con.Open();
                    object userIdObj = userCmd.ExecuteScalar();

                    if (userIdObj != null && userIdObj != DBNull.Value)
                    {
                        int userId = Convert.ToInt32(userIdObj);

                        // Now get bookings for this user
                        SqlCommand cmd = new SqlCommand(@"
                        SELECT B.BookingID, S.Name AS StylistName, B.BookingDate, T.SlotTime AS TimeSlot, 
                               B.PaymentStatus, B.ServiceName, B.ServicePrice, B.ServiceImage, B.Status,
                    B.Message
                        FROM Bookings B
                        INNER JOIN Stylists S ON B.StylistID = S.StylistID
                        INNER JOIN TimeSlots T ON B.SlotID = T.SlotID
                        WHERE B.UserID = @UserID
                        ORDER BY B.BookingDate, T.SlotTime", con);

                        cmd.Parameters.AddWithValue("@UserID", userId);

                        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            gvBookings.DataSource = dt;
                            gvBookings.DataBind();

                            // Set empty data text in case we need it later
                            gvBookings.EmptyDataText = "You have no bookings yet.";
                        }
                        else
                        {
                            // No bookings found - display a message
                            gvBookings.DataSource = null;
                            gvBookings.EmptyDataText = "You have no bookings yet.";
                            gvBookings.DataBind();
                        }
                    }
                    else
                    {
                        // User email not found in database
                        gvBookings.DataSource = null;
                        gvBookings.EmptyDataText = "User information not found. Please log in again.";
                        gvBookings.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    // Handle any errors
                    gvBookings.DataSource = null;
                    gvBookings.EmptyDataText = "Error loading bookings: " + ex.Message;
                    gvBookings.DataBind();
                }
            }
        }

        protected void CalculateTotalAmount()
        {
            decimal totalAmount = 0;

            // Iterate through the bookings to calculate total
            foreach (GridViewRow row in gvBookings.Rows)
            {
                // Extract price from the ServicePrice column
                string priceString = row.Cells[5].Text.Replace("₹", "").Trim();

                if (decimal.TryParse(priceString, out decimal servicePrice))
                {
                    totalAmount += servicePrice;
                }
            }

            // Update the total amount label
            lblTotalAmount.Text = $"₹{totalAmount:N2}";
        }
        protected string GetMessagePanelClass(object status)
        {
            string baseClass = "message-panel ";

            if (status == null || status == DBNull.Value)
                return baseClass + "message-pending";

            string bookingStatus = status.ToString().ToLower();

            switch (bookingStatus)
            {
                case "approved":
                    return baseClass + "message-approved";
                case "rejected":
                    return baseClass + "message-rejected";
                default:
                    return baseClass + "message-pending";
            }
        }
        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            // Check if user is logged in before proceeding to payment
            if (Session["UserEmail"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }

            // Redirect to payment page or perform checkout logic
            Response.Redirect("payment.aspx");
        }

        protected void gvBookings_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteBooking")
            {
                int bookingId = Convert.ToInt32(e.CommandArgument);
                DeleteBooking(bookingId);
            }
        }

        private void DeleteBooking(int bookingId)
        {
            // Check if user is logged in
            if (Session["UserEmail"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                try
                {
                    // Get the UserID for the logged-in user
                    string userEmail = Session["UserEmail"].ToString();
                    SqlCommand getUserIdCmd = new SqlCommand("SELECT UserID FROM Users WHERE Email = @Email", con);
                    getUserIdCmd.Parameters.AddWithValue("@Email", userEmail);

                    con.Open();
                    object userIdObj = getUserIdCmd.ExecuteScalar();

                    if (userIdObj != null && userIdObj != DBNull.Value)
                    {
                        int userId = Convert.ToInt32(userIdObj);

                        // Verify the booking belongs to this user
                        SqlCommand verifyCmd = new SqlCommand(
                            "SELECT COUNT(*) FROM Bookings WHERE BookingID = @BookingID AND UserID = @UserID", con);
                        verifyCmd.Parameters.AddWithValue("@BookingID", bookingId);
                        verifyCmd.Parameters.AddWithValue("@UserID", userId);

                        int count = (int)verifyCmd.ExecuteScalar();

                        if (count > 0)
                        {
                            // Check payment status
                            SqlCommand checkCmd = new SqlCommand(
                                "SELECT PaymentStatus FROM Bookings WHERE BookingID = @BookingID", con);
                            checkCmd.Parameters.AddWithValue("@BookingID", bookingId);
                            object result = checkCmd.ExecuteScalar();

                            if (result != null)
                            {
                                string paymentStatus = result.ToString();

                                // Delete the booking
                                SqlCommand deleteCmd = new SqlCommand(
                                    "DELETE FROM Bookings WHERE BookingID = @BookingID", con);
                                deleteCmd.Parameters.AddWithValue("@BookingID", bookingId);

                                int rowsAffected = deleteCmd.ExecuteNonQuery();

                                if (rowsAffected > 0)
                                {
                                    // Success message
                                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                                        "alert('Booking cancelled successfully.');", true);

                                    // Release the time slot
                                    SqlCommand releaseSlotCmd = new SqlCommand(
                                        "UPDATE TimeSlots SET SlotStatus = 'Available' WHERE SlotID = " +
                                        "(SELECT SlotID FROM Bookings WHERE BookingID = @BookingID)", con);
                                    releaseSlotCmd.Parameters.AddWithValue("@BookingID", bookingId);
                                    releaseSlotCmd.ExecuteNonQuery();
                                }
                                else
                                {
                                    // Error message
                                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                                        "alert('Failed to cancel booking. Please try again.');", true);
                                }
                            }
                        }
                        else
                        {
                            // Unauthorized access attempt
                            ClientScript.RegisterStartupScript(this.GetType(), "alert",
                                "alert('You do not have permission to cancel this booking.');", true);
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Error handling
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "alert('Error: " + ex.Message.Replace("'", "\\'") + "');", true);
                }
                finally
                {
                    // Reload the bookings
                    LoadBookings();
                    CalculateTotalAmount();
                }
            }
        }
    }
}