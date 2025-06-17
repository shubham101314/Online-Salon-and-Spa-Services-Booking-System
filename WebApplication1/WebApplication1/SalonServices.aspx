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
        <h1>Salon Services</h1>
        <div class="service-list">
            <a href="haircut.aspx" class="service-item">
                <h3>Men's Haircut</h3>
                <p>Get a stylish haircut from our expert barbers.</p>
            </a>
            <a href="womens_haircut.aspx" class="service-item">
                <h3>Women's Haircut</h3>
                <p>Get a stylish haircut from our expert barbers.</p>
            </a>
            <a href="shaving.aspx" class="service-item">
                <h3>Shaving/Beard Trim</h3>
                <p>Enjoy a clean and refreshing shave.</p>
                <p>Shape and style your beard to perfection.</p>
            </a>
            <a href="waxing.aspx" class="service-item">
                <h3>Waxing</h3>
                <p>Waxing for a clean and brighter look.</p>
            </a>
            <a href="facials.aspx" class="service-item">
                <h3>Facials</h3>
                <p>Basic as well as advanced cleanups.</p>
            </a>
            <a href="haircolors.aspx" class="service-item">
                <h3>Hair Colors</h3>
                <p>Stylish and glossy hair.</p>
            </a>
            <a href="nailart.aspx" class="service-item">
                <h3>Nail Art</h3>
                <p>Basic as well as advanced treatments for strong and stylish nails.</p>
            </a>
        </div>
    </section>
</asp:Content>