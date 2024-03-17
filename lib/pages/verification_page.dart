import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/components/my_button.dart';
import 'forgot_password.dart'; 
import 'resetPassword_page.dart';

class VerificationPage extends StatefulWidget {
  VerificationPage({Key? key}) : super(key: key);

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  List<TextEditingController> digitControllers = List.generate(4, (_) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    // Set up listeners for focus nodes
    for (int i = 0; i < 4; i++) {
      focusNodes[i].addListener(() {
        if (focusNodes[i].hasFocus && digitControllers[i].text.isNotEmpty) {
          // Move focus to the next box if the current box has text
          if (i < 3) {
            FocusScope.of(context).requestFocus(focusNodes[i + 1]);
          }
        }
      });
    }
  }

  @override
  void dispose() {
    // Dispose focus nodes and controllers
    for (int i = 0; i < 4; i++) {
      digitControllers[i].dispose();
      focusNodes[i].dispose();
    }
    super.dispose();
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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                // Logo (same as login page)
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

                // Verification
                Text(
                  'Verification',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),

                SizedBox(height: 20),

                // Please enter the 4-digit code sent to your email address.
                Center(
                  child: Text(
                    'Please enter the 4-digit code sent to your email address.',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.grey.shade900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: 50),

                // 4 Boxes to enter the 4 digits
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(4, (index) {
                      return SizedBox(
                        width: 50,
                        height: 50,
                        child: TextField(
                          controller: digitControllers[index],
                          focusNode: focusNodes[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.grey[400] ?? Colors.grey), // Use Colors.grey as default
                            ),
                            counterText: '', // Remove character count text
                          ),
                          maxLength: 1, // Limit input to one character
                          onChanged: (value) {
                            // Move focus to the next box when the user enters a digit
                            if (value.isNotEmpty && index < 3) {
                              FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                            }
                          },
                          onTap: () {
                            // Clear the box when tapped
                            digitControllers[index].clear();
                          },
                        ),
                      );
                    }),
                  ),
                ),

                SizedBox(height: 100),

                // Verify now button
                MyButton(
                  text: "Verify Now",
                  onTap: () {
                    // Navigate to the ResetPasswordPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ResetPasswordPage()),
                    );
                  },
                ),

                SizedBox(height: 15),

                // Didn't get any code? Resend Code
                GestureDetector(
                  onTap: () => navigateToForgotPasswordPage(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Didn\'t get any code? ',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      Text(
                        'Resend Code',
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
