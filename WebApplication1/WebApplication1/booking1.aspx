<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeFile="booking1.aspx.cs" Inherits="WebApplication1.booking1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Modern Color Palette */
        :root {
            --primary: #6a3093;
            --primary-gradient: linear-gradient(135deg, #6a3093 0%, #a044ff 100%);
            --secondary: #ff4d79;
            --light: #f8f9fa;
            --dark: #343a40;
            --text: #333333;
            --border: #dee2e6;
            --success: #28a745;
            --danger: #dc3545;
        }

        /* Base Styles */
        .booking-container {
            max-width: 1300px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Bookings Table */
        .bookings-section {
            margin-bottom: 2rem;
            background: var(--light);
            padding: 1.5rem;
            border-radius: 12px;
        }

        .bookings-title {
            color:#000000;
            font-size: 24px;
            margin-bottom: 1rem;
            font-weight: 600;
            text-align: center;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05);
        }

        .table th {
            background-color: #000000;
            color: white;
            padding: 12px 15px;
            text-align: left;
            font-family:'Georgia', 'serif';
            text-align: center;
        }

        .table td {
            padding: 12px 15px;
            border-bottom: 1px solid var(--border);
            color: var(--text);
            font-family:'Georgia', 'serif';
            font-size:20px;
            text-align: center;
        }

        .table tr:last-child td {
            border-bottom: none;
        }

        .table tr:hover {
            background-color: rgba(106, 48, 147, 0.05);
        }

        /* Price Display */
        .price-display {
            background: var(--light);
            padding: 1.5rem;
            border-radius: 8px;
            margin-bottom: 2rem;
            text-align: center;
        }

        .price-label {
            font-size: 18px;
            color: var(--dark);
            font-weight: 500;
            font-family:'Georgia', 'serif';
        }

        .price-amount {
            font-size: 28px;
            color: #ff0000;
            font-weight: 700;
        }

        /* Button Styling */
        .btn-container {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
            justify-content: center;
        }

        .btn {
            padding: 12px 24px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .btn-checkout {
            background-color:#ffcb08;
            color: white;
            box-shadow: 0 4px 15px rgba(255, 77, 121, 0.3);
            font-family:'Georgia', 'serif';
        }

        .btn-checkout:hover {
            background-color:#ff0000;
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(255, 77, 121, 0.4);
            font-family:'Georgia', 'serif';
        }
        
        .btn-danger {
            background-color: #ff0000;
            color: white;
            padding: 8px 16px;
            font-size: 14px;
        }
        
        .btn-danger:hover {
            background-color: #c82333;
            transform: translateY(-2px);
            box-shadow: 0 3px 8px rgba(220, 53, 69, 0.4);
        }

        /* Form Styling - Hidden but keeping the styles */
        .booking-form {
            display: none;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--border);
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        /* Service Image styling */
        .service-image {
            width: 200px;
            height: 120px;
            object-fit: cover;
            border-radius: 8px;
            border: 2px solid var(--border);
            transition: transform 0.3s;
        }
        
        .service-image:hover {
            transform: scale(1.1);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        /* Login message styling */
        .login-message {
            background-color: var(--light);
            border-radius: 8px;
            padding: 2rem;
            text-align: center;
            margin-bottom: 2rem;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05);
        }
        
        .login-message h3 {
            font-size: 24px;
            color: var(--dark);
            margin-bottom: 1rem;
            font-family: 'Georgia', 'serif';
        }
        
        .login-message p {
            font-size: 18px;
            color: var(--text);
            margin-bottom: 1.5rem;
            font-family: 'Georgia', 'serif';
        }
        
        .btn-login {
            background-color: #000000;
            color: white;
            font-family: 'Georgia', 'serif';
        }
        
        .btn-login:hover {
            background-color: #333333;
        }

        /* Responsive Styling */
        @media (max-width: 768px) {
            .booking-container {
                padding: 1.5rem;
                margin: 1rem;
            }

            .btn-container {
                flex-direction: column;
            }

            .btn {
                width: 100%;
                margin-bottom: 0.5rem;
            }
            
            .service-image {
                width: 60px;
                height: 60px;
            }
        }
        
        /* Confirmation modal */
        .modal-backdrop {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
        }
        
        .modal-dialog {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            border-radius: 8px;
            padding: 20px;
            width: 80%;
            max-width: 400px;
            z-index: 1001;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }
        /* Message styling */
.message-panel {
    padding: 10px;
    border-radius: 6px;
    margin: 5px 0;
    font-family: 'Georgia', 'serif';
    font-size: 14px;
}

.message-approved {
    background-color: rgba(40, 167, 69, 0.1);
    border-left: 4px solid var(--success);
    color: #155724;
}

.message-rejected {
    background-color: rgba(220, 53, 69, 0.1);
    border-left: 4px solid var(--danger);
    color: #721c24;
}

.message-pending {
    background-color: rgba(255, 193, 7, 0.1);
    border-left: 4px solid #ffc107;
    color: #856404;
}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="booking-container">
        <!-- Hidden form fields - will still be in the DOM but not visible -->
        <div class="booking-form">
            <div class="form-group">
                <asp:DropDownList ID="ddlStylists" runat="server" CssClass="form-control"></asp:DropDownList>
            </div>
            
            <div class="form-group">
                <asp:TextBox ID="txtBookingDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
            </div>
            
            <div class="form-group">
                <asp:DropDownList ID="ddlTimeSlot" runat="server" CssClass="form-control"></asp:DropDownList>
            </div>
        </div>
        
        <asp:Panel ID="pnlLogin" runat="server" CssClass="login-message" Visible="false">
            <h3>Please Login First</h3>
            <p>You need to be logged in to view your appointments.</p>
            <asp:Button ID="btnGoToLogin" runat="server" Text="Go to Login" CssClass="btn btn-login" OnClick="btnGoToLogin_Click" />
        </asp:Panel>
        
        <asp:Panel ID="pnlBookings" runat="server">
            <div class="bookings-section">
                <h3 class="bookings-title">Your Appointments</h3>
                <asp:GridView ID="gvBookings" runat="server" AutoGenerateColumns="False" CssClass="table"
                              OnRowCommand="gvBookings_RowCommand" EmptyDataText="You have no appointments.">
                    <Columns>
                        <asp:BoundField DataField="BookingID" HeaderText="Booking ID" />
                        <asp:BoundField DataField="StylistName" HeaderText="Stylist" />
                        <asp:BoundField DataField="BookingDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:BoundField DataField="TimeSlot" HeaderText="Time Slot" />
                        <asp:BoundField DataField="ServiceName" HeaderText="Service" />
                        <asp:BoundField DataField="ServicePrice" HeaderText="Price" />
                        <asp:BoundField DataField="PaymentStatus" HeaderText="Payment Status" />
                        <asp:TemplateField HeaderText="Admin Message">
                        <ItemTemplate>
                            <asp:Panel ID="pnlMessage" runat="server" 
                                      CssClass='<%# GetMessagePanelClass(Eval("Status")) %>'
                                      Visible='<%# !string.IsNullOrEmpty(Eval("Message").ToString()) %>'>
                                <asp:Label ID="lblMessage" runat="server" Text='<%# Eval("Message") %>'></asp:Label>
                            </asp:Panel>
                        </ItemTemplate>
                    </asp:TemplateField>
                        <asp:TemplateField HeaderText="Image">
                            <ItemTemplate>
                                <asp:Image ID="imgService" runat="server" 
                                           ImageUrl='<%# Eval("ServiceImage") %>' 
                                           CssClass="service-image" 
                                           AlternateText="Service Image" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-danger" 
                                            Text="Delete" 
                                            CommandName="DeleteBooking" 
                                            CommandArgument='<%# Eval("BookingID") %>'
                                            OnClientClick="return confirm('Are you sure you want to cancel this appointment?');" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
            
            <div class="price-display">
                <span class="price-label">Total Service Amount: </span>
                <span class="price-amount"><asp:Label ID="lblTotalAmount" runat="server" Text="₹0"></asp:Label></span>
            </div>
            
            <div class="btn-container">
                <asp:Button ID="btnCheckout" runat="server" Text="Proceed to Payment" CssClass="btn btn-checkout" OnClick="btnCheckout_Click" />
            </div>
        </asp:Panel>
    </div>
</asp:Content>