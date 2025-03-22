import 'package:flutter/material.dart';

class EmailInputWidget extends StatefulWidget {
  final TextEditingController controllerMail; // Stores the value.
  final TextEditingController controllerPassw;

  const EmailInputWidget(
      {super.key, required this.controllerMail, required this.controllerPassw});

  @override
  State<EmailInputWidget> createState() => _EmailInputWidgetState();
}

// Class for imput text fields for login and sign up (password and email)
class _EmailInputWidgetState extends State<EmailInputWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 300, // Same width as Figme model
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Email text field
            Text(
              'E-mail',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: widget.controllerMail,
              decoration: InputDecoration(
                hintText: 'Your email',
                hintStyle: TextStyle(color: Colors.grey[400]),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                      color: Colors.grey
                          .shade300), // Default color before being clicked.
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                      color: Color(0xFFFE724C)), // Orange border once clicked.
                ),
              ),
            ),
            SizedBox(height: 30),
            // Password text field
            Text(
              'Password',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 10),
            PasswordInputLogin(controller: widget.controllerPassw),
          ],
        ));
  }
}

// Class for password text field.
class PasswordInputLogin extends StatefulWidget {
  final TextEditingController controller;
  const PasswordInputLogin({super.key, required this.controller});

  @override
  PasswordInputLoginState createState() => PasswordInputLoginState();
}

// State class is used to show password or not.
class PasswordInputLoginState extends State<PasswordInputLogin> {
  bool _showText = true; // Boolean definin gwhether to show password or not.

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _showText,
      decoration: InputDecoration(
        hintText: 'Enter your password',
        suffixIcon: IconButton(
          icon: Icon(
            _showText
                ? Icons.visibility_off
                : Icons.visibility, // Eye icon change
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _showText =
                  !_showText; // Show text or not depending on button state.
            });
          },
        ),
        hintStyle: TextStyle(color: Colors.grey[400]),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
              color:
                  Colors.grey.shade300), // Default color before being clicked.
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
              color: Color(0xFFFE724C)), // Orange border once clicked.
        ),
      ),
    );
  }
}
