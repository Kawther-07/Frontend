import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/education_page.dart';
import 'package:flutter_application_1/pages/splash_screen.dart';
import 'package:flutter_application_1/pages/welcome_page.dart';
import 'package:flutter_application_1/pages/login_page.dart';
import 'package:flutter_application_1/pages/register_page.dart';
import 'package:flutter_application_1/pages/stats.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/patient_profile_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Set the initial route
      routes: {
        '/': (context) => SplashScreen(), // Define the welcome page route
        '/login': (context) => LoginPage(), // Define the login page route
        '/register': (context) => RegisterPage(), // Define the register page route
        // '/stats': (context) => StatsPage(), // Define the stats page route
        '/home': (context) => HomePage(), // Define the home page route
        '/education': (context) => EducationPage(), // Define the home page route
        // '/profile': (context) => PatientProfilePage(), // Define the profile page route
        '/welcome': (context) => WelcomePage(),
      },
    );
  }
}
