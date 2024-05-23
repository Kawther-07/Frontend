import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:DoolabMobile/pages/components/my_button.dart';
import 'package:DoolabMobile/pages/components/my_texfield.dart';
import 'package:DoolabMobile/pages/home_page.dart';
import 'package:http/http.dart' as http;
import 'register_page.dart';
import 'stats.dart';
import 'forgot_password.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class LoginPage extends StatelessWidget {
//   LoginPage({Key? key}) : super(key: key);

//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   final storage = FlutterSecureStorage();


// Future<void> signInUser(BuildContext context) async {
//   final storage = FlutterSecureStorage();

//   try {
//     final String email = emailController.text;
//     final String password = passwordController.text;

//     if (email.isEmpty || password.isEmpty) {
//       throw 'Please fill in both email and password fields.';
//     }

//     final Uri uri = Uri.parse('http://192.168.1.29:8000/api/patient/login');
//     final http.Response response = await http.post(
//       uri,
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         'email': email,
//         'password': password,
//       }),
//     );

//     print('Response status code: ${response.statusCode}');
//     print('Response body: ${response.body}');

//     if (response.statusCode == 200) {
//       final responseData = jsonDecode(response.body);
//       final token = responseData['token'];

//       // Store the token 
//       await storage.write(key: 'token', value: token);

//       final decodedToken = jsonDecode(utf8.decode(base64.decode(base64.normalize(token.split('.')[1]))));
      
//       // Extract the patientId from the decoded token
//       final patientId = decodedToken['id'];
//       print('Patient idddd: $patientId');

//       // Navigate to the welcome page with patientId
//       Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (context) => HomePage(patientId: patientId),
//         ),
//       );
//     } else {
//       print('Login failed: ${response.statusCode} - ${response.body}');
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Error'),
//             content: Text('Email or password are incorrect.'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   } catch (error) {
//     print('Error during login: $error');
//     String errorMessage = 'An error occurred.';

//     if (error.toString().contains('Please fill in both email and password fields.')) {
//       errorMessage = 'Please fill in both email and password fields.';
//     }

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Error'),
//           content: Text(errorMessage),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }


//   // navigate to register page
//   void navigateToRegisterPage(BuildContext context) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => RegisterPage(), 
//       ),
//     );
//   }

//   // navigate to forgot password page 
//   void navigateToForgotPasswordPage(BuildContext context) {
//   Navigator.of(context).push(
//     MaterialPageRoute(
//       builder: (context) => ForgotPassword(),
//     ),
//   );
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 0),

//                 // Logo
//                 Padding(
//                   padding: const EdgeInsets.only(top: 0),
//                   child: Image.asset(
//                     'assets/Logo.png',
//                     width: 230,
//                     height: 230,
//                   ),
//                 ),

//                 const SizedBox(height: 5),

//                 // Welcome back!
//                 const Text(
//                   'Welcome back!',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 22,
//                   ),
//                 ),

//                 const SizedBox(height: 15),

//                 // Please enter your details to sign in.
//                 Text(
//                   'Please enter your details to sign in.',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w500,
//                     fontSize: 14,
//                     color: Colors.grey.shade900,
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 // Email field
//                 MyTextField(
//                   controller: emailController,
//                   hintText: 'Email address',
//                   obscureText: false,
//                   icon: Icons.email,
//                 ),

//                 const SizedBox(height: 10),

//                 // Password field
//                 MyTextField(
//                   controller: passwordController,
//                   hintText: 'Password',
//                   obscureText: true,
//                   icon: Icons.lock,
//                 ),

//                 const SizedBox(height: 10),

//                 // Forgot password?
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25),
//                   child: GestureDetector(
//                     onTap: () => navigateToForgotPasswordPage(context),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Text(
//                           'Forgot password?',
//                           style: TextStyle(color: Colors.grey[600]),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 70),

//                 // Sign in button
//                 MyButton(
//                   text: "Log in",
//                   onTap: () => signInUser(context),
//                 ),

//                 const SizedBox(height: 15),

//                 // Don't have an account? Register now.
//                 GestureDetector(
//                   onTap: () => navigateToRegisterPage(context),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Don\'t have an account?',
//                         style: TextStyle(color: Colors.grey[700]),
//                       ),
//                       const SizedBox(width: 4),
//                       const Text(
//                         'Register now.',
//                         style: TextStyle(
//                           color: Color(0xFF218BBC),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final storage = FlutterSecureStorage();

  Future<void> signInUser(BuildContext context) async {
    try {
      final String email = emailController.text;
      final String password = passwordController.text;

      if (email.isEmpty || password.isEmpty) {
        throw 'Please fill in both email and password fields.';
      }

      final Uri uri = Uri.parse('http://192.168.1.29:8000/api/patient/login');
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
        final doctorId = responseData['doctorId'];

        // Store the token and doctorId
        await storage.write(key: 'token', value: token);
        await storage.write(key: 'doctorId', value: doctorId.toString());

        final decodedToken = jsonDecode(utf8.decode(base64.decode(base64.normalize(token.split('.')[1]))));

        // Extract the patientId from the decoded token
        final patientId = decodedToken['id'];
        print('Patient ID: $patientId');

        // Navigate to the home page with patientId
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HomePage(patientId: patientId, doctorId: doctorId,),
          ),
        );
      } else {
        print('Login failed: ${response.statusCode} - ${response.body}');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Email or password are incorrect.'),
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
      String errorMessage = 'An error occurred.';

      if (error.toString().contains('Please fill in both email and password fields.')) {
        errorMessage = 'Please fill in both email and password fields.';
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(errorMessage),
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

  // navigate to register page
  void navigateToRegisterPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RegisterPage(),
      ),
    );
  }

  // navigate to forgot password page
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
                const SizedBox(height: 0),

                // Logo
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Image.asset(
                    'assets/Logo.png',
                    width: 230,
                    height: 230,
                  ),
                ),

                const SizedBox(height: 5),

                // Welcome back!
                const Text(
                  'Welcome back!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),

                const SizedBox(height: 15),

                // Please enter your details to sign in.
                Text(
                  'Please enter your details to sign in.',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
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
