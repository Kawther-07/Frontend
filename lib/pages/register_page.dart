import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/components/my_texfield.dart'; 
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:http/http.dart' as http;
import 'login_page.dart';
import 'home_page.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key});

  // text editing controllers
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> registerUser(BuildContext context) async {
    final Uri uri = Uri.parse('http://192.168.1.69:3000/api/patient');
    final Map<String, dynamic> userData = {
      'first_name': fnameController.text,
      'last_name': lnameController.text,
      'phone': phoneController.text,
      'email': emailController.text,
      'password': passwordController.text,
    };

    try {
      final http.Response response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200) {
        // Registration successful, navigate to the next page
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HomePage(), // Navigate to NextPage2 after registration
          ),
        );
      } else {
        // Registration failed, display error message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Failed to register user.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // navigate to sign-in page method
  void navigateToSignInPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LoginPage(),
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
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Image.asset(
                    'assets/Logo.png', // Replace 'assets/logo.png' with your logo image path
                    width: 230,
                    height: 230,
                  ),
                ),
                Text(
                  'Please enter your information.',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.grey.shade900,
                  ),
                  textAlign: TextAlign.center,
                ),

SizedBox(height: 15),
                MyTextField(
                  controller: fnameController,
                  hintText: 'First name',
                  obscureText: false,
                ),

                SizedBox(height: 10),

                MyTextField(
                  controller: lnameController,
                  hintText: 'Last name',
                  obscureText: false,
                ),

                SizedBox(height: 10),

                MyTextField(
                  controller: phoneController,
                  hintText: 'Phone number',
                  obscureText: false,
                ),

                SizedBox(height: 10),

                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                SizedBox(height: 10),

                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                SizedBox(height: 30),

                GestureDetector(
                  onTap: () => registerUser(context),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFA67CE4), // First color
                          Color(0xFF5915BD), // Second color
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                GestureDetector(
                  onTap: () => navigateToSignInPage(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),

                      SizedBox(width: 4),
                      
                      Text(
                        'Sign in.',
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
