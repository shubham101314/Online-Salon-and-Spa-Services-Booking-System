using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication1.Admin
{
    public partial class dashboard : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDashboardData();
                LoadRecentBookings();
            }
        }

        private void LoadDashboardData()
        {
            string connectionString = "Data Source=DESKTOP-PITMH04;Initial Catalog=saloondb;Integrated Security=True";
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand(@"
                    SELECT 
                        (SELECT COUNT(*) FROM Bookings) AS TotalAppointments, 
                        (SELECT COUNT(DISTINCT UserID) FROM Bookings) AS TotalClients, 
                        (SELECT COUNT(DISTINCT ServiceName) FROM Bookings) AS TotalServices, 
                        (SELECT COUNT(DISTINCT StylistID) FROM Bookings) AS TotalStaff, 
                        (SELECT SUM(CAST(ServicePrice AS DECIMAL(10,2))) FROM Bookings) AS TotalRevenue,
                        (SELECT COUNT(*) FROM Users) AS TotalUsers
                ", con))
                {
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        lblTotalAppointments.Text = reader["TotalAppointments"].ToString();
                        lblTotalClients.Text = reader["TotalClients"].ToString();
                        lblTotalServices.Text = reader["TotalServices"].ToString();
                        lblTotalStaff.Text = reader["TotalStaff"].ToString();
                        lblTotalRevenue.Text = reader["TotalRevenue"].ToString();
                        lblTotalUsers.Text = reader["TotalUsers"].ToString(); // ✅ Display Total Users
                    }
                }
            }
        }
        // Add this method to your dashboard.aspx.cs file
        protected string GetStatusClass(string status)
        {
            switch (status)
            {
                case "Pending": return "status-pending";
                case "Confirmed": return "status-confirmed";
                case "Cancelled": return "status-cancelled";
                case "Completed": return "status-completed";
                default: return "";
            }
        }
        private void LoadRecentBookings()
        {
            string connectionString = "Data Source=DESKTOP-PITMH04;Initial Catalog=saloondb;Integrated Security=True";
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand(@"
        SELECT TOP 5 
            BookingID, 
            UserID, 
            StylistID, 
            BookingDate, 
            t.SlotID, 
            t.SlotTime AS BookingTime, 
            PaymentStatus, 
            ServiceName, 
            CAST(ServicePrice AS DECIMAL(10,2)) AS ServicePrice 
        FROM Bookings b
        INNER JOIN TimeSlots t ON b.SlotID = t.SlotID
        ORDER BY BookingDate DESC", con))
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    // Create a new column for the formatted time
                    if (!dt.Columns.Contains("FormattedTime"))
                    {
                        dt.Columns.Add("FormattedTime", typeof(string));
                    }

                    // Format the TimeSpan column
                    foreach (DataRow row in dt.Rows)
                    {
                        if (row["BookingTime"] != DBNull.Value)
                        {
                            TimeSpan time = (TimeSpan)row["BookingTime"];
                            // Format as string and store in the new column
                            DateTime dateTime = DateTime.Today.Add(time);
                            row["FormattedTime"] = dateTime.ToString("hh:mm tt");
                        }
                    }

                    gvRecentAppointments.DataSource = dt;
                    gvRecentAppointments.DataBind();
                }
            }
        }
    }
}
