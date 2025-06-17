<%@ Page Title="Payment" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeFile="Payment.aspx.cs" Inherits="WebApplication1.Payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Modern Color Palette - matching your existing style */
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
        .payment-container {
            max-width: 900px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .page-title {
            color: #000000;
            font-size: 28px;
            margin-bottom: 1.5rem;
            font-weight: 600;
            text-align: center;
            font-family: 'Georgia', 'serif';
        }

        /* Order Summary Section */
        .order-summary {
            background: var(--light);
            padding: 1.5rem;
            border-radius: 12px;
            margin-bottom: 2rem;
        }

        .summary-title {
            color: #000000;
            font-size: 22px;
            margin-bottom: 1rem;
            font-weight: 600;
            font-family: 'Georgia', 'serif';
        }

        .summary-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05);
        }

        .summary-table th {
            background-color: #000000;
            color: white;
            padding: 12px 15px;
            text-align: left;
            font-family: 'Georgia', 'serif';
        }

        .summary-table td {
            padding: 12px 15px;
            border-bottom: 1px solid var(--border);
            color: var(--text);
            font-family: 'Georgia', 'serif';
        }

        .summary-table tr:last-child td {
            border-bottom: none;
        }

        .total-row {
            font-weight: bold;
            background-color: rgba(106, 48, 147, 0.05);
        }

        /* Payment Methods Section */
        .payment-methods {
            background: var(--light);
            padding: 1.5rem;
            border-radius: 12px;
            margin-bottom: 2rem;
        }

        .payment-title {
            color: #000000;
            font-size: 22px;
            margin-bottom: 1rem;
            font-weight: 600;
            font-family: 'Georgia', 'serif';
        }

        .payment-options {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .payment-option {
            flex: 1;
            min-width: 200px;
            padding: 1rem;
            border: 2px solid var(--border);
            border-radius: 8px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .payment-option:hover {
            border-color: var(--primary);
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .payment-option.selected {
            border-color: var(--primary);
            background-color: rgba(106, 48, 147, 0.05);
        }

        .payment-icon {
            width: 50px;
            height: 50px;
            margin-bottom: 0.5rem;
        }

        .payment-name {
            font-family: 'Georgia', 'serif';
            font-weight: 600;
        }

        /* Customer Details */
        .customer-details {
            background: var(--light);
            padding: 1.5rem;
            border-radius: 12px;
            margin-bottom: 2rem;
        }

        .details-title {
            color: #000000;
            font-size: 22px;
            margin-bottom: 1rem;
            font-weight: 600;
            font-family: 'Georgia', 'serif';
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-family: 'Georgia', 'serif';
            color: var(--dark);
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--border);
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s, box-shadow 0.3s;
            font-family: 'Georgia', 'serif';
        }

        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(106, 48, 147, 0.2);
            outline: none;
        }

        /* Button Styling */
        .btn-container {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
            justify-content: center;
        }

        .btn {
            padding: 14px 28px;
            border-radius: 8px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-family: 'Georgia', 'serif';
        }

        .btn-pay {
            background-color: #ffcb08;
            color: white;
            box-shadow: 0 4px 15px rgba(255, 77, 121, 0.3);
        }

        .btn-pay:hover {
            background-color: #ff0000;
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(255, 77, 121, 0.4);
        }

        .btn-back {
            background-color: #000000;
            color: white;
        }

        .btn-back:hover {
            background-color: #333333;
            transform: translateY(-2px);
        }

        /* Secure Info */
        .secure-info {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            margin-top: 1rem;
            color: var(--dark);
            font-family: 'Georgia', 'serif';
        }

        .lock-icon {
            color: var(--success);
        }

        /* Responsive Styling */
        @media (max-width: 768px) {
            .payment-container {
                padding: 1.5rem;
                margin: 1rem;
            }

            .payment-options {
                flex-direction: column;
            }

            .btn-container {
                flex-direction: column;
            }

            .btn {
                width: 100%;
                margin-bottom: 0.5rem;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="payment-container">
        <h2 class="page-title">Complete Your Payment</h2>

        <asp:Panel ID="pnlNoBookings" runat="server" Visible="false" CssClass="order-summary">
            <h3 class="summary-title">No Bookings to Pay For</h3>
            <p>You don't have any pending payments. Please book a service first.</p>
            <div class="btn-container">
                <asp:Button ID="btnBackToBookings" runat="server" Text="Back to Bookings" CssClass="btn btn-back" OnClick="btnBackToBookings_Click" />
            </div>
        </asp:Panel>

        <asp:Panel ID="pnlPayment" runat="server">
            <!-- Order Summary Section -->
            <div class="order-summary">
                <h3 class="summary-title">Order Summary</h3>
                <asp:GridView ID="gvOrderSummary" runat="server" AutoGenerateColumns="False" CssClass="summary-table"
                    EmptyDataText="No items to display.">
                    <Columns>
                        <asp:BoundField DataField="ServiceName" HeaderText="Service" />
                        <asp:BoundField DataField="StylistName" HeaderText="Stylist" />
                        <asp:BoundField DataField="BookingDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:BoundField DataField="TimeSlot" HeaderText="Time" />
                        <asp:BoundField DataField="ServicePrice" HeaderText="Price" />
                    </Columns>
                </asp:GridView>
                <div style="text-align: right; margin-top: 1rem; padding: 0.5rem 1rem; background-color: #f8f9fa; border-radius: 8px;">
                    <span style="font-size: 18px; font-weight: 600; font-family: 'Georgia', 'serif';">Total Amount: </span>
                    <span style="font-size: 22px; font-weight: 700; color: #ff0000; font-family: 'Georgia', 'serif';">
                        <asp:Label ID="lblTotalAmount" runat="server"></asp:Label>
                    </span>
                </div>
            </div>

            <!-- Payment Methods Section -->
            <div class="payment-methods">
                <h3 class="payment-title">Select Payment Method</h3>
                <div class="payment-options">
                    <asp:RadioButtonList ID="rblPaymentMethods" runat="server" RepeatDirection="Horizontal" CssClass="payment-options-list">
                        <asp:ListItem Text="Credit/Debit Card" Value="card" Selected="True" />
                        <asp:ListItem Text="Net Banking" Value="netbanking" />
                        <asp:ListItem Text="UPI" Value="upi" />
                        <asp:ListItem Text="Wallet" Value="wallet" />
                    </asp:RadioButtonList>
                </div>

                <!-- Credit Card Form (will show/hide based on selection) -->
                <asp:Panel ID="pnlCardDetails" runat="server">
                    <div class="form-group">
                        <asp:Label ID="lblCardNumber" runat="server" CssClass="form-label" AssociatedControlID="txtCardNumber">Card Number</asp:Label>
                        <asp:TextBox ID="txtCardNumber" runat="server" CssClass="form-control" placeholder="1234 5678 9012 3456" MaxLength="19"></asp:TextBox>
                    </div>
                    <div style="display: flex; gap: 1rem;">
                        <div class="form-group" style="flex: 1;">
                            <asp:Label ID="lblExpiry" runat="server" CssClass="form-label" AssociatedControlID="txtExpiry">Expiry (MM/YY)</asp:Label>
                            <asp:TextBox ID="txtExpiry" runat="server" CssClass="form-control" placeholder="MM/YY" MaxLength="5"></asp:TextBox>
                        </div>
                        <div class="form-group" style="flex: 1;">
                            <asp:Label ID="lblCVV" runat="server" CssClass="form-label" AssociatedControlID="txtCVV">CVV</asp:Label>
                            <asp:TextBox ID="txtCVV" runat="server" CssClass="form-control" placeholder="123" MaxLength="3" TextMode="Password"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblCardName" runat="server" CssClass="form-label" AssociatedControlID="txtCardName">Name on Card</asp:Label>
                        <asp:TextBox ID="txtCardName" runat="server" CssClass="form-control" placeholder="John Doe"></asp:TextBox>
                    </div>
                </asp:Panel>

                <!-- UPI Form (initially hidden) -->
                <asp:Panel ID="pnlUPI" runat="server" Visible="false">
                    <div class="form-group">
                        <asp:Label ID="lblUPIID" runat="server" CssClass="form-label" AssociatedControlID="txtUPIID">UPI ID</asp:Label>
                        <asp:TextBox ID="txtUPIID" runat="server" CssClass="form-control" placeholder="username@upi"></asp:TextBox>
                    </div>
                </asp:Panel>
            </div>

            <!-- Hidden fields for PayU integration -->
            <asp:HiddenField ID="hdnPaymentId" runat="server" />
            <asp:HiddenField ID="hdnKey" runat="server" />
            <asp:HiddenField ID="hdnHash" runat="server" />
            <asp:HiddenField ID="hdnTxnId" runat="server" />
            <asp:HiddenField ID="hdnAmount" runat="server" />
            <asp:HiddenField ID="hdnProductInfo" runat="server" />
            <asp:HiddenField ID="hdnFirstName" runat="server" />
            <asp:HiddenField ID="hdnEmail" runat="server" />
            <asp:HiddenField ID="hdnPhone" runat="server" />
            <asp:HiddenField ID="hdnSurl" runat="server" />
            <asp:HiddenField ID="hdnFurl" runat="server" />

            <!-- Action Buttons -->
            <div class="btn-container">
                <asp:Button ID="btnBack" runat="server" Text="Back to Appointments" CssClass="btn btn-back" OnClick="btnBack_Click" />
                <asp:Button ID="btnPay" runat="server" Text="Complete Payment" CssClass="btn btn-pay" OnClick="btnPay_Click" />
            </div>

            <div class="secure-info">
                <i class="fa-solid fa-lock lock-icon"></i>
                <span>All payments are secure and encrypted</span>
            </div>
        </asp:Panel>
    </div>

    <script type="text/javascript">
        document.addEventListener('DOMContentLoaded', function () {
            const radioButtons = document.querySelectorAll('input[name$="rblPaymentMethods"]');
            const cardPanel = document.getElementById('<%= pnlCardDetails.ClientID %>');
            const upiPanel = document.getElementById('<%= pnlUPI.ClientID %>');

            // Function to handle payment method change
            function handlePaymentMethodChange() {
                const selectedValue = document.querySelector('input[name$="rblPaymentMethods"]:checked').value;
                
                // Hide all panels first
                cardPanel.style.display = 'none';
                upiPanel.style.display = 'none';
                
                // Show the relevant panel
                if (selectedValue === 'card') {
                    cardPanel.style.display = 'block';
                } else if (selectedValue === 'upi') {
                    upiPanel.style.display = 'block';
                }
            }

            // Add change event listener to each radio button
            radioButtons.forEach(function(radio) {
                radio.addEventListener('change', handlePaymentMethodChange);
            });

            // Initial state setup
            handlePaymentMethodChange();
            
            // Format card number with spaces
            const cardNumberInput = document.getElementById('<%= txtCardNumber.ClientID %>');
            cardNumberInput.addEventListener('input', function(e) {
                let value = e.target.value.replace(/\s+/g, '').replace(/[^0-9]/gi, '');
                let formattedValue = '';
                
                for (let i = 0; i < value.length; i++) {
                    if (i > 0 && i % 4 === 0) {
                        formattedValue += ' ';
                    }
                    formattedValue += value[i];
                }
                
                e.target.value = formattedValue;
            });
            
            // Format expiry date
            const expiryInput = document.getElementById('<%= txtExpiry.ClientID %>');
            expiryInput.addEventListener('input', function (e) {
                let value = e.target.value.replace(/\s+/g, '').replace(/[^0-9]/gi, '');

                if (value.length > 2) {
                    value = value.substring(0, 2) + '/' + value.substring(2, 4);
                }

                e.target.value = value;
            });
        });
    </script>
</asp:Content>