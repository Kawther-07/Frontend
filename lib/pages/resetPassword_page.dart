import 'package:flutter/material.dart';
import 'package:DoolabMobile/pages/components/my_button.dart';
import 'package:DoolabMobile/pages/components/my_texfield.dart';
import 'package:DoolabMobile/pages/home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'password_reset_manager.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({Key? key}) : super(key: key);

  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

Future<void> resetPassword(BuildContext context) async {
  final String newPassword = newPasswordController.text;
  final String? email = PasswordResetManager.userEmail;

  if (email != null) {
    final Uri uri = Uri.parse('http://192.168.1.3:8000/api/reset-password');
    final http.Response response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'email': email, 'newPassword': newPassword}),
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final dynamic responseBody = jsonDecode(response.body);

      if (responseBody != null && responseBody['success'] == true) {
        // Password reset successful
        print('Password reset successful');

        final int? patientId = responseBody['id'];
        if (patientId != null) {
          // Show a pop-up message indicating that the password is updated
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Success'),
                content: Text('Your password has been updated.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage(patientId: patientId)), // Pass patientId to HomePage
                      );
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          // Handle missing patientId
          print('Missing patientId in response');
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('Failed to retrieve patient ID after password reset.'),
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
      } else {
        // Password reset failed
        final String errorMessage = responseBody != null ? responseBody['message'] : 'Unknown error';
        print('Password reset failed: $errorMessage');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to reset password: $errorMessage'),
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
    } else {
      // Handle failure
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to reset password. Please try again.'),
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
  } else {
    // Handle case where email is missing
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Email is missing.'),
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
            child: Center(
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

                  const SizedBox(height: 0),

                  // Reset password
                  const Text(
                    'Reset Password',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Please enter your new password.
                  Text(
                    'Please enter your new password.',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.grey.shade900,
                    ),
                  ),

                  const SizedBox(height: 50),

                  // New Password
                  MyTextField(
                    controller: newPasswordController,
                    hintText: 'New Password',
                    obscureText: true,
                    icon: Icons.lock,
                  ),

                  const SizedBox(height: 10),

                  // Confirm Password
                  MyTextField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                    icon: Icons.lock,
                  ),

                  const SizedBox(height: 80),

                  // Reset button
                  MyButton(
                    text: "Reset Password",
                    onTap: () => resetPassword(context),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    ),
  );
}


}
