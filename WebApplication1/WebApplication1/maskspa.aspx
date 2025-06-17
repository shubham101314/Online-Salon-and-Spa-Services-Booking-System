<%@ Page Title="Mask & Spa" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeFile="maskspa.aspx.cs" Inherits="WebApplication1.maskspa" %>

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
        .maskspa-item {
            width: 100%;
            max-width: 500px;
            border-radius: 10px;
            background: #fff;
            padding: 10px;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .maskspa-image {
            width: 100%;
            max-width: 450px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            cursor: pointer;
        }
        .maskspa-item:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
        }
        .maskspa-name {
            font-size: 18px;
            font-weight: bold;
            margin-top: 10px;
        }
        .maskspa-price {
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
    <h2 style="text-align:center;">Mask & Spa Services</h2>
    <div class="image-gallery">
        <asp:Repeater ID="rptMaskSpa" runat="server">
            <ItemTemplate>
                <div class="maskspa-item">
                    <img src='<%# ResolveUrl(Eval("ImagePath").ToString()) %>' class="maskspa-image" 
                         onclick='goToServiceCart("<%# Eval("ImagePath") %>", "<%# Eval("Name") %>", "<%# Eval("Price") %>")' 
                         alt='<%# Eval("Name") %>' />
                    
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
