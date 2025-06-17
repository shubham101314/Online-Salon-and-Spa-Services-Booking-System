<%@ Page Title="Waxing Services" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeFile="waxing.aspx.cs" Inherits="WebApplication1.waxing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .image-gallery {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 50px;
            justify-items: center;
            margin-top: 20px;
            margin-bottom: 20px;
        }

        .waxing-item {
            width: 100%;
            max-width: 500px;
            border-radius: 10px;
            background: #fff;
            padding: 10px;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .waxing-image {
            width: 100%;
            max-width: 450px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            cursor: pointer;
        }

        .waxing-item:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
        }
    </style>

    <script>
        function goToServiceCart(imageSrc, name, price) {
            window.location.href = 'servicecart.aspx?name=' + encodeURIComponent(name) + 
                                   '&price=' + encodeURIComponent(price) + 
                                   '&image=' + encodeURIComponent(imageSrc);
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2 style="text-align:center;">Waxing Services</h2>
    <div class="image-gallery">
        <asp:Repeater ID="rptWaxing" runat="server">
            <ItemTemplate>
                <div class="waxing-item">
                    <img src='<%# Eval("ImagePath") %>' class="waxing-image" 
                         onclick='goToServiceCart("<%# Eval("ImagePath") %>", "<%# Eval("Name") %>", "<%# Eval("Price") %>")' />
                    <div class="waxing-name"><%# Eval("Name") %></div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
