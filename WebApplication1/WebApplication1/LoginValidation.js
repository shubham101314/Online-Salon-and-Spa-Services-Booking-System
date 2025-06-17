document.addEventListener('DOMContentLoaded', function () {
    const loginButton = document.getElementById('<%= loginButton.ClientID %>');
    const usernameField = document.getElementById('<%= Username.ClientID %>');
    const passwordField = document.getElementById('<%= password.ClientID %>');
    const usernameError = document.getElementById('<%= usernameError.ClientID %>');
    const passwordError = document.getElementById('<%= passwordError.ClientID %>');

    loginButton.addEventListener('click', function (event) {
        let valid = true;

        usernameError.textContent = '';
        passwordError.textContent = '';

        if (!usernameField.value.trim()) {
            usernameError.textContent = 'Username is required';
            valid = false;
        }

        if (!passwordField.value.trim()) {
            passwordError.textContent = 'Password is required';
            valid = false;
        }

        if (!valid) {
            event.preventDefault();
        }
    });
});
