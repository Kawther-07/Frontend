import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/components/my_button.dart';
import 'package:flutter_application_1/pages/components/my_texfield.dart';
import 'verification_page.dart'; // Import the VerificationPage

class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key? key}) : super(key: key);

  // text editing controllers
  final emailController = TextEditingController();

  // navigate back method
  void navigateBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  // send verification code method
  Future<void> sendVerificationCode(BuildContext context) async {
    // Navigate to VerificationPage
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VerificationPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => navigateBack(context),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                // logo (same as login page)
                Center(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
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
                          Icon(
                            Icons.circle,
                            size: 100,
                            color: Colors.transparent,
                          ),
                        ],
                      ),
                      SizedBox(height: 10), 
                      Text(
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
                SizedBox(height: 50),
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
                SizedBox(height: 70),
                // Email field
                MyTextField(
                  controller: emailController,
                  hintText: 'Email address',
                  obscureText: false,
                  icon: Icons.email,
                ),
                SizedBox(height: 140),
                // Send button
                MyButton(
                  text: "Send",
                  onTap: () => sendVerificationCode(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
