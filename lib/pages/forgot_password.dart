import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/components/my_button.dart';
import 'package:flutter_application_1/pages/components/my_texfield.dart';
import 'verification_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'password_reset_manager.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key? key}) : super(key: key);

  final emailController = TextEditingController();

  void navigateBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  Future<void> sendVerificationCode(BuildContext context) async {
    final String email = emailController.text;
    
    // Store the email in PasswordResetManager
    PasswordResetManager.userEmail = email;

    final Uri uri = Uri.parse('http://192.168.1.68:3000/api/forgot-password');
    final http.Response response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'email': email}),
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => VerificationPage(),
        ),
      );
    } else {
      print('Failed to send verification code: ${response.statusCode} - ${response.body}');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to send verification code. Please try again.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                // Logo
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Image.asset(
                    'assets/Logo2.png',
                    width: 230,
                    height: 230,
                  ),
                ),
                SizedBox(height: 15),
                // Forgot password?
                Text(
                  'Forgot password?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 30),
                // Please enter your email address to receive the verification code.
                Center(
                  child: Text(
                    'Please enter your email address to receive the verification code.',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.grey.shade900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 40),
                // Email field
                MyTextField(
                  controller: emailController,
                  hintText: 'Email address',
                  obscureText: false,
                  icon: Icons.email,
                ),
                SizedBox(height: 100),
                // Send button
                MyButton(
                  text: "Send",
                  onTap: () => sendVerificationCode(context),
                ),
              ],
            ),
          ),
          Positioned(
            left: 10,
            top: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => navigateBack(context),
            ),
          ),
        ],
      ),
    ),
  );
}
}