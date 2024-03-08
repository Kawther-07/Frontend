import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/components/my_button.dart';
import 'package:flutter_application_1/pages/components/my_texfield.dart';
import 'next_page1.dart';
import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  // text editing controllers
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final userTypeController = TextEditingController();

  // sidn user in method
  void signUserIn(BuildContext context) {
  // You can perform any necessary sign-in logic here
  
  // Navigate to the next page (replace `NextPage1` with the name of your next page class)
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => NextPage1(), // Replace `NextPage1` with your page class name
    ),
  );
}

// navigate to sign-in page method
  void navigateToSignInPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LoginPage(), // Replace `SignInPage` with your sign-in page class name
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
            
                const SizedBox(height: 40),
            
                // please enter your information to get started.
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Please enter your information\n',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.grey.shade900,
                          ),
                        ),
                        TextSpan(
                          text: 'to get started.',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.grey.shade900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            
                const SizedBox(height: 20),
            
                // first name field
                MyTextField(
                  controller: fnameController,
                  hintText: 'First name',
                  obscureText: false,
                ),
            
                const SizedBox(height: 10),
            
                // last name field
                MyTextField(
                  controller: lnameController,
                  hintText: 'Last name',
                  obscureText: false,
                ),
            
                const SizedBox(height: 10),

                // user type field
                MyTextField(
                  controller: userTypeController,
                  hintText: 'User type',
                  obscureText: false,
                ),

                const SizedBox(height: 10), 

                // phone numberuser type field
                MyTextField(
                  controller: userTypeController,
                  hintText: 'Phone number',
                  obscureText: false,
                ),
            
                const SizedBox(height: 50),
            
                // sign up button
                MyButton(
                  text: "Next",
                  onTap: () => signUserIn(context),
                ),
            
                const SizedBox(height: 15),
            
                // Already have an account? Sign in.
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