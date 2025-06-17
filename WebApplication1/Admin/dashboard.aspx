<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site2.Master" AutoEventWireup="true" CodeFile="dashboard.aspx.cs" Inherits="WebApplication1.Admin.dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main-content">
        <!-- Welcome Header -->
        <div class="welcome-header">
            <div class="welcome-text">
                <h1>Salon Management Dashboard</h1>
                <p>Welcome back, <asp:Label ID="lblManagerName" runat="server" Text="Salon Manager"></asp:Label></p>
            </div>
           
        </div>
        
        <!-- Stats Dashboard Cards -->
        <div class="stats-container">
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-calendar-check"></i>
                </div>
                <div class="stat-content">
                    <div class="stat-value">
                        <asp:Label ID="lblTotalAppointments" runat="server" Text="2"></asp:Label>
                    </div>
                    <div class="stat-label">Total Appointments</div>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-users"></i>
                </div>
                <div class="stat-content">
                    <div class="stat-value">
                        <asp:Label ID="lblTotalClients" runat="server" Text="1"></asp:Label>
                    </div>
                    <div class="stat-label">Total Clients</div>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-cut"></i>
                </div>
                <div class="stat-content">
                    <div class="stat-value">
                        <asp:Label ID="lblTotalServices" runat="server" Text="2"></asp:Label>
                    </div>
                    <div class="stat-label">Total Services</div>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-user-tie"></i>
                </div>
                <div class="stat-content">
                    <div class="stat-value">
                        <asp:Label ID="lblTotalStaff" runat="server" Text="2"></asp:Label>
                    </div>
                    <div class="stat-label">Total Staff</div>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-money-bill-wave"></i>
                </div>
                <div class="stat-content">
                    <div class="stat-value">
                        ₹<asp:Label ID="lblTotalRevenue" runat="server" Text="2350"></asp:Label>
                    </div>
                    <div class="stat-label">Total Revenue</div>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-user"></i>
                </div>
                <div class="stat-content">
                    <div class="stat-value">
                        <asp:Label ID="lblTotalUsers" runat="server" Text="5"></asp:Label>
                    </div>
                    <div class="stat-label">Total Users</div>
                </div>
            </div>
        </div>
        
        <!-- Recent Appointments Section -->
        <div class="recent-appointments">
            <div class="section-header">
                <h3><i class="fas fa-clock"></i> Recent Appointments</h3>
                <div class="actions">
                    <button class="refresh-btn"><i class="fas fa-sync-alt"></i> Refresh</button>
                    <button class="view-all-btn"><i class="fas fa-list"></i> View All</button>
                </div>
            </div>
            <div class="table-responsive">
                <asp:GridView ID="gvRecentAppointments" runat="server" CssClass="appointment-table" AutoGenerateColumns="false" EmptyDataText="No appointments to display">
                    <Columns>
                        <asp:TemplateField HeaderText="Booking ID">
                            <ItemTemplate>
                                <div class="booking-id">#<%# Eval("BookingID") %></div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="UserID" HeaderText="Client ID" />
                        <asp:TemplateField HeaderText="Service">
                            <ItemTemplate>
                                <div class="service-cell">
                                    <span class="service-icon"><i class="fas fa-spa"></i></span>
                                    <span class="service-name"><%# Eval("ServiceName") %></span>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="BookingDate" HeaderText="Date" DataFormatString="{0:dd-MM-yyyy}" />
                        <asp:BoundField DataField="FormattedTime" HeaderText="Time Slot" />
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <span class="status-badge <%# GetStatusClass(Eval("PaymentStatus").ToString()) %>">
                                    <%# Eval("PaymentStatus") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <div class="action-buttons">
                                    <a href="#" class="action-btn view-btn" title="View Details"><i class="fas fa-eye"></i></a>
                                    <a href="#" class="action-btn edit-btn" title="Edit Appointment"><i class="fas fa-edit"></i></a>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>

    <style>
        /* Global Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background-color: #f5f7fa;
            color: #333;
        }
        
        /* Main Layout */
        .main-content {
            padding: 25px;
            margin-left: 240px; /* Match sidebar width */
            transition: margin-left 0.3s;
            min-height: calc(100vh - 60px); /* Subtract header height */
        }
        
        /* Welcome Header */
        .welcome-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 1px solid #e0e6ed;
        }
        
        .welcome-text h1 {
            font-size: 28px;
            color: #2c3e50;
            margin-bottom: 5px;
        }
        
        .welcome-text p {
            color: #7f8c8d;
            font-size: 16px;
        }
        
        .date-time {
            background-color: #f8fafc;
            padding: 8px 15px;
            border-radius: 6px;
            color: #5d6778;
            font-size: 14px;
            border: 1px solid #e0e6ed;
        }
        
        .date-time i {
            color: #3498db;
            margin-right: 5px;
        }
        
        /* Stats Container */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 35px;
        }
        
        /* Stat Card */
        .stat-card {
            display: flex;
            align-items: center;
            background-color: #fff;
            border-radius: 12px;
            padding: 24px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            border-left: 4px solid #4f46e5;
        }
        
        .stat-card:nth-child(2) {
            border-left-color: #16a34a;
        }
        
        .stat-card:nth-child(3) {
            border-left-color: #ea580c;
        }
        
        .stat-card:nth-child(4) {
            border-left-color: #0284c7;
        }
        
        .stat-card:nth-child(5) {
            border-left-color: #9333ea;
        }
        
        .stat-card:nth-child(6) {
            border-left-color: #e11d48;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.12);
        }
        
        /* Stat Icon */
        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 20px;
            font-size: 24px;
            color: white;
            background: linear-gradient(135deg, #4f46e5, #3730a3);
            box-shadow: 0 5px 15px rgba(79, 70, 229, 0.2);
        }
        
        .stat-card:nth-child(2) .stat-icon {
            background: linear-gradient(135deg, #16a34a, #166534);
            box-shadow: 0 5px 15px rgba(22, 163, 74, 0.2);
        }
        
        .stat-card:nth-child(3) .stat-icon {
            background: linear-gradient(135deg, #ea580c, #c2410c);
            box-shadow: 0 5px 15px rgba(234, 88, 12, 0.2);
        }
        
        .stat-card:nth-child(4) .stat-icon {
            background: linear-gradient(135deg, #0284c7, #075985);
            box-shadow: 0 5px 15px rgba(2, 132, 199, 0.2);
        }
        
        .stat-card:nth-child(5) .stat-icon {
            background: linear-gradient(135deg, #9333ea, #7e22ce);
            box-shadow: 0 5px 15px rgba(147, 51, 234, 0.2);
        }
        
        .stat-card:nth-child(6) .stat-icon {
            background: linear-gradient(135deg, #e11d48, #be123c);
            box-shadow: 0 5px 15px rgba(225, 29, 72, 0.2);
        }
        
        /* Stat Content */
        .stat-content {
            flex: 1;
        }
        
        .stat-value {
            font-size: 28px;
            font-weight: bold;
            color: #1e293b;
            margin-bottom: 5px;
        }
        
        .stat-label {
            font-size: 15px;
            color: #64748b;
            font-weight: 500;
        }
        
        /* Recent Appointments */
        .recent-appointments {
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.08);
            overflow: hidden;
        }
        
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 25px;
            background-color: #f8fafc;
            border-bottom: 1px solid #e0e6ed;
        }
        
        .section-header h3 {
            color: #1e293b;
            font-size: 18px;
            font-weight: 600;
        }
        
        .section-header h3 i {
            margin-right: 8px;
            color: #4f46e5;
        }
        
        .actions {
            display: flex;
            gap: 10px;
        }
        
        .refresh-btn, .view-all-btn {
            background-color: transparent;
            border: 1px solid #e0e6ed;
            color: #64748b;
            padding: 8px 15px;
            border-radius: 6px;
            font-size: 14px;
            cursor: pointer;
            display: flex;
            align-items: center;
            transition: all 0.2s;
        }
        
        .refresh-btn i, .view-all-btn i {
            margin-right: 5px;
        }
        
        .refresh-btn:hover, .view-all-btn:hover {
            background-color: #f1f5f9;
            color: #334155;
        }
        
        .view-all-btn {
            background-color: #f0f4ff;
            color: #4f46e5;
            border-color: #e0e7ff;
        }
        
        .view-all-btn:hover {
            background-color: #e0e7ff;
            color: #4338ca;
        }
        
        /* Table Responsive */
        .table-responsive {
            overflow-x: auto;
            padding: 0 10px 10px;
        }
        
        /* Appointment Table */
        .appointment-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-top: 10px;
        }
        
        .appointment-table th {
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
        
        .appointment-table td {
            padding: 16px 20px;
            border-bottom: 1px solid #e2e8f0;
            color: #334155;
            font-size: 14px;
            vertical-align: middle;
        }
        
        .appointment-table tr:hover td {
            background-color: #f8fafc;
        }
        
        .appointment-table tr:last-child td {
            border-bottom: none;
        }
        
        /* Service Cell Styling */
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
        
        .service-name {
            font-weight: 500;
        }
        
        /* Status Badge */
        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
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
        
        /* Booking ID */
        .booking-id {
            font-weight: 600;
            color: #1e293b;
        }
        
        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 8px;
        }
        
        .action-btn {
            width: 32px;
            height: 32px;
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #64748b;
            background-color: #f8fafc;
            border: 1px solid #e2e8f0;
            transition: all 0.2s;
        }
        
        .view-btn:hover {
            background-color: #eff6ff;
            color: #3b82f6;
            border-color: #bfdbfe;
        }
        
        .edit-btn:hover {
            background-color: #f0f9ff;
            color: #0ea5e9;
            border-color: #bae6fd;
        }
        
        /* Sidebar Styling */
        .sidebar {
            width: 240px;
            height: 100%;
            position: fixed;
            top: 0;
            left: 0;
            background: linear-gradient(180deg, #1e293b, #0f172a);
            overflow-y: auto;
            transition: all 0.3s;
            z-index: 1000;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
        }
        
        .sidebar-logo {
            padding: 20px;
            text-align: center;
            margin-bottom: 20px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        
        .sidebar-logo img {
            height: 60px;
        }
        
        .sidebar-menu {
            padding: 0 15px;
        }
        
        .menu-item {
            margin-bottom: 5px;
        }
        
        .menu-link {
            display: flex;
            align-items: center;
            padding: 12px 15px;
            color: #94a3b8;
            text-decoration: none;
            border-radius: 8px;
            transition: all 0.3s;
        }
        
        .menu-link i {
            margin-right: 12px;
            font-size: 18px;
            width: 24px;
            text-align: center;
        }
        
        .menu-link:hover, .menu-link.active {
            background-color: rgba(255,255,255,0.1);
            color: #f8fafc;
        }
        
        .menu-link.active {
            background-color: #4f46e5;
            color: white;
            box-shadow: 0 5px 10px rgba(79, 70, 229, 0.3);
        }
        
        /* Header Styling */
        .header {
            height: 60px;
            background-color: #fff;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 25px;
            position: sticky;
            top: 0;
            z-index: 999;
            margin-left: 240px;
        }
        
        .toggle-sidebar {
            background: none;
            border: none;
            color: #64748b;
            font-size: 20px;
            cursor: pointer;
        }
        
        .search-box {
            position: relative;
            margin-left: 20px;
        }
        
        .search-input {
            padding: 8px 15px 8px 40px;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            width: 280px;
            font-size: 14px;
            color: #334155;
            background-color: #f8fafc;
            transition: all 0.3s;
        }
        
        .search-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
        }
        
        .search-input:focus {
            outline: none;
            border-color: #4f46e5;
            background-color: #fff;
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
        }
        
        .header-right {
            display: flex;
            align-items: center;
        }
        
        .notification-btn {
            position: relative;
            background: none;
            border: none;
            color: #64748b;
            font-size: 18px;
            margin-right: 20px;
            cursor: pointer;
        }
        
        .notification-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background-color: #ef4444;
            color: white;
            font-size: 10px;
            width: 18px;
            height: 18px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .user-profile {
            display: flex;
            align-items: center;
            cursor: pointer;
        }
        
        .user-avatar {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            margin-right: 10px;
            border: 2px solid #e2e8f0;
        }
        
        .user-name {
            font-size: 14px;
            font-weight: 500;
            color: #334155;
        }
        
        .user-role {
            font-size: 12px;
            color: #64748b;
        }
        
        /* Footer Styling */
        .footer {
            margin-left: 240px;
            padding: 15px 25px;
            text-align: center;
            color: #64748b;
            font-size: 14px;
            border-top: 1px solid #e2e8f0;
            background-color: #fff;
        }
        
        /* Responsive Design */
        @media (max-width: 1024px) {
            .sidebar {
                width: 80px;
                transform: translateX(0);
            }
            
            .sidebar.collapsed {
                transform: translateX(-100%);
            }
            
            .main-content, .header, .footer {
                margin-left: 80px;
            }
            
            .sidebar-logo {
                padding: 15px 10px;
            }
            
            .menu-link span {
                display: none;
            }
            
            .menu-link i {
                margin-right: 0;
                font-size: 20px;
            }
            
            .stats-container {
                grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            }
        }
        
        @media (max-width: 768px) {
            .main-content, .header, .footer {
                margin-left: 0;
            }
            
            .sidebar {
                transform: translateX(-100%);
            }
            
            .sidebar.active {
                transform: translateX(0);
                width: 240px;
            }
            
            .sidebar.active .menu-link span {
                display: inline;
            }
            
            .sidebar.active .menu-link i {
                margin-right: 12px;
            }
            
            .welcome-header {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .date-time {
                margin-top: 10px;
            }
            
            .stats-container {
                grid-template-columns: 1fr;
            }
            
            .section-header {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .actions {
                margin-top: 10px;
            }
        }
    </style>

    <script type="text/javascript">
        function GetStatusClass(status) {
            if (status === "Pending") return "status-pending";
            if (status === "Confirmed") return "status-confirmed";
            if (status === "Cancelled") return "status-cancelled";
            if (status === "Completed") return "status-completed";
            return "";
        }
    </script>
</asp:Content>