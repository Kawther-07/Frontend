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
      initialRoute: '/', 
      routes: {
        '/': (context) => SplashScreen(), 
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(), 
        // '/stats': (context) => StatsPage(),
        '/home': (context) => HomePage(), 
        '/education': (context) => EducationPage(), 
        // '/profile': (context) => PatientProfilePage(),
        '/welcome': (context) => WelcomePage(),
      },
    );
  }
}
