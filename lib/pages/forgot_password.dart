import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/components/my_button.dart';
import 'package:flutter_application_1/pages/components/my_texfield.dart';
import 'verification_page.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key? key}) : super(key: key);

  final emailController = TextEditingController();

  void navigateBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  Future<void> sendVerificationCode(BuildContext context) async {
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
                SizedBox(height: 0),

                // logo
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
        ),
      ),
    );
  }
}
