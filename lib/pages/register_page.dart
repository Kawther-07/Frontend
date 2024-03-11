import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/components/my_texfield.dart'; 
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:http/http.dart' as http;
import 'login_page.dart';
import 'next_page2.dart'; 
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
    final Uri uri = Uri.parse('http://localhost:3000/api/patient');
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
                const SizedBox(height: 0),
                
                // logo
                Center(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF8D91FD),
                                  Color(0xFF595DE5),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.circle,
                            size: 50,
                            color: Colors.transparent,
                          ),
                        ],
                      ),

                      const SizedBox(height: 0), 

                      const Text(
                        'AppName',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF595DE5),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                MyTextField(
                  controller: fnameController,
                  hintText: 'First name',
                  obscureText: false,
                ),

                const SizedBox(height: 15),

                MyTextField(
                  controller: lnameController,
                  hintText: 'Last name',
                  obscureText: false,
                ),

                const SizedBox(height: 15),

                MyTextField(
                  controller: phoneController,
                  hintText: 'Phone number',
                  obscureText: false,
                ),

                const SizedBox(height: 15),

                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 15),

                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 50),

                GestureDetector(
                  onTap: () => registerUser(context),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF8D91FD),
                          Color(0xFF595DE5),
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

                const SizedBox(height: 15),

                GestureDetector(
                  onTap: () => navigateToSignInPage(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),

                      const SizedBox(width: 4),
                      
                      const Text(
                        'Sign in.',
                        style: TextStyle(
                          color: Colors.blue,
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
