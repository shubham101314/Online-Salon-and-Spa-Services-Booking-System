<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="WebApplication1.Register" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Register - N S Saloon</title>
    <link rel="stylesheet" type="text/css" href="styles1.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap');

        body {
            background: url('Images/pixelcut-export.jpeg') no-repeat center center fixed;
            background-size: cover;
            font-family: 'Poppins', sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        .register-container {
            width: 350px;
            padding: 20px;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 8px;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            animation: fadeIn 0.8s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .profile-image img {
            width: 70px;
            height: 70px;
            border-radius: 50%;
        }

        .input-container {
            position: relative;
            width: 100%;
            text-align: left;
            margin-bottom: 8px;
        }

        input {
            width: 100%;
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 14px;
            transition: all 0.3s ease-in-out;
            background: #fff;
        }

        input:focus {
            border-color: #ffd800;
            box-shadow: 0 0 6px rgba(255, 59, 59, 0.4);
            outline: none;
        }

        .error-message {
            color: #ff0000;
            font-size: 11px;
            margin-top: 2px;
            display: none;
            padding-left: 3px;
        }

        .eye-icon {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            width: 18px;
        }

        .btn {
            width: 100%;
            padding: 10px;
            margin-top: 12px;
            border-radius: 5px;
            border: none;
            background: #000;
            color: white;
            font-size: 15px;
            cursor: pointer;
            transition: all 0.3s ease-in-out;
        }

        .btn:hover {
            background: #313131
            transform: scale(1.03);
            box-shadow: 0 3px 8px rgba(255, 59, 59, 0.3);
        }
        p {
            color:#000;
        }
        a {
            color:#FF4500;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <h3>Register</h3>
        <div class="profile-image">
            <img src="Images/Logo.jpg" alt="Profile" />
        </div>
        <form id="registerForm" runat="server">
            <!-- Name Field -->
            <div class="input-container">
                <asp:TextBox ID="txtName" runat="server" placeholder="Full Name" onkeyup="validateName()"></asp:TextBox>
                <span id="nameError" class="error-message">Name is required.</span>
            </div>

            <!-- Email Field -->
            <div class="input-container">
                <asp:TextBox ID="txtEmail" runat="server" placeholder="Email" onkeyup="validateEmail()" oninput="convertToLowercase()"></asp:TextBox>
                <span id="emailError" class="error-message">Enter a valid email.</span>
            </div>

            <!-- Password Field -->
            <div class="input-container">
                <asp:TextBox ID="txtPassword" runat="server" placeholder="Password" TextMode="Password" onkeyup="validatePassword()"></asp:TextBox>
                <img src="Images/hidden.png" class="eye-icon" id="togglePassword" onclick="toggleVisibility('txtPassword', 'togglePassword')" />
                <span id="passwordError" class="error-message">Must be 8+ chars, contain uppercase, lowercase, number & symbol.</span>
            </div>

            <!-- Confirm Password Field -->
            <div class="input-container">
                <asp:TextBox ID="txtConfirmPassword" runat="server" placeholder="Confirm Password" TextMode="Password" onkeyup="validateConfirmPassword()"></asp:TextBox>
                <img src="Images/hidden.png" class="eye-icon" id="toggleConfirmPassword" onclick="toggleVisibility('txtConfirmPassword', 'toggleConfirmPassword')" />
                <span id="confirmPasswordError" class="error-message">Passwords do not match.</span>
            </div>

            <asp:Button ID="btnRegister" runat="server" Text="REGISTER" CssClass="btn" OnClientClick="return validateForm();" OnClick="btnRegister_Click" />
        </form>
        <p>Already a member? <a href="login.aspx">Login here!</a></p>
    </div>

    <script>
        function toggleVisibility(inputId, iconId) {
            var inputField = document.getElementById(inputId);
            var icon = document.getElementById(iconId);

            if (inputField.type === "password") {
                inputField.type = "text";
                icon.src = "Images/view.png";
            } else {
                inputField.type = "password";
                icon.src = "Images/hidden.png";
            }
        }

        function convertToLowercase() {
            var emailField = document.getElementById("txtEmail");
            emailField.value = emailField.value.toLowerCase();
        }

        function validateName() {
            var name = document.getElementById("txtName").value.trim();
            document.getElementById("nameError").style.display = name === "" ? "block" : "none";
        }

        function validateEmail() {
            var email = document.getElementById("txtEmail").value.trim();
            var emailPattern = /^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$/;
            document.getElementById("emailError").style.display = !emailPattern.test(email) ? "block" : "none";
        }

        function validatePassword() {
            var password = document.getElementById("txtPassword").value.trim();
            var pattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
            document.getElementById("passwordError").style.display = !pattern.test(password) ? "block" : "none";
        }

        function validateConfirmPassword() {
            var password = document.getElementById("txtPassword").value.trim();
            var confirmPassword = document.getElementById("txtConfirmPassword").value.trim();
            document.getElementById("confirmPasswordError").style.display = password !== confirmPassword ? "block" : "none";
        }

        function validateForm() {
            validateName();
            validateEmail();
            validatePassword();
            validateConfirmPassword();

            return document.querySelectorAll('.error-message[style*="display: block"]').length === 0;
        }
    </script>
</body>
</html>
