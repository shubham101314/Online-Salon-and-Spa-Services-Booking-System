<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="WebApplication1.login" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>N S Salon</title>
    <link rel="stylesheet" type="text/css" href="styles1.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            background: url('Images/pixelcut-export.jpeg') no-repeat center center fixed;
            background-size: cover;
            font-family: Arial, sans-serif;
        }

        .login-container {
            width: 350px;
            margin: 100px auto;
            background: rgba(255, 255, 255, 0.9);
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
        }

        .profile-image img {
            width: 80px;
            height: 80px;
            border-radius: 50%;
        }

        p {
            text-align: center;
            margin-bottom: 20px;
            color: #000;
        }

        .error-message {
            color: red;
            text-align: center;
            font-weight: bold;
        }

        input, .aspNetTextbox {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        .btn {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            border-radius: 5px;
            border: none;
            background-color: #000;
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease-in-out;
        }

        .btn:hover {
            background-color: #444;
        }

        .input-container {
            position: relative;
            width: 100%;
        }

        .eye-icon {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            width: 20px;
        }

        .field-validation {
            color: red;
            font-size: 12px;
            text-align: left;
            margin-top: -5px;
            margin-bottom: 5px;
            padding-left: 5px;
        }
        
        a {
            color: #FF4500;
        }

        .social-icons {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 10px;
        }

        .social-icons img {
            width: 30px;
            height: 30px;
            cursor: pointer;
        }
        .swap-logo {
    position: absolute;
    top: 5px;
    right: 5px;
    width: 18px; /* Adjust size as needed */
    height: 18px;
}

.swap-logo img {
    width: 100%;
    height: auto;
    cursor: pointer;
}
.swap-logo {
    position: absolute;
    top: 5px;
    right: 5px;
    width: 18px;
    height: 18px;
}

.swap-logo img {
    width: 100%;
    height: auto;
    cursor: pointer;
}

.admin-popup {
    display: none;
    position: absolute;
    top: -5px; /* Adjust positioning */
    right: -75px;
    background-color: rgba(255, 255, 255, 0.9);
    color: #000000;
    padding: 5px 10px;
    font-size: 14px;
    font-weight: bold;
    border-radius: 5px;
    white-space: nowrap;
    box-shadow: 0 0 5px rgba(0, 0, 0, 0.5);
    font-family: 'Georgia','serif';
}

    </style>
</head>
<body>
    <div class="login-container animated fadeIn">
     <div class="swap-logo" onmouseover="showPopup()" onmouseout="hidePopup()">
    <a href="../Admin/AdminLogin.aspx">
        <img src="Images/swap.png" alt="Swap Logo">
    </a>
    <div class="admin-popup" id="adminPopup">Admin</div>
</div>



        <h2>N S Salon</h2>
        <div class="profile-image">
            <img src="Images/Logo.jpg" alt="Profile" />
        </div>
        <form id="loginForm" runat="server" onsubmit="return validateForm();">
            <div class="input-container">
                <asp:TextBox ID="txtEmail" runat="server" placeholder="Your Email" onkeyup="validateEmail(this)"></asp:TextBox>
            </div>
            <div id="emailError" class="field-validation"></div>

            <div class="input-container">
                <asp:TextBox ID="txtPassword" runat="server" placeholder="Your Password" TextMode="Password"></asp:TextBox>
                <img src="Images/hidden.png" class="eye-icon" id="togglePassword" onclick="togglePasswordVisibility()" />
            </div>
            <div id="passwordError" class="field-validation"></div>

            <asp:Button ID="btnLogin" runat="server" Text="LOGIN" CssClass="btn" OnClick="btnLogin_Click" />
            <asp:Label ID="lblMessage" runat="server" CssClass="error-message"></asp:Label>
        </form>
        <p>Not a member yet? <a href="Register.aspx">Join Now!</a></p>

        <!-- Social Media Icons -->
      <div class="social-icons">
    <a href="https://www.facebook.com/" target="_blank">
        <img src="Images/facebooklogo.png" alt="Facebook">
    </a>
    <a href="https://www.instagram.com/" target="_blank">
        <img src="Images/instalogo.png" alt="Instagram">
    </a>
    <a href="https://x.com/" target="_blank">
        <img src="Images/twitternewlogo.png" alt="Twitter">
    </a>
    <a href="https://www.google.com/" target="_blank">
        <img src="Images/googlelogo.png" alt="Google">
    </a>
</div>

    </div>

    <script>
        function togglePasswordVisibility() {
            var passwordField = document.getElementById('<%= txtPassword.ClientID %>');
            var toggleIcon = document.getElementById('togglePassword');

            if (passwordField.type === "password") {
                passwordField.type = "text";
                toggleIcon.src = "Images/view.png";
            } else {
                passwordField.type = "password";
                toggleIcon.src = "Images/hidden.png";
            }
        }

        function validateEmail(input) {
            var email = input.value.trim();
            var errorDiv = document.getElementById('emailError');
            var emailRegex = /^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$/;

            if (email === '') {
                errorDiv.innerHTML = 'Email is required';
                return false;
            } else if (email !== email.toLowerCase()) {
                errorDiv.innerHTML = 'Email must be in lowercase';
                return false;
            } else if (!emailRegex.test(email)) {
                errorDiv.innerHTML = 'Please enter a valid email address';
                return false;
            } else {
                errorDiv.innerHTML = '';
                return true;
            }
        }

        function validateForm() {
            var email = document.getElementById('<%= txtEmail.ClientID %>').value.trim();
            var password = document.getElementById('<%= txtPassword.ClientID %>').value.trim();
            var isValid = true;

            if (!validateEmail(document.getElementById('<%= txtEmail.ClientID %>'))) {
                isValid = false;
            }

            if (password.length < 8) {
                document.getElementById('passwordError').innerHTML = 'Password must be at least 8 characters long';
                isValid = false;
            } else {
                document.getElementById('passwordError').innerHTML = '';
            }

            return isValid;
        }
        function showPopup() {
            document.getElementById('adminPopup').style.display = 'block';
        }

        function hidePopup() {
            document.getElementById('adminPopup').style.display = 'none';
        }
    </script>
</body>
</html>
