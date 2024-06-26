import 'package:flutter/material.dart';
import 'package:DoolabMobile/pages/components/my_button.dart';
import 'forgot_password.dart'; 
import 'resetPassword_page.dart';
import 'password_reset_manager.dart'; 

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
    for (int i = 0; i < 4; i++) {
      focusNodes[i].addListener(() {
        if (focusNodes[i].hasFocus && digitControllers[i].text.isNotEmpty) {
          if (i < 3) {
            FocusScope.of(context).requestFocus(focusNodes[i + 1]);
          }
        }
      });
    }
  }

  @override
  void dispose() {
    for (int i = 0; i < 4; i++) {
      digitControllers[i].dispose();
      focusNodes[i].dispose();
    }
    super.dispose();
  }

  void navigateToForgotPasswordPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ForgotPassword(),
      ),
    );
  }

  void verifyCode(BuildContext context) {
    // Concatenate the digits entered in the text fields to form the verification code
    String verificationCode = digitControllers.map((controller) => controller.text).join();

    // Retrieve the stored email from PasswordResetManager
    String? email = PasswordResetManager.userEmail;

    if (email != null && verificationCode.length == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResetPasswordPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid verification code or missing email')),
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
                  const SizedBox(height: 50),

                  // Logo
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Image.asset(
                      'assets/Logo2.png', 
                      width: 230,
                      height: 230,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Verification
                  const Text(
                    'Verification',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),

                  const SizedBox(height: 20),

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

                  const SizedBox(height: 30),

                  // Boxes 
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
                                borderSide: BorderSide(color: Colors.grey[400] ?? Colors.grey), 
                              ),
                              counterText: '',
                            ),
                            maxLength: 1,
                            onChanged: (value) {
                              if (value.isNotEmpty && index < 3) {
                                FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                              }
                            },
                            onTap: () {
                              digitControllers[index].clear();
                            },
                          ),
                        );
                      }),
                    ),
                  ),

                  const SizedBox(height: 60),

                  // Verify button
                  MyButton(
                    text: "Verify Now",
                    onTap: () => verifyCode(context),
                  ),

                  const SizedBox(height: 15),

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
                        const Text(
                          'Resend Code',
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
            Positioned(
              left: 10,
              top: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
