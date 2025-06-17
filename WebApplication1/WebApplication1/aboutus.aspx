<%@ Page Title="About Us" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeFile="aboutus.aspx.cs" Inherits="WebApplication1.aboutus" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="style1.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="about-us-wrapper">
        <h1>About Us</h1>
        <div class="about-content">
            <div class="about-section">
                <h2>Welcome to Our Salon</h2>
                <p>
                    At Salon & Spa, we believe in creating extraordinary experiences that enhance your natural beauty and promote overall wellness. Our team of skilled professionals is dedicated to providing you with exceptional service in a luxurious and relaxing environment.
                </p>
            </div>

            <div class="about-section">
                <h2>Our Philosophy</h2>
                <p>
                    We are committed to delivering personalized beauty and wellness solutions that meet your unique needs. Using premium products and cutting-edge techniques, we ensure that every visit leaves you feeling refreshed, rejuvenated, and confident.
                </p>
            </div>

            <div class="about-section">
                <h2>Our Expertise</h2>
                <p>
                    From expert hair styling to rejuvenating spa treatments, our comprehensive range of services is designed to enhance your natural beauty and promote overall wellness. Our team stays current with the latest trends and techniques to provide you with the best possible care.
                </p>
            </div>
        </div>

        <div class="cta-section">
            <h2>Experience the Difference</h2>
            <p>Ready to treat yourself? Book an appointment with us today!</p>
            <a href="SalonServices.aspx" class="cta-button">Book Now</a>
        </div>
    </div>
</asp:Content>
