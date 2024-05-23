import 'package:flutter/material.dart';
import 'package:DoolabMobile/pages/education_page.dart';
import 'package:DoolabMobile/pages/splash_screen.dart';
import 'package:DoolabMobile/pages/welcome_page.dart';
import 'package:DoolabMobile/pages/login_page.dart';
import 'package:DoolabMobile/pages/register_page.dart';
import 'package:DoolabMobile/pages/stats.dart';
import 'package:DoolabMobile/pages/home_page.dart';
import 'package:DoolabMobile/pages/patient_profile_page.dart';

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