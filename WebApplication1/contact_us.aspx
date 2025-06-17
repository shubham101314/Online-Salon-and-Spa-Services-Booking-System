<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" 
    AutoEventWireup="true" CodeFile="contact_us.aspx.cs" 
    Inherits="WebApplication1.contact_us" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Contact Us</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500&display=swap" rel="stylesheet">

  <!-- Minimal style block for keyframe animations (optional) -->
  <style>
    /* Fade in from below */
    @keyframes fadeInUp {
      0% {
        opacity: 0;
        transform: translateY(30px);
      }
      100% {
        opacity: 1;
        transform: translateY(0);
      }
    }

    /* Simple fade in */
    @keyframes fadeIn {
      0% {
        opacity: 0;
      }
      100% {
        opacity: 1;
      }
    }
  </style>
</head>

<body 
  style="
    margin: 0;
    padding: 0;
    font-family: Arial, sans-serif;
    color: #fff;
    position: relative; /* allows layering of background div */
    min-height: 100vh; /* ensures body is tall enough for full screen */
  "
>
  <!-- Blurred Background Div -->
  <div 
    style="
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: url('homepage_bg.jpg') center center / cover no-repeat;
      filter: blur(8px);
      -webkit-filter: blur(8px);
      z-index: -1; 
    "
  ></div>

  <!-- Main Container (semi-transparent overlay) -->
  <div 
    style="
      width: 80%;
      max-width: 600px;
      margin: 40px auto;
      background-color: rgba(0,0,0,0.7); /* Dark overlay for contrast */
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
      animation: fadeInUp 1s ease-in-out;
    "
  >
   <!-- Logo at the top -->
<div style="text-align: center; margin-bottom: 20px;">
  <!-- Replace 'Logo.jpg' with the correct path/URL to your NS logo -->
  <img 
    src="Logo.jpg" 
    alt="NS Logo" 
    style="
      width: 120px; 
      height: 120px; 
      border-radius: 50%;
      object-fit: cover;
      animation: fadeIn 1s ease-in-out;
    "
  />
</div>
    <!-- Page Heading -->
    <h1 
      style="
        text-align: center; 
        margin-bottom: 20px; 
        color: #fff;
        animation: fadeIn 1s ease-in-out;
      "
    >
      Contact Us
    </h1>

    <!-- Description -->
    <p 
      style="
    font-family: 'Georgia', serif;
        text-align: center; 
        color: #ddd; 
        margin-bottom: 20px;
        animation: fadeIn 1s ease-in-out 0.5s forwards;
        opacity: 0;
         font-size: 18px;
      "
    >
      Feel free to contact us and we will get back to you as soon as we can.
    </p>

    <!-- Contact Form -->
    <form 
      action="#" 
      method="POST" 
      style="
        animation: fadeIn 1s ease-in-out 0.7s forwards;
        opacity: 0;
      "
    >
      <!-- Full Name -->
      <div style="margin-bottom: 15px;">
        <label 
          for="full_name" 
          style="
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
          "
        >
          Full Name:
        </label>
        <input 
          type="text" 
          id="full_name" 
          name="full_name" 
          placeholder="Enter your full name"
          style="
            width: 100%;
            box-sizing: border-box;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
          "
          required
        />
      </div>

      <!-- Email -->
      <div style="margin-bottom: 15px;">
        <label 
          for="email" 
          style="
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
          "
        >
          Email Address:
        </label>
        <input 
          type="email" 
          id="email" 
          name="email" 
          placeholder="Enter your email"
          style="
            width: 100%;
            box-sizing: border-box;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
          "
          required
        />
      </div>

      <!-- Message -->
      <div style="margin-bottom: 15px;">
        <label 
          for="message" 
          style="
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
          "
        >
          Message:
        </label>
        <textarea
          id="message"
          name="message"
          placeholder="Enter your message"
          style="
            width: 100%;
            box-sizing: border-box;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            height: 100px;
            resize: vertical;
            font-size: 16px;
          "
          required
        ></textarea>
      </div>

      <!-- Submit Button -->
      <div style="text-align: center; margin-top: 10px;">
        <button 
          type="submit"
          onmouseover="this.style.backgroundColor='#5a2b6a'; this.style.transform='scale(1.05)'"
          onmouseout="this.style.backgroundColor='#4a235a'; this.style.transform='scale(1.0)'"
          style="
            background-color: #4a235a;
            color: #fff;
            border: none;
            padding: 12px 30px;
            font-size: 16px;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.3s ease;
          "
        >
          Send
        </button>
      </div>
    </form>

    <!-- Contact Information -->
    <div 
      style="
        margin-top: 30px;
        animation: fadeIn 1s ease-in-out 1s forwards;
        opacity: 0;
      "
    >
      <h2 
        style="
          margin-bottom: 10px; 
          color: #fff;
        "
      >
        Contact Customer Care
      </h2>
      <p style="margin-bottom: 8px; color: #ccc;">
        <strong>Email:</strong>
        <a 
          href="mailto:premiumDecor@gmail.com" 
          style="color: #ffd700; text-decoration: none;"

        >
          nsrtunisexsalon899@gmail.com
        </a>
      </p>
      <p style="margin-bottom: 8px; color: #ccc;">
        <strong>Phone:</strong>
        <a 
          href="tel:7887955899" 
          style="color: #ffd700; text-decoration: none;     font-family: serif;"
"

        >
          7887955899
        </a>
      </p>
    </div>

    <!-- Registered Head Office -->
    <div 
      style="
        margin-top: 30px;
        animation: fadeIn 1s ease-in-out 1.2s forwards;
        opacity: 0;
      "
    >
      <h2 
        style="
          margin-bottom: 10px; 
          color: #fff;
        "
      >
        Registered Head Office
      </h2>
      <p style="margin-bottom: 5px; color: #ccc;">
        <strong>Address:</strong><br />
       Shop No, B-7, Kuber Imperia, Datta Mandir Rd,
<br />
         near Polaris Health Care, Shankar Kalat Nagar, Wakad, 
<br />
Pune 411057,India      </p>
    </div>
  </div>
</body>
</html>

</asp:Content>
