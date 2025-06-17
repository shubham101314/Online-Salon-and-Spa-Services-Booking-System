using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class servicecart : Page
    {
        private string connectionString = "Data Source=DESKTOP-PITMH04;Initial Catalog=saloondb;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadServiceDetails();
                LoadStylists();
            }
        }

        private void LoadServiceDetails()
        {
            if (Request.QueryString["name"] != null && Request.QueryString["price"] != null && Request.QueryString["image"] != null)
            {
                string serviceName = Request.QueryString["name"];
                string servicePrice = Request.QueryString["price"];
                string serviceImage = Request.QueryString["image"];

                // Display the values
                this.serviceName.Text = "<h1 class='service-name'>" + serviceName + "</h1>";
                this.servicePrice.Text = "<div class='service-price'>Price: ₹" + servicePrice + "</div>";
                this.serviceImage.Src = serviceImage;

                // Store the values in hidden fields
                hfServiceName.Value = serviceName;
                hfServicePrice.Value = servicePrice;
                hfServiceImage.Value = serviceImage;
            }
        }

        protected void txtBookingDate_TextChanged(object sender, EventArgs e)
        {
            LoadAvailableTimeSlots();
        }

        private void LoadAvailableTimeSlots()
        {
            timeSlotContainer.Controls.Clear();
            if (string.IsNullOrEmpty(txtBookingDate.Text)) return;

            DateTime selectedDate = Convert.ToDateTime(txtBookingDate.Text);
            Panel slotPanel = new Panel { CssClass = "time-slot-grid" };
            timeSlotContainer.Controls.Add(slotPanel);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    string query = @"
                    SELECT t.SlotID, t.SlotTime 
                    FROM TimeSlots t
                    WHERE t.SlotID NOT IN (
                        SELECT SlotID FROM Bookings 
                        WHERE BookingDate = @BookingDate
                    )
                    ORDER BY t.SlotTime";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@BookingDate", selectedDate);
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            bool hasSlots = false;

                            while (reader.Read())
                            {
                                hasSlots = true;
                                Button btnSlot = new Button
                                {
                                    Text = reader["SlotTime"].ToString(),
                                    CssClass = "time-slot",
                                    CommandArgument = reader["SlotID"].ToString()
                                };
                                btnSlot.Attributes.Add("data-slotid", reader["SlotID"].ToString());
                                btnSlot.Attributes.Add("onclick", "selectSlot(this); return false;");
                                btnSlot.Click += TimeSlot_Click;
                                slotPanel.Controls.Add(btnSlot);
                            }

                            if (!hasSlots)
                            {
                                Label noSlotsLabel = new Label { Text = "No available slots for the selected date." };
                                timeSlotContainer.Controls.Add(noSlotsLabel);
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    Label errorLabel = new Label { Text = "Error loading time slots: " + ex.Message };
                    timeSlotContainer.Controls.Add(errorLabel);
                }
            }
        }

        protected void TimeSlot_Click(object sender, EventArgs e)
        {
            Button clickedButton = (Button)sender;
            hfSelectedSlot.Value = clickedButton.CommandArgument;
        }

        private void LoadStylists()
        {
            ddlStylists.Items.Clear();
            string query = "SELECT StylistID, Name FROM Stylists";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter(query, conn))
                {
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    ddlStylists.DataSource = dt;
                    ddlStylists.DataTextField = "Name";
                    ddlStylists.DataValueField = "StylistID";
                    ddlStylists.DataBind();
                }
            }
            ddlStylists.Items.Insert(0, new ListItem("Select a Stylist", "0"));
        }

        private int GetUserIDFromSession()
        {
            int userID = 0;

            // Check if user is logged in via session
            if (Session["UserEmail"] != null)
            {
                string userEmail = Session["UserEmail"].ToString();

                // Get the user ID from email
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand userCmd = new SqlCommand("SELECT UserID FROM Users WHERE Email = @Email", conn);
                    userCmd.Parameters.AddWithValue("@Email", userEmail);
                    object result = userCmd.ExecuteScalar();

                    if (result != null && result != DBNull.Value)
                    {
                        userID = Convert.ToInt32(result);
                        return userID;
                    }
                }
            }

            // If not found or not logged in, use default user
            return GetValidUserId();
        }

        private int GetValidUserId()
        {
            int userId = 0;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string checkQuery = "SELECT TOP 1 UserID FROM Users";
                using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                {
                    object result = checkCmd.ExecuteScalar();
                    if (result != null)
                    {
                        userId = Convert.ToInt32(result);
                    }
                    else
                    {
                        string insertQuery = "INSERT INTO Users (Username, Email, Password) VALUES ('DefaultUser', 'default@example.com', 'password123'); SELECT SCOPE_IDENTITY();";
                        using (SqlCommand insertCmd = new SqlCommand(insertQuery, conn))
                        {
                            userId = Convert.ToInt32(insertCmd.ExecuteScalar());
                        }
                    }
                }
            }

            return userId;
        }

        protected void btnBook_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(txtBookingDate.Text))
                {
                    lblMessage.Text = "Please select a date.";
                    return;
                }

                if (string.IsNullOrEmpty(hfSelectedSlot.Value))
                {
                    lblMessage.Text = "Please select a time slot.";
                    return;
                }

                if (ddlStylists.SelectedValue == "0")
                {
                    lblMessage.Text = "Please select a stylist.";
                    return;
                }

                // Get user ID from session or create default user
                int userID = GetUserIDFromSession();

                int selectedSlotID = Convert.ToInt32(hfSelectedSlot.Value);
                int stylistID = Convert.ToInt32(ddlStylists.SelectedValue);
                DateTime selectedDate = Convert.ToDateTime(txtBookingDate.Text);

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    using (SqlTransaction transaction = conn.BeginTransaction())
                    {
                        try
                        {
                            string insertQuery = @"
                            IF NOT EXISTS (
                                SELECT 1 FROM Bookings WHERE SlotID = @SlotID AND BookingDate = @BookingDate
                            )
                            BEGIN
                                INSERT INTO Bookings(UserID, BookingDate, SlotID, StylistID, PaymentStatus, ServiceName, ServicePrice, ServiceImage) 
                                VALUES (@UserID, @BookingDate, @SlotID, @StylistID, 'Pending', @ServiceName, @ServicePrice, @ServiceImage);
                            END
                            ELSE
                            BEGIN
                                THROW 50000, 'This time slot is no longer available. Please select another time slot.', 1;
                            END";

                            using (SqlCommand insertCmd = new SqlCommand(insertQuery, conn, transaction))
                            {
                                insertCmd.Parameters.AddWithValue("@UserID", userID);
                                insertCmd.Parameters.AddWithValue("@BookingDate", selectedDate);
                                insertCmd.Parameters.AddWithValue("@SlotID", selectedSlotID);
                                insertCmd.Parameters.AddWithValue("@StylistID", stylistID);
                                insertCmd.Parameters.AddWithValue("@ServiceName", hfServiceName.Value);
                                insertCmd.Parameters.AddWithValue("@ServicePrice", hfServicePrice.Value);
                                insertCmd.Parameters.AddWithValue("@ServiceImage", hfServiceImage.Value);
                                insertCmd.ExecuteNonQuery();
                            }

                            string updateQuery = "UPDATE TimeSlots SET SlotStatus = 'Booked' WHERE SlotID = @SlotID";
                            using (SqlCommand updateCmd = new SqlCommand(updateQuery, conn, transaction))
                            {
                                updateCmd.Parameters.AddWithValue("@SlotID", selectedSlotID);
                                updateCmd.ExecuteNonQuery();
                            }

                            transaction.Commit();
                            lblMessage.Text = "Booking confirmed!";

                            // Show alert and redirect to booking page
                            ScriptManager.RegisterStartupScript(this, GetType(), "SuccessAlert",
                                "alert('Your booking is confirmed!'); window.location.href='booking1.aspx';", true);

                            LoadAvailableTimeSlots();
                        }
                        catch (Exception ex)
                        {
                            transaction.Rollback();
                            lblMessage.Text = "Booking failed: " + ex.Message;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
            }
        }
    }
}