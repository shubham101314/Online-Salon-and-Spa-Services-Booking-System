<%@ Page Title="Hair Spa" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeFile="hairspa.aspx.cs" Inherits="WebApplication1.hairspa" %>

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
        .hairspa-item {
            width: 100%;
            max-width: 500px;
            border-radius: 10px;
            background: #fff;
            padding: 10px;
            text-align: center;
        }
        .hairspa-image {
            width: 100%;
            max-width: 450px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .hairspa-item:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2 style="text-align:center;">Hair Spa Services</h2>
    <div class="image-gallery">
        <asp:Repeater ID="rptHairSpa" runat="server">
            <ItemTemplate>
                <div class="hairspa-item">
                    <a href='booking.aspx?id=<%# Eval("HairSpaID") %>&type=HairSpa'>
                        <img src='<%# Eval("ImagePath") %>' class="hairspa-image" />
                    </a>
                   
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
