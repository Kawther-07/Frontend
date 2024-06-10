import 'package:flutter/material.dart';
import 'package:DoolabMobile/pages/education_page.dart';
import 'package:DoolabMobile/pages/splash_screen.dart';
import 'package:DoolabMobile/pages/welcome_page.dart';
import 'package:DoolabMobile/pages/login_page.dart';
import 'package:DoolabMobile/pages/register_page.dart';
import 'package:DoolabMobile/pages/stats.dart';
import 'package:DoolabMobile/pages/home_page.dart';
import 'package:DoolabMobile/pages/patient_profile_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  runApp(MyApp());
}

Future<void> initializeFirebase() async {
  try {
    print('Initializing Firebase...');
    await Firebase.initializeApp(options: const FirebaseOptions(
    apiKey: 'AIzaSyAheCuLE93A382_8PTCOHR5fcZKFSYq8gs',
    appId: '1:821505640316:android:4172739b8f7eaf413bc6f9',
    messagingSenderId: '821505640316',
    projectId: 'doolabmobile',
    storageBucket: 'doolabmobile.appspot.com',
  ));
    print('Firebase Initialized');
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
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
        '/home': (context) => HomePage(), 
        '/education': (context) => EducationPage(), 
        '/welcome': (context) => WelcomePage(),
      },
    );
  }
}