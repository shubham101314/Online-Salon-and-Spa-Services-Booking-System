<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site2.Master" AutoEventWireup="true" CodeFile="staff.aspx.cs" Inherits="WebApplication1.Admin.staff" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Staff Management</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary: #4e68da;
            --primary-dark: #3951c6;
            --primary-light: #eef1ff;
            --secondary: #36b9cc;
            --secondary-dark: #2a9aaa;
            --secondary-light: #e8f7fa;
            --success: #1cc88a;
            --danger: #e74a3b;
            --danger-light: #fbeaea;
            --gray-100: #f8f9fc;
            --gray-200: #eaecf4;
            --gray-300: #dddfeb;
            --gray-400: #d1d3e2;
            --gray-500: #b7b9cc;
            --gray-600: #858796;
            --gray-700: #6e707e;
            --gray-800: #5a5c69;
            --gray-900: #3a3b45;
            --text-color: #525f7f;
            --card-shadow: 0 0.46875rem 2.1875rem rgba(4, 9, 20, 0.03), 
                          0 0.9375rem 1.40625rem rgba(4, 9, 20, 0.03), 
                          0 0.25rem 0.53125rem rgba(4, 9, 20, 0.05), 
                          0 0.125rem 0.1875rem rgba(4, 9, 20, 0.03);
            --transition: all 0.25s ease-in-out;
        }

        body {
            color: var(--text-color);
            font-family: 'Nunito', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            font-size: 0.9rem;
        }

        .page-header {
            background: linear-gradient(135deg, var(--primary-light) 0%, #f8f9fa 100%);
            padding: 2.5rem 0;
            margin-bottom: 2rem;
            border-bottom: 1px solid var(--gray-200);
            position: relative;
        }

        .page-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url('data:image/svg+xml;charset=utf8,%3Csvg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320"%3E%3Cpath fill="%23ffffff" fill-opacity="0.4" d="M0,288L48,272C96,256,192,224,288,208C384,192,480,192,576,208C672,224,768,256,864,250.7C960,245,1056,203,1152,186.7C1248,171,1344,181,1392,186.7L1440,192L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"%3E%3C/path%3E%3C/svg%3E');
            background-repeat: no-repeat;
            background-position: bottom;
            background-size: 100%;
            z-index: 0;
            opacity: 0.8;
        }

        .page-header h2 {
            font-weight: 700;
            color: #ff0000;
            margin-bottom: 0.5rem;
            margin-inline-start:10px;
            position: relative;
            z-index: 1;
        }

        .page-header p {
            font-size: 1.1rem;
            opacity: 0.8;
            position: relative;
            z-index: 1;
            margin-inline-start:10px;

        }

        .card {
            border-radius: 0.75rem;
            box-shadow: var(--card-shadow);
            margin-bottom: 2rem;
            border: none;
            transition: var(--transition);
            overflow: hidden;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0.75rem 1.5rem rgba(18, 38, 63, 0.1);
        }

        .card-header {
            padding: 1.2rem 1.5rem;
            font-weight: 600;
            border-bottom: 1px solid var(--gray-200);
            display: flex;
            align-items: center;
        }

        .card-header i {
            margin-right: 0.75rem;
            font-size: 1.1rem;
        }

        .primary-card .card-header {
            background: var(--secondary-color);
            color: white;
        }

        .secondary-card .card-header {
            background: var(--secondary-color);
            color: white;
        }

        .card-body {
            padding: 1.75rem;
            background-color: white;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            font-weight: 600;
            color: var(--gray-700);
            margin-bottom: 0.5rem;
            display: block;
        }

        .form-control {
            border-radius: 0.5rem;
            padding: 0.75rem 1rem;
            border: 1px solid var(--gray-300);
            font-size: 0.9rem;
            transition: var(--transition);
            box-shadow: 0 2px 4px rgba(0,0,0,0.01);
        }

        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 0.2rem rgba(78, 115, 223, 0.15);
        }

        .btn {
            border-radius: 0.5rem;
            padding: 0.75rem 1.25rem;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .btn i {
            margin-right: 0.5rem;
        }

        .btn-primary {
            background: #000000;
            border: none;
            color: white;
            box-shadow: 0 4px 14px rgba(78, 115, 223, 0.4);
        }

        .btn-primary:hover {
            background:#ff0000;
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(78, 115, 223, 0.5);
        }

        .btn-block {
            width: 100%;
        }

        .btn-danger {
            background: #ff0000;
            box-shadow: 0 4px 14px rgba(231, 74, 59, 0.4);
        }

        .btn-danger:hover {
            background: #ff0000;
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(231, 74, 59, 0.5);
        }

        .table {
            border-collapse: separate;
            border-spacing: 0;
            width: 100%;
            border-radius: 0.5rem;
            overflow: hidden;
            box-shadow: 0 0 0 1px var(--gray-200);
        }

        .table th {
            background-color: var(--gray-100);
            color: var(--gray-700);
            font-weight: 700;
            padding: 1rem;
            border: none;
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 1px;
        }

        .table td {
            padding: 1rem;
            vertical-align: middle;
            border-top: 1px solid var(--gray-200);
            text-align:center;
        }

        .table-striped tbody tr:nth-of-type(odd) {
            background-color: var(--gray-100);
        }

        .table-hover tbody tr {
            transition: var(--transition);
        }

        .table-hover tbody tr:hover {
            background-color: var(--primary-light);
        }

        .action-btn {
            border-radius: 0.4rem;
            padding: 0.5rem 0.75rem;
            font-size: 0.8rem;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.35rem;
            transform-origin: center;
        }

        .action-btn:hover {
            transform: scale(1.05);
        }

        .success-message {
            padding: 1rem 1.25rem;
            margin-top: 1.5rem;
            border-radius: 0.5rem;
            background-color: rgba(28, 200, 138, 0.15);
            border-left: 4px solid var(--success);
            color: #155724;
            position: relative;
            display: flex;
            align-items: center;
        }

        .success-message::before {
            content: '\f058';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            margin-right: 0.75rem;
            font-size: 1.2rem;
            color: var(--success);
        }

        .error-message {
            padding: 1rem 1.25rem;
            margin-top: 1.5rem;
            border-radius: 0.5rem;
            background-color: var(--danger-light);
            border-left: 4px solid var(--danger);
            color: #721c24;
            position: relative;
            display: flex;
            align-items: center;
        }

        .error-message::before {
            content: '\f057';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            margin-right: 0.75rem;
            font-size: 1.2rem;
            color: var(--danger);
        }

        .alert {
            padding: 1rem 1.25rem;
            border-radius: 0.5rem;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
        }

        .alert-info {
            background-color: #e8f7fa;
            border-left: 4px solid var(--secondary);
            color: var(--secondary-dark);
        }

        .alert-info i {
            font-size: 1.2rem;
            margin-right: 0.75rem;
            color: var(--secondary);
        }

        /* Custom animation for fade in */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .fade-in {
            animation: fadeIn 0.5s ease forwards;
        }

        /* Custom scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
            height: 8px;
        }

        ::-webkit-scrollbar-track {
            background: var(--gray-100);
        }

        ::-webkit-scrollbar-thumb {
            background: var(--gray-400);
            border-radius: 4px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: var(--gray-500);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row page-header">
            <div class="col-md-12">
                <h2><i class="fas fa-cut"></i> Staff Management</h2>
                <p class="text-muted">Add, remove, and manage your salon's talented team members</p>
            </div>
        </div>
        
        <div class="row">
            <div class="col-lg-5">
                <div class="card primary-card fade-in">
                    <div class="card-header">
                       Add New Stylist
                    </div>
                    <div class="card-body">
                        <div class="form-group">
                            <label for="txtStylistName"><i class="fas fa-user"></i> Stylist Name:</label>
                            <asp:TextBox ID="txtStylistName" runat="server" CssClass="form-control" placeholder="Enter stylist full name"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvStylistName" runat="server" 
                                ControlToValidate="txtStylistName" 
                                ErrorMessage="Stylist name is required." 
                                Display="Dynamic" 
                                CssClass="text-danger mt-2"
                                ValidationGroup="AddStylist">
                            </asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group mb-0">
                            <asp:Button ID="btnAddStylist" runat="server" Text="Add Stylist" 
                                CssClass="btn btn-primary btn-block" OnClick="btnAddStylist_Click" 
                                ValidationGroup="AddStylist" />
                        </div>
                        
                        <div id="messageContainer" runat="server" visible="false">
                            <asp:Label ID="lblMessage" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-7">
                <div class="card secondary-card fade-in" style="animation-delay: 0.2s;">
                    <div class="card-header">
                        <i class="fas fa-users"></i> Current Stylists
                    </div>
                    <div class="card-body">
                        <asp:GridView ID="gvStylists" runat="server" AutoGenerateColumns="False" 
                            CssClass="table table-striped table-bordered table-hover" 
                            DataKeyNames="StylistID" OnRowCommand="gvStylists_RowCommand"
                            GridLines="None">
                            <Columns>
                                <asp:BoundField DataField="StylistID" HeaderText="ID" HeaderStyle-Width="70px" />
                                <asp:BoundField DataField="Name" HeaderText="Stylist Name" />
                                <asp:TemplateField HeaderText="Actions" HeaderStyle-Width="130px" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkDelete" runat="server" 
                                            CommandName="DeleteStylist" 
                                            CommandArgument='<%# Eval("StylistID") %>'
                                            CssClass="btn btn-danger action-btn" 
                                            OnClientClick="return confirm('Are you sure you want to delete this stylist? This action cannot be undone.');">
                                            <i class="fas fa-trash-alt"></i> Delete
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>
                                <div class="alert alert-info">
                                    <i class="fas fa-info-circle"></i> No stylists found in the database. Add your first stylist using the form.
                                </div>
                            </EmptyDataTemplate>
                            <HeaderStyle CssClass="thead-light" />
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">
    <script>
        $(document).ready(function () {
            // Show success/error messages with fade effect
            $("#<%= messageContainer.ClientID %>").hide().fadeIn('fast');
            
            // Auto-hide messages after 5 seconds
            setTimeout(function() {
                $("#<%= messageContainer.ClientID %>").fadeOut('slow');
            }, 5000);

            // Add smooth hover effect to table rows
            $(".table tbody tr").hover(
                function () {
                    $(this).css("transition", "background-color 0.3s ease");
                },
                function () {
                    $(this).css("transition", "background-color 0.3s ease");
                }
            );

            // Add ripple effect to buttons
            $(".btn").on("mousedown", function (e) {
                const button = $(this);

                // Remove any existing ripple elements
                $(".ripple").remove();

                // Create a new ripple element
                const ripple = $("<span class='ripple'></span>");
                button.append(ripple);

                // Set position
                const buttonPos = button.offset();
                const xPos = e.pageX - buttonPos.left;
                const yPos = e.pageY - buttonPos.top;

                ripple.css({
                    width: button.width() * 2,
                    height: button.width() * 2,
                    top: yPos - button.width(),
                    left: xPos - button.width(),
                    position: "absolute",
                    borderRadius: "50%",
                    transform: "scale(0)",
                    opacity: "0.4",
                    backgroundColor: "rgba(255, 255, 255, 0.5)",
                    transition: "all 0.7s cubic-bezier(0.4, 0, 0.2, 1)"
                });

                // Animate the ripple
                setTimeout(function () {
                    ripple.css({
                        transform: "scale(1)",
                        opacity: "0"
                    });
                }, 50);

                // Remove the ripple after animation completes
                setTimeout(function () {
                    ripple.remove();
                }, 700);
            });
        });
    </script>
    
    <style>
        /* Style for ripple effect */
        .btn {
            position: relative;
            overflow: hidden;
        }
        
        .ripple {
            z-index: 1;
            pointer-events: none;
        }
    </style>
</asp:Content>