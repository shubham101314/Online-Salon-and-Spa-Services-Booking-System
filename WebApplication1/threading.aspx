<%@ Page Title="Threading" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeFile="threading.aspx.cs" Inherits="WebApplication1.threading" %>

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
        .threading-item {
            width: 100%;
            max-width: 500px;
            border-radius: 10px;
            background: #fff;
            padding: 10px;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .threading-image {
            width: 100%;
            max-width: 450px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            cursor: pointer;
        }
        .threading-item:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
        }
        .threading-name {
            font-size: 18px;
            font-weight: bold;
            margin-top: 10px;
        }
        .threading-price {
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
    <h2 style="text-align:center;">Threading Services</h2>
    <div class="image-gallery">
        <asp:Repeater ID="rptThreading" runat="server">
            <ItemTemplate>
                <div class="threading-item">
                    <img src='<%# ResolveUrl(Eval("ImagePath").ToString()) %>' class="threading-image" 
                         onclick='goToServiceCart("<%# Eval("ImagePath") %>", "<%# Eval("Name") %>", "<%# Eval("Price") %>")' 
                         alt='<%# Eval("Name") %>' />
                   
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
