<%@ Page Title="Service Cart" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeFile="servicecart.aspx.cs" Inherits="WebApplication1.servicecart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <!-- External CSS file reference would be better than inline styles -->
    <link rel="stylesheet" href="css/servicecart.css" runat="server" />
    <style>
/* Service Cart Styles */

/* Layout */
.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
}
.dropdown{
        font-family: 'Georgia', 'serif';
}
section {
    margin-bottom: 30px;
}

/* Service Display Styles */
.service-card {
    text-align: center;
    margin-bottom: 30px;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    background-color: #f9f9f9;
}

.service-image-container {
    margin: 15px 0;
}

.service-image {
    max-width: 650px;
    border-radius: 8px;
    box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.3);
    transition: transform 0.3s ease-in-out;
}

.service-image:hover {
    transform: scale(1.05);
}

.service-price-container {
    font-size: 1.2rem;
    font-weight: bold;
    color: #333;
    margin-top: 10px;
}

/* Booking Form Styles */
.booking-container {
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    background-color: #f9f9f9;
}

.booking-container h2 {
    color: #333;
    border-bottom: 2px solid #ffd800;
    padding-bottom: 10px;
    margin-bottom: 20px;
}

.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    font-weight: bold;
    margin-bottom: 8px;
    color: #333;
}

.input-box {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
        font-family: 'Georgia', 'serif';
}

.dropdown {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
}

/* Time Slot Styles */
.time-slot-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 10px;
    margin: 15px 0;
}

.time-slot {
    padding: 10px;
    text-align: center;
    background-color: green;
    color: white;
    border-radius: 5px;
    cursor: pointer;
    border: none;
    transition: all 0.2s ease;
}

.time-slot:hover {
    transform: scale(1.05);
    box-shadow: 0 2px 5px rgba(0,0,0,0.2);
}

.time-slot.booked {
    background-color: gray;
    cursor: not-allowed;
}

.time-slot.selected {
    border: 2px solid red;
    transform: scale(1.05);
}

.selected-time-display {
    margin: 10px 0;
    padding: 10px;
    background-color: #e8f5e9;
    border-radius: 4px;
    display: none;
    font-weight: bold;
}

/* Button Styles */
.btn {
    padding: 12px 24px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-weight: bold;
    transition: background-color 0.3s;
}

.primary-btn {
    background-color: #ffcb08;
    color: white;
                font-family:'Georgia', 'serif';

}

.primary-btn:hover {
    background-color: #ff0000;
                font-family:'Georgia', 'serif';

}

/* Message Styles */
.message-container {
    margin-top: 20px;
}

.message-label {
    color: green;
    font-weight: bold;
    display: block;
    margin-top: 15px;
    padding: 10px;
    border-radius: 4px;
}

.error-message {
    color: red;
    font-weight: bold;
}

/* Responsive Adjustments */
@media (max-width: 768px) {
    .time-slot-grid {
        grid-template-columns: repeat(2, 1fr);
    }
    
    .service-image {
        max-width: 100%;
    }
}

@media (max-width: 480px) {
    .time-slot-grid {
        grid-template-columns: 1fr;
    }
}
    </style>
    <div class="container">
        <!-- Service Display Section -->
        <section class="service-display">
            <div class="service-card">
                <h2><asp:Literal ID="serviceName" runat="server"></asp:Literal></h2>
                <div class="service-image-container">
                    <img id="serviceImage" class="service-image" runat="server" alt="Service Image" />
                </div>
                <div class="service-price-container">
                    <asp:Literal ID="servicePrice" runat="server"></asp:Literal>
                </div>
            </div>
        </section>

        <!-- Booking Form Section -->
        <section class="booking-section">
            <div class="booking-container">
                <h2>Salon & Spa Booking</h2>
                
                <!-- Date Selection -->
                <div class="form-group">
                    <label for="txtBookingDate">Select Date:</label>
                    <asp:TextBox ID="txtBookingDate" runat="server" CssClass="input-box" 
                        TextMode="Date" AutoPostBack="true" OnTextChanged="txtBookingDate_TextChanged">
                    </asp:TextBox>
                </div>
                
                <!-- Time Slot Selection -->
                <div class="form-group">
                    <label>Select Time Slot:</label>
                    <div id="timeSlotContainer" runat="server"></div>
                    <div id="selectedTimeDisplay" class="selected-time-display"></div>
                </div>
                
                <!-- Stylist Selection -->
                <div class="form-group">
                    <label for="ddlStylists">Select Stylist:</label>
                    <asp:DropDownList ID="ddlStylists" runat="server" CssClass="dropdown"></asp:DropDownList>
                </div>
                
                <!-- Hidden Fields for Data Storage -->
                <asp:HiddenField ID="hfSelectedSlot" runat="server" />
                <asp:HiddenField ID="hfServiceName" runat="server" />
                <asp:HiddenField ID="hfServicePrice" runat="server" />
                <asp:HiddenField ID="hfServiceImage" runat="server" />
                
                <!-- Booking Action -->
                <div class="action-container">
                    <asp:Button ID="btnBook" runat="server" CssClass="btn primary-btn" 
                        Text="Confirm Booking" OnClick="btnBook_Click" />
                </div>
                
                <!-- Message Display -->
                <div class="message-container">
                    <asp:Label ID="lblMessage" runat="server" CssClass="message-label"></asp:Label>
                </div>
            </div>
        </section>
    </div>

    <!-- JavaScript Section - Better placed at the end for performance -->
    <script>
        function selectSlot(slot) {
            if (slot.classList.contains("booked")) return;

            // Remove selected class from all slots
            document.querySelectorAll(".time-slot").forEach(btn => {
                btn.classList.remove("selected");
                btn.style.border = "none";
            });

            // Add selected class to this slot
            slot.classList.add("selected");
            slot.style.border = "2px solid red";

            // Update hidden field with selected slot ID
            document.getElementById("<%= hfSelectedSlot.ClientID %>").value = slot.getAttribute("data-slotid");

            // Show selected time in the UI
            const display = document.getElementById("selectedTimeDisplay");
            display.innerHTML = "Selected Time: " + slot.innerText;
            display.style.display = "block";
        }
    </script>
</asp:Content>