<%@ Page Language="C#" AutoEventWireup="true" CodeFile="booking.aspx.cs" Inherits="WebApplication1.booking" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book a Service</title>
    <style>
        .container {
            width: 50%;
            margin: auto;
            text-align: center;
        }
        .form-group {
            margin: 15px 0;
        }
        .grid-container {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Book Your Appointment</h2>
            <div class="form-group">
                <label for="ddlStylists">Select Stylist:</label>
                <asp:DropDownList ID="ddlStylists" runat="server" CssClass="form-control"></asp:DropDownList>
            </div>
            <div class="form-group">
                <label for="txtBookingDate">Select Date:</label>
                <asp:TextBox ID="txtBookingDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="ddlTimeSlot">Select Time Slot:</label>
                <asp:DropDownList ID="ddlTimeSlot" runat="server" CssClass="form-control"></asp:DropDownList>
            </div>
            <div class="form-group">
                <asp:Button ID="btnBook" runat="server" Text="Book Now" CssClass="btn btn-primary" OnClick="btnBook_Click" />
            </div>
            
            <div class="grid-container">
                <h3>Upcoming Bookings</h3>
                <asp:GridView ID="gvBookings" runat="server" AutoGenerateColumns="False" CssClass="table">
                    <Columns>
                        <asp:BoundField DataField="BookingID" HeaderText="Booking ID" />
                        <asp:BoundField DataField="StylistName" HeaderText="Stylist" />
                        <asp:BoundField DataField="BookingDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:BoundField DataField="TimeSlot" HeaderText="Time Slot" />
                        <asp:BoundField DataField="PaymentStatus" HeaderText="Payment Status" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>
