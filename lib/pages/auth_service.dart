import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<void> registerUser(
    BuildContext context,
    TextEditingController fnameController,
    TextEditingController lnameController,
    TextEditingController phoneController,
    TextEditingController emailController,
    TextEditingController passwordController,
    String? selectedDoctorId,
  ) async {
    final Uri registerUri = Uri.parse('http://192.168.1.3:8000/api/patient/register');
    final Map<String, dynamic> userData = {
      'first_name': fnameController.text,
      'last_name': lnameController.text,
      'phone': phoneController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'selected_doctor': selectedDoctorId ?? '', // Ensure selectedDoctorId is not null
    };

    try {
      final http.Response registerResponse = await http.post(
        registerUri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userData),
      );

      if (registerResponse.statusCode == 200) {
        final responseData = jsonDecode(registerResponse.body);
        final token = responseData['token']; // Ensure 'token' key exists in responseData

        // Store token securely using flutter_secure_storage
        final storage = FlutterSecureStorage();
        await storage.write(key: 'token', value: token);

        // Store profile data (if needed) in SharedPreferences
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', emailController.text); // Store relevant profile data

        // Navigate to home page or other appropriate page after registration
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else {
        // Handle registration failure
        print('Registration failed: ${registerResponse.statusCode}');
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
      print('Error during registration: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to register user. Please try again later.'),
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
  }




  static Future<void> signInUser(BuildContext context, TextEditingController emailController, TextEditingController passwordController) async {
    final Uri loginUri = Uri.parse('http://192.168.1.3:8000/api/patient/login');
    final Map<String, dynamic> userData = {
      'email': emailController.text,
      'password': passwordController.text,
    };

    try {
      final http.Response loginResponse = await http.post(
        loginUri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userData),
      );

      if (loginResponse.statusCode == 200) {
        final responseData = jsonDecode(loginResponse.body);
        final token = responseData['token'];

        // Request to fetch profile information
        final Uri profileUri = Uri.parse('http://192.168.1.3:8000/api/patient/profile');
        final http.Response profileResponse = await http.get(
          profileUri,
          headers: <String, String>{
            'Authorization': 'Bearer $token',
          },
        );

        if (profileResponse.statusCode == 200) {
          final profileData = jsonDecode(profileResponse.body);
          final gender = profileData['gender'];
          final height = profileData['height'];
          final weight = profileData['weight'];
          final birth_date = profileData['birth_date'];

          // Display profile information
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Profile Information'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Gender: $gender'),
                    Text('Height: $height'),
                    Text('Weight: $weight'),
                    Text('Birth Date: $birth_date'),
                  ],
                ),
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
        } else {
        }
      } else {
      }
    // ignore: empty_catches
    } catch (e) {
    }
  }


  static Future<void> logout(BuildContext context) async {
    final storage = FlutterSecureStorage();

    try {
      // Retrieve token from storage
      final String? token = await storage.read(key: 'token');

      if (token == null) {
        print('Token is null. User may already be logged out.');
        return;
      }

      // Clear profile data from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('gender');
      prefs.remove('height');
      prefs.remove('weight');
      prefs.remove('birth_date');

      // Make logout request
      final Uri logoutUri = Uri.parse('http://192.168.1.3:8000/api/patient/logout');

      final http.Response response = await http.post(
        logoutUri,
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print("Logout successful.");
        Navigator.pushNamedAndRemoveUntil(context, '/welcome', (route) => false);
      } else {
        print("Logout failed.");
      }
    } catch (e) {
      print('Error during logout: $e');
    }
  }
}
