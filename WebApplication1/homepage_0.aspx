<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="homepage_0.aspx.cs" Inherits="WebApplication1.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Swiper CSS -->
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
    <link rel="stylesheet" type="text/css" href="style1.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="main-content-wrapper">
        <!-- Hero Section -->
        <section class="hero">
            <div class="hero-content">
                <h2>Welcome to N S Salon</h2>
                <p>Experience the best haircut and grooming services</p>
                
                <!-- Gallery Section -->
                <div class="gallery-section">
                    <h2>Our Gallery</h2>
                    <div class="swiper mySwiper">
                        <div class="swiper-wrapper">
                            <!-- Gallery Items -->
                            <div class="swiper-slide">
                                <div class="gallery-card">
                                    <a href="gallary.aspx">
                                        <img src="images/IMG_5682.jpg" alt="Salon Interior" />
                                        <div class="overlay"></div>
                                    </a>
                                </div>
                            </div>
                            <div class="swiper-slide">
                                <div class="gallery-card">
                                    <a href="gallary.aspx">
                                        <img src="images/IMG_5664.jpg" alt="Haircut Style" />
                                        <div class="overlay"></div>
                                    </a>
                                </div>
                            </div>
                            <div class="swiper-slide">
                                <div class="gallery-card">
                                    <a href="gallary.aspx">
                                        <img src="images/IMG_5667.jpg" alt="Styling Service" />
                                        <div class="overlay"></div>
                                    </a>
                                </div>
                            </div>
                            <div class="swiper-slide">
                                <div class="gallery-card">
                                    <a href="gallary.aspx">
                                        <img src="images/IMG_5671.jpg" alt="Haircut Style" />
                                        <div class="overlay"></div>
                                    </a>
                                </div>
                            </div>
                            <div class="swiper-slide">
                                <div class="gallery-card">
                                    <a href="gallary.aspx">
                                        <img src="images/IMG_5681.jpg" alt="Salon Service" />
                                        <div class="overlay"></div>
                                    </a>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Swiper Navigation Buttons -->
                        <div class="swiper-button-next"></div>
                        <div class="swiper-button-prev"></div>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <!-- Swiper JS -->
    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var swiper = new Swiper(".mySwiper", {
                slidesPerView: 4,
                spaceBetween: 20,
                loop: true,
                autoplay: {
                    delay: 2000,
                    disableOnInteraction: false,
                },
                navigation: {
                    nextEl: ".swiper-button-next",
                    prevEl: ".swiper-button-prev",
                },
                breakpoints: {
                    1024: { slidesPerView: 4 },
                    768: { slidesPerView: 2 },
                    480: { slidesPerView: 1 },
                },
            });
        });
    </script>
</asp:Content>