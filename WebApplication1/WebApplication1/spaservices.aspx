<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeFile="SalonServices.aspx.cs" Inherits="WebApplication1.SalonServices" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   <style>
        h3 {
            color: #ffd700;

        }
        p{
            color:#ffffff;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section id="services" class="services">
        <h1>Spa Services</h1>
        <div class="service-list">
            <a href="manicure.aspx" class="service-item">
                <h3>Manicure</h3>
                <p>Relieve stress through various manicures.</p>
            </a>
            <a href="pedicure.aspx" class="service-item">
                <h3>Pedicures</h3>
                <p>Relieve stress through various pedicures.</p>
            </a>
            <a href="hairspa.aspx" class="service-item">
                <h3>Hair Spa</h3>
                <p>Shape, style, smoothen your hair to perfection.</p>
            </a>
            <a href="threading.aspx" class="service-item">
                <h3>Threading</h3>
                <p>Thread your way to wow.</p>
            </a>
            <a href="touchups.aspx" class="service-item">
                <h3>Touchups</h3>
                <p>Variety of touch-ups for instant and important appearances.</p>
            </a>
            <a href="treatment.aspx" class="service-item">
                <h3>Treatments</h3>
                <p>Basic as well as advanced treatments for a good appearance.</p>
            </a>
            <a href="maskspa.aspx" class="service-item">
                <h3>Mask Spa</h3>
                <p>The Masked Retreat: A Spa Journey for Your Skin.</p>
            </a>
        </div>
    </section>
</asp:Content>
