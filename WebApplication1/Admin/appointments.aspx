<%@ Page Title="Manage Appointments" Language="C#" MasterPageFile="~/Admin/Site2.Master" AutoEventWireup="true" CodeFile="appointments.aspx.cs" Inherits="WebApplication1.Admin.appointments" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main-content">
        <!-- Page Header -->
        <div class="page-header">
            <div class="header-content">
                <h1><i class="fas fa-calendar-check"></i> Manage Appointments</h1>
                <p>View and manage all salon appointment bookings</p>
            </div>
            <div class="header-actions">
                <a href="appointments.aspx" class="action-btn refresh-btn"><i class="fas fa-sync-alt"></i> Refresh</a>
                <a href="#" class="action-btn export-btn"><i class="fas fa-file-export"></i> Export</a>
            </div>
        </div>

        <!-- Status Message -->
        <asp:Label ID="lblStatusMessage" runat="server" CssClass="status-message" Visible="false"></asp:Label>

        <!-- Appointments Stats -->
        <div class="stats-row">
            <div class="stat-card">
                <div class="stat-icon" style="background: linear-gradient(135deg, #4f46e5, #3730a3);">
                    <i class="fas fa-calendar-day"></i>
                </div>
                <div class="stat-content">
                    <div class="stat-value"><asp:Label ID="lblTodayCount" runat="server" Text="12"></asp:Label></div>
                    <div class="stat-label">Today's Appointments</div>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon" style="background: linear-gradient(135deg, #16a34a, #166534);">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="stat-content">
                    <div class="stat-value"><asp:Label ID="lblPendingCount" runat="server" Text="8"></asp:Label></div>
                    <div class="stat-label">Pending Approval</div>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon" style="background: linear-gradient(135deg, #0284c7, #075985);">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="stat-content">
                    <div class="stat-value"><asp:Label ID="lblConfirmedCount" runat="server" Text="24"></asp:Label></div>
                    <div class="stat-label">Confirmed</div>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon" style="background: linear-gradient(135deg, #e11d48, #be123c);">
                    <i class="fas fa-times-circle"></i>
                </div>
                <div class="stat-content">
                    <div class="stat-value"><asp:Label ID="lblCancelledCount" runat="server" Text="3"></asp:Label></div>
                    <div class="stat-label">Cancelled</div>
                </div>
            </div>
        </div>

        <!-- Appointments Table -->
        <div class="table-card">
            <div class="table-responsive">
                <asp:GridView ID="gvAppointments" runat="server" CssClass="appointments-table" AutoGenerateColumns="false" 
                    OnRowCommand="gvAppointments_RowCommand" EmptyDataText="No appointments found" AllowPaging="true" 
                    PageSize="10" OnPageIndexChanging="gvAppointments_PageIndexChanging">
                    <PagerSettings Mode="NumericFirstLast" FirstPageText="First" LastPageText="Last" />
                    <PagerStyle CssClass="pagination" />
                    <Columns>
                        <asp:TemplateField HeaderText="Booking ID">
                            <ItemTemplate>
                                <div class="booking-id">#<%# Eval("BookingID") %></div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Client">
                            <ItemTemplate>
                                <div class="client-info">
                                    <span class="client-avatar"><i class="fas fa-user"></i></span>
                                    <span class="client-name"><%# Eval("ClientName") %></span>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Service">
                            <ItemTemplate>
                                <div class="service-cell">
                                    <span class="service-icon"><i class="fas fa-spa"></i></span>
                                    <span class="service-name"><%# Eval("ServiceName") %></span>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Stylist">
                            <ItemTemplate>
                                <div class="stylist-info">
                                    <span class="stylist-avatar"><i class="fas fa-user-tie"></i></span>
                                    <span class="stylist-name"><%# Eval("StylistName") %></span>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="BookingDate" HeaderText="Date" DataFormatString="{0:dd MMM yyyy}" />
                        <asp:BoundField DataField="TimeSlot" HeaderText="Time" />
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <span class="badge <%# GetStatusClass(Eval("PaymentStatus")) %>">
                                    <%# Eval("PaymentStatus") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Stylist Available">
                            <ItemTemplate>
                                <span class="availability-badge <%# Convert.ToBoolean(Eval("StylistAvailable")) ? "available" : "unavailable" %>">
                                    <%# Convert.ToBoolean(Eval("StylistAvailable")) ? "Available" : "Unavailable" %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <div class="action-buttons">
                                    <asp:Button ID="btnApprove" runat="server" CommandName="Approve" CommandArgument='<%# Eval("BookingID") %>' 
                                        CssClass="action-btn approve-btn" Text="Approve" ToolTip="Approve Appointment" />
                                    <asp:Button ID="btnDiscard" runat="server" CommandName="Discard" CommandArgument='<%# Eval("BookingID") %>' 
                                        CssClass="action-btn discard-btn" Text="Cancel" ToolTip="Cancel Appointment" />
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>

    <style>
        /* Main Container Styles */
        .main-content {
            padding: 25px;
            margin-left: 20px;
            transition: margin-left 0.3s;
            background-color: #f5f7fa;
            min-height: calc(100vh - 60px);
        }

        /* Status message */
        .status-message {
            display: block;
            padding: 10px 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            background-color: #e0e7ff;
            color: #4338ca;
            font-weight: 500;
            border-left: 4px solid #4f46e5;
        }

        .status-message.error {
            background-color: #fee2e2;
            color: #dc2626;
            border-left-color: #e11d48;
        }

        .status-message.success {
            background-color: #dcfce7;
            color: #16a34a;
            border-left-color: #16a34a;
        }

        /* Page Header */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 1px solid #e0e6ed;
        }

        .header-content h1 {
            font-size: 24px;
            color: #1e293b;
            margin-bottom: 5px;
            display: flex;
            align-items: center;
        }

        .header-content h1 i {
            margin-right: 10px;
            color: #4f46e5;
        }

        .header-content p {
            color: #64748b;
            font-size: 14px;
        }

        .header-actions {
            display: flex;
            gap: 10px;
        }

        .action-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 10px 16px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.2s;
            cursor: pointer;
            border: 1px solid #e2e8f0;
        }

        .action-btn i {
            margin-right: 10px;
        }

        .refresh-btn {
            background-color: #f8fafc;
            color: #64748b;
        }

        .refresh-btn:hover {
            background-color: #f1f5f9;
            color: #334155;
        }

        .export-btn {
            background-color: #f0f4ff;
            color: #4f46e5;
            border: 1px solid #e0e7ff;
        }

        .export-btn:hover {
            background-color: #e0e7ff;
            color: #4338ca;
        }

        /* Stats Row */
        .stats-row {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 25px;
        }

        .stat-card {
            display: flex;
            align-items: center;
            background-color: #fff;
            border-radius: 12px;
            padding: 18px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
            border-left: 4px solid #4f46e5;
        }

        .stat-card:nth-child(2) {
            border-left-color: #16a34a;
        }

        .stat-card:nth-child(3) {
            border-left-color: #0284c7;
        }

        .stat-card:nth-child(4) {
            border-left-color: #e11d48;
        }

        .stat-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 15px rgba(0,0,0,0.1);
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            font-size: 20px;
            color: white;
            box-shadow: 0 5px 10px rgba(0,0,0,0.1);
        }

        .stat-content {
            flex: 1;
        }

        .stat-value {
            font-size: 24px;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 3px;
        }

        .stat-label {
            font-size: 14px;
            color: #64748b;
            font-weight: 500;
        }

        /* Table Card */
        .table-card {
            background-color: #fff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 3px 10px rgba(0,0,0,0.05);
            margin-top:60px;
        }

        .table-responsive {
            overflow-x: auto;
            min-height: 300px;
            margin-top:15px;
        }

        /* Appointment Table */
        .appointments-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            
        }

        .appointments-table th {
            background-color: #f8fafc;
            color: #475569;
            font-weight: 600;
            text-align: left;
            padding: 16px 20px;
            font-size: 14px;
            border-bottom: 2px solid #e2e8f0;
            position: sticky;
            top: 0;
        }

        .appointments-table td {
            padding: 16px 20px;
            border-bottom: 1px solid #e2e8f0;
            color: #334155;
            font-size: 14px;
            vertical-align: middle;
        }

        .appointments-table tr:hover td {
            background-color: #f8fafc;
        }

        .appointments-table tr:last-child td {
            border-bottom: none;
        }

        /* Booking ID */
        .booking-id {
            font-weight: 600;
            color: #1e293b;
        }

        /* Client Info */
        .client-info, .stylist-info {
            display: flex;
            align-items: center;
        }

        .client-avatar, .stylist-avatar {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background-color: #e0e7ff;
            color: #4f46e5;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 10px;
        }

        .stylist-avatar {
            background-color: #f0fdf4;
            color: #16a34a;
        }

        .client-name, .stylist-name {
            font-weight: 500;
        }

        /* Service Cell */
        .service-cell {
            display: flex;
            align-items: center;
        }

        .service-icon {
            width: 32px;
            height: 32px;
            border-radius: 6px;
            background-color: #f0f9ff;
            color: #0284c7;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 10px;
        }

        /* Status Badges */
        .badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
            text-align: center;
        }

        .status-pending {
            background-color: #fef9c3;
            color: #ca8a04;
        }

        .status-confirmed {
            background-color: #dcfce7;
            color: #16a34a;
        }

        .status-cancelled {
            background-color: #fee2e2;
            color: #dc2626;
        }

        .status-completed {
            background-color: #e0e7ff;
            color: #4f46e5;
        }

        /* Availability Badge */
        .availability-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
            text-align: center;
        }

        .available {
            background-color: #dcfce7;
            color: #16a34a;
        }

        .unavailable {
            background-color: #fee2e2;
            color: #dc2626;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 8px;
        }

        .action-btn {
            min-width: 80px;
            height: 36px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #f8fafc;
            border: 1px solid #e2e8f0;
            transition: all 0.2s;
            cursor: pointer;
            color: #64748b;
            font-weight: 500;
        }

        .approve-btn {
            background-color: #f0fdf4;
            color: #16a34a;
            border-color: #dcfce7;
        }

        .approve-btn:hover {
            background-color: #dcfce7;
        }

        .discard-btn {
            background-color: #fef2f2;
            color: #dc2626;
            border-color: #fee2e2;
        }

        .discard-btn:hover {
            background-color: #fee2e2;
        }

        /* Pagination */
        .pagination {
            display: flex;
            justify-content: center;
            padding: 20px 0;
        }

        .pagination a, .pagination span {
            display: inline-block;
            padding: 8px 12px;
            margin: 0 3px;
            border-radius: 6px;
            color: #4f46e5;
            font-weight: 500;
            text-decoration: none;
        }

        .pagination a:hover {
            background-color: #e0e7ff;
        }

        .pagination span.current {
            background-color: #4f46e5;
            color: white;
        }

        /* Empty Data Text */
        .appointments-table td[colspan] {
            text-align: center;
            padding: 40px 20px;
            color: #64748b;
            font-style: italic;
        }

        /* Responsive Styles */
        @media (max-width: 1200px) {
            .stats-row {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 991px) {
            .main-content {
                margin-left: 0;
                padding: 20px;
            }

            .page-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .header-actions {
                width: 100%;
                justify-content: flex-start;
            }
        }

        @media (max-width: 768px) {
            .stats-row {
                grid-template-columns: 1fr;
            }

            .action-buttons {
                flex-wrap: wrap;
            }
        }
    </style>
</asp:Content>