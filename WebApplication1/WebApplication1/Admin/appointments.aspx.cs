using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1.Admin
{
    public partial class appointments : Page
    {
        // Database connection string
        private readonly string connectionString = "Data Source=DESKTOP-PITMH04;Initial Catalog=saloondb;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAppointments();
                LoadStatistics(); // Added method call to load statistics
            }
        }

        private void LoadAppointments()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand(@"
                    SELECT 
                        b.BookingID, 
                        u.Name AS ClientName, 
                        b.ServiceName, 
                        s.Name AS StylistName, 
                        b.BookingDate, 
                        b.SlotID AS TimeSlot, 
                        b.PaymentStatus,
                        s.IsAvailable AS StylistAvailable
                    FROM Bookings b
                    INNER JOIN Users u ON b.UserID = u.UserID
                    INNER JOIN Stylists s ON b.StylistID = s.StylistID
                    ORDER BY b.BookingDate DESC", con))
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvAppointments.DataSource = dt;
                    gvAppointments.DataBind();
                }
            }
        }

        // New method to load statistics from database
        private void LoadStatistics()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // Today's appointments
                using (SqlCommand cmd = new SqlCommand(@"
                    SELECT COUNT(*) 
                    FROM Bookings 
                    WHERE CONVERT(date, BookingDate) = CONVERT(date, GETDATE())", con))
                {
                    lblTodayCount.Text = cmd.ExecuteScalar().ToString();
                }

                // Pending appointments
                using (SqlCommand cmd = new SqlCommand(@"
                    SELECT COUNT(*) 
                    FROM Bookings 
                    WHERE PaymentStatus = 'Pending'", con))
                {
                    lblPendingCount.Text = cmd.ExecuteScalar().ToString();
                }

                // Confirmed appointments
                using (SqlCommand cmd = new SqlCommand(@"
                    SELECT COUNT(*) 
                    FROM Bookings 
                    WHERE PaymentStatus = 'Paid'", con))
                {
                    lblConfirmedCount.Text = cmd.ExecuteScalar().ToString();
                }

                // Cancelled appointments
                using (SqlCommand cmd = new SqlCommand(@"
                    SELECT COUNT(*) 
                    FROM Bookings 
                    WHERE PaymentStatus = 'Cancelled'", con))
                {
                    lblCancelledCount.Text = cmd.ExecuteScalar().ToString();
                }
            }
        }

        protected string GetStatusClass(object status)
        {
            string paymentStatus = status.ToString();

            switch (paymentStatus.ToLower())
            {
                case "paid":
                    return "badge-success";
                case "pending":
                    return "badge-warning";
                case "cancelled":
                    return "badge-danger";
                default:
                    return "badge-secondary";
            }
        }

        protected void gvAppointments_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvAppointments.PageIndex = e.NewPageIndex;
            LoadAppointments();
        }

       protected void gvAppointments_RowCommand(object sender, GridViewCommandEventArgs e)
{
    if (e.CommandName == "Approve" || e.CommandName == "Discard")
    {
        int bookingID = Convert.ToInt32(e.CommandArgument);

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            con.Open();

            // Check if Stylist is Available
            string checkAvailabilityQuery = @"
                SELECT s.IsAvailable 
                FROM Bookings b
                INNER JOIN Stylists s ON b.StylistID = s.StylistID
                WHERE b.BookingID = @BookingID";

            using (SqlCommand checkCmd = new SqlCommand(checkAvailabilityQuery, con))
            {
                checkCmd.Parameters.AddWithValue("@BookingID", bookingID);
                object result = checkCmd.ExecuteScalar();
                bool isAvailable = (result != null) ? Convert.ToBoolean(result) : false;

                string query = "";
                if (e.CommandName == "Approve" && isAvailable)
                {
                            // For approving, update the status to "Confirmed" (or "Paid" if that's what your DB expects)
                            query = "UPDATE Bookings SET PaymentStatus = 'Paid' WHERE BookingID = @BookingID";
                        }
                        else if (e.CommandName == "Discard")
                {
                    // For rejecting/discarding, DELETE the appointment instead of updating it
                    query = "DELETE FROM Bookings WHERE BookingID = @BookingID";
                }

                if (!string.IsNullOrEmpty(query))
                {
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@BookingID", bookingID);
                        cmd.ExecuteNonQuery();
                    }
                }
            }
        }

        // Refresh both the grid and statistics after action
        LoadAppointments();
        LoadStatistics();
    }
}
    }
}