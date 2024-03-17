import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/components/my_button.dart';
import 'package:flutter_application_1/pages/components/my_texfield.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:http/http.dart' as http;
import 'register_page.dart';
import 'stats.dart';
import 'forgot_password.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final storage = FlutterSecureStorage();

  // sign user in method
  Future<void> signInUser(BuildContext context) async {
    final storage = FlutterSecureStorage();

    try {
      final String email = emailController.text;
      final String password = passwordController.text;

      if (email.isEmpty || password.isEmpty) {
        throw 'Please fill in both email and password fields.';
      }

      final Uri uri = Uri.parse('http://192.168.1.68:3000/api/patient/login');
      final http.Response response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final token = responseData['token'];

        // Store the token securely
        await storage.write(key: 'token', value: token);

        final decodedToken = jsonDecode(utf8.decode(base64.decode(base64.normalize(token.split('.')[1]))));
        final patientId = decodedToken['id'];

        // Navigate to the welcome page with patientId
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HomePage(patientId: patientId),
          ),
        );
      } else {
        print('Login failed: ${response.statusCode} - ${response.body}');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to sign in user.'),
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
    } catch (error) {
      print('Error during login: $error');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred.'),
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

  // navigate to register page method
  void navigateToRegisterPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RegisterPage(), // Replace `RegisterPage` with your register page class name
      ),
    );
  }

  // navigate to forgot password page method
  void navigateToForgotPasswordPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ForgotPassword(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),

                // Logo
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Image.asset(
                    './lib/assets/Logo.png', // Replace 'assets/logo.png' with your logo image path
                    width: 50,
                    height: 50,
                  ),
                ),

                const SizedBox(height: 10),

                // App Name
                const Text(
                  'AppName',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5915BD),
                  ),
                ),

                const SizedBox(height: 50),

                // Welcome back!
                const Text(
                  'Welcome back!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),

                const SizedBox(height: 20),

                // Please enter your details to sign in.
                Text(
                  'Please enter your details to sign in.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.grey.shade900,
                  ),
                ),

                const SizedBox(height: 20),

                // Email field
                MyTextField(
                  controller: emailController,
                  hintText: 'Email address',
                  obscureText: false,
                  icon: Icons.email,
                ),

                const SizedBox(height: 10),

                // Password field
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  icon: Icons.lock,
                ),

                const SizedBox(height: 10),

                // Forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap: () => navigateToForgotPasswordPage(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot password?',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 70),

                // Sign in button
                MyButton(
                  text: "Log in",
                  onTap: () => signInUser(context),
                ),

                const SizedBox(height: 15),

                // Don't have an account? Register now.
                GestureDetector(
                  onTap: () => navigateToRegisterPage(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Register now.',
                        style: TextStyle(
                          color: Color(0xFF218BBC),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
