import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/patient_profile_page.dart';
import 'package:flutter_application_1/pages/welcome_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/stats.dart';
import 'package:flutter_application_1/pages/stats.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/home_page.dart';
import 'pages/patient_profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}
