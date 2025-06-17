<%@ Page Title="Payment Success" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeFile="PaymentSuccess.aspx.cs" Inherits="WebApplication1.PaymentSuccess" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .success-container {
            max-width: 600px;
            margin: 3rem auto;
            padding: 2rem;
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
            text-align: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .success-icon {
            font-size: 60px;
            color: #28a745;
            margin-bottom: 1rem;
        }
        
        .success-title {
            font-size: 28px;
            color: #333;
            margin-bottom: 1rem;
            font-weight: 600;
        }
        
        .success-message {
            font-size: 16px;
            color: #666;
            margin-bottom: 1.5rem;
            line-height: 1.5;
        }
        
        .order-details {
            background-color: #f8f9fa;
            padding: 1.5rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            text-align: left;
        }
        
        .detail-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
            font-size: 15px;
        }
        
        .detail-label {
            font-weight: 500;
            color: #555;
        }
        
        .detail-value {
            color: #333;
        }
        
        .action-buttons {
            margin-top: 2rem;
        }
        
        .btn {
            display: inline-block;
            padding: 0.75rem 1.5rem;
            font-size: 16px;
            border-radius: 50px;
            text-decoration: none;
            margin: 0 0.5rem;
            transition: all 0.3s;
            font-weight: 500;
        }
        
        .btn-primary {
            background-color: #0066cc;
            color: white;
            border: none;
        }
        
        .btn-primary:hover {
            background-color: #0056b3;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        
        .btn-outline {
            background-color: transparent;
            color: #0066cc;
            border: 1px solid #0066cc;
        }
        
        .btn-outline:hover {
            background-color: #f0f7ff;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="success-container">
        <div class="success-icon">
            <i class="fas fa-check-circle"></i>
        </div>
        
        <h1 class="success-title">Payment Successful!</h1>
        
        <p class="success-message">
            Thank you for your payment. Your transaction has been completed successfully.
            We've sent a confirmation email with all the details to your registered email address.
        </p>
        
        <div class="order-details">
            <div class="detail-row">
                <span class="detail-label">Order ID:</span>
                <span class="detail-value"><asp:Literal ID="ltlOrderId" runat="server"></asp:Literal></span>
            </div>
            
            <div class="detail-row">
                <span class="detail-label">Transaction ID:</span>
                <span class="detail-value"><asp:Literal ID="ltlTransactionId" runat="server"></asp:Literal></span>
            </div>
            
            <div class="detail-row">
                <span class="detail-label">Date:</span>
                <span class="detail-value"><asp:Literal ID="ltlDate" runat="server"></asp:Literal></span>
            </div>
            
            <div class="detail-row">
                <span class="detail-label">Amount:</span>
                <span class="detail-value"><asp:Literal ID="ltlAmount" runat="server"></asp:Literal></span>
            </div>
            
            <div class="detail-row">
                <span class="detail-label">Payment Method:</span>
                <span class="detail-value"><asp:Literal ID="ltlPaymentMethod" runat="server"></asp:Literal></span>
            </div>
        </div>
        
        <div class="action-buttons">
            <a href="OrderDetails.aspx?id=<%= OrderId %>" class="btn btn-primary">View Order Details</a>
            <a href="Default.aspx" class="btn btn-outline">Continue Shopping</a>
        </div>
    </div>
</asp:Content>