using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
namespace WebApplication1
{
    public partial class booking : Page
    {
        private string connectionString = "Data Source=DESKTOP-PITMH04;Initial Catalog=saloondb;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStylists();
                LoadTimeSlots();
                LoadBookings();
            }
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
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(@"
            SELECT B.BookingID, S.Name AS StylistName, B.BookingDate, T.SlotTime AS TimeSlot, B.PaymentStatus 
            FROM Bookings B 
            INNER JOIN Stylists S ON B.StylistID = S.StylistID 
            INNER JOIN TimeSlots T ON B.SlotID = T.SlotID", con);

                con.Open();
                gvBookings.DataSource = cmd.ExecuteReader();
                gvBookings.DataBind();
            }
        }


        protected void btnBook_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO Bookings (UserID, StylistID, BookingDate, SlotID, PaymentStatus) VALUES (@UserID, @StylistID, @BookingDate, @SlotID, 'Pending')", con);
                cmd.Parameters.AddWithValue("@UserID", 1); // Replace with actual logged-in user ID
                cmd.Parameters.AddWithValue("@StylistID", ddlStylists.SelectedValue);
                cmd.Parameters.AddWithValue("@BookingDate", txtBookingDate.Text);
                cmd.Parameters.AddWithValue("@SlotID", ddlTimeSlot.SelectedValue);

                con.Open();
                cmd.ExecuteNonQuery();
                LoadBookings();
            }
        }
    }
}
