<%@ Page Title="Touch Ups" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeFile="touchups.aspx.cs" Inherits="WebApplication1.touchups" %>

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
        .touchup-item {
            width: 100%;
            max-width: 500px;
            border-radius: 10px;
            background: #fff;
            padding: 10px;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .touchup-image {
            width: 100%;
            max-width: 450px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            cursor: pointer;
        }
        .touchup-item:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
        }
        .touchup-name {
            font-size: 18px;
            font-weight: bold;
            margin-top: 10px;
        }
        .touchup-price {
            color: #333;
            font-size: 16px;
            margin-top: 5px;
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
    <h2 style="text-align:center;">Touch Ups Services</h2>
    <div class="image-gallery">
        <asp:Repeater ID="rptTouchUps" runat="server">
            <ItemTemplate>
                <div class="touchup-item">
                    <img src='<%# ResolveUrl(Eval("ImagePath").ToString()) %>' class="touchup-image" 
                         onclick='goToServiceCart("<%# Eval("ImagePath") %>", "<%# Eval("Name") %>", "<%# Eval("Price") %>")' 
                         alt='<%# Eval("Name") %>' />
                    
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
