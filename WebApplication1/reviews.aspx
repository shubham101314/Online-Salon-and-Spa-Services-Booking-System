<%@ Page Title="Customer Reviews" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeFile="reviews.aspx.cs" Inherits="WebApplication1.reviews" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            background-color: #f9f9f9;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
        }
        h1 {
            font-family: 'Georgia', serif;
            text-align: center;
            margin: 30px 0;
            color: #333;
            text-shadow: 1px 1px 2px #333;
        }
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        .reviews {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            max-width: 1200px;
            width: 100%;
        }
        .review-item {
            background-color: #fff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .review-item:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }
        .review-item h2 {
            font-size: 22px;
            color: #444;
            margin-bottom: 10px;
        }
        .review-item h4 {
            font-family: 'Georgia', serif;
            color: #333;
            line-height: 1.6;
        }
        .reviewer {
            font-style: italic;
            color: #555;
            margin-top: 10px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Customer Reviews</h1>

    <div class="container">
        <div class="reviews">
            <div class="review-item">
                <h2>"Amazing Service!"</h2>
                <h4>I had a fantastic experience with the spa services. The staff was professional, and the ambiance was perfect for relaxation.</h4>
                <h4 class="reviewer">- Sarah L.</h4>
            </div>

            <div class="review-item">
                <h2>"Best Haircut Ever!"</h2>
                <h4>The hairstylist did an excellent job. They understood exactly what I wanted and exceeded my expectations. Highly recommended!</h4>
                <h4 class="reviewer">- John M.</h4>
            </div>

            <div class="review-item">
                <h2>"Exceptional Quality"</h2>
                <h4>From booking the appointment to the actual service, everything was seamless. The team is friendly and very skilled.</h4>
                <h4 class="reviewer">- Emily R.</h4>
            </div>

            <div class="review-item">
                <h2>"Will Visit Again"</h2>
                <h4>The manicure and pedicure services were excellent. I felt pampered and well taken care of. I will definitely return!</h4>
                <h4 class="reviewer">- Rachel T.</h4>
            </div>
        </div>
    </div>
</asp:Content>
