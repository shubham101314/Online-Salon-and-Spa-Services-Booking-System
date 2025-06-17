<%@ Page Title="Women's Haircuts" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeFile="womens_haircut.aspx.cs" Inherits="WebApplication1.womens_haircut" %>
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
        .haircut-item {
            width: 100%;
            max-width: 500px;
            border-radius: 10px;
            background: #fff;
            padding: 10px;
            text-align: center;
        }
        .haircut-image {
            width: 100%;
            max-width: 450px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            cursor: pointer;
        }
        .haircut-item:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
        }
        .haircut-name {
            margin-top: 10px;
            font-weight: bold;
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
    <h2 style="text-align:center;">Women's Haircuts</h2>
    <div class="image-gallery">
        <asp:Repeater ID="rptWomensHaircuts" runat="server">
            <ItemTemplate>
                <div class="haircut-item">
                    <img src='<%# Eval("ImagePath") %>' class="haircut-image" 
                         onclick='goToServiceCart("<%# Eval("ImagePath") %>", "<%# Eval("Name") %>", "<%# Eval("Price") %>")' />
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>