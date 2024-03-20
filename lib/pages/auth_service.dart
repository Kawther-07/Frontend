import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<void> signInUser(BuildContext context, TextEditingController emailController, TextEditingController passwordController) async {
    final Uri loginUri = Uri.parse('http://192.168.1.66:3000/api/patient/login');
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

        // Make another request to fetch profile information
        final Uri profileUri = Uri.parse('http://192.168.1.66:3000/api/patient/profile');
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
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          // Handle profile request failure
        }
      } else {
        // Handle login failure
      }
    } catch (e) {
      // Handle exceptions
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

      final Uri logoutUri = Uri.parse('http://192.168.1.66:3000/api/patient/logout');

      final http.Response response = await http.post(
        logoutUri,
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print("Logout successful.");
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      } else {
        print("Logout failed.");
      }
    } catch (e) {
      // Handle exceptions
      print('Error during logout: $e');
    }
  }
}
