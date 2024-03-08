import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/components/my_button.dart';
import 'package:flutter_application_1/pages/components/my_texfield.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn() {}

   // navigate to register page method
  void navigateToRegisterPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RegisterPage(), // Replace `RegisterPage` with your register page class name
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
            
                // logo
                Center(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF8D91FD), // First color
                                  Color(0xFF595DE5), // Second color
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.circle,
                            size: 100,
                            color: Colors.transparent,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10), 
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
            
                // please enter your details to sign in.
                Text(
                  'Please enter your details to sign in.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.grey.shade900,
                  ),
                ),
            
                const SizedBox(height: 20),
            
                // email field
                MyTextField(
                  controller: emailController,
                  hintText: 'Email address',
                  obscureText: false,
                  icon: Icons.email,
                ),
            
                const SizedBox(height: 10),
            
                // password field
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  icon: Icons.lock,
                ),
            
                const SizedBox(height: 10),
            
                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
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
            
                const SizedBox(height: 70),
            
                // sign in button
                MyButton(
                  text: "Log in",
                  onTap: signUserIn,
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