import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/pages/welcome_page.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // get rid of the bottom and app bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Lottie.asset('assets/Flow4.json'),
        ),
      ),
      nextScreen: WelcomePage(),
      splashIconSize: 600,
    );
  }
}



// Scaffold(
//       body: Container (
//         width: double.infinity,
//         decoration: BoxDecoration (
//           gradient: LinearGradient(
//             colors: [Colors.blue, Colors.purple],
//             begin: Alignment.topRight,
//             end: Alignment.bottomLeft
//           ),
//         ),
//         child: Column (
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.edit,
//               size: 80,
//               color: Colors.white,
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Flutter Tips',
//               style: TextStyle(
//                 fontStyle: FontStyle.italic,
//                 color: Colors.white,
//                 fontSize: 32,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );