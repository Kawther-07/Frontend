import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/newEducationPage.dart';
import 'package:flutter_application_1/pages/welcome_page.dart';

class NewWelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome',
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFFA67CE4),
                Color(0xFF5915BD),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => WelcomePage()),
  );
},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Colors.grey; // Disabled color
                  }
                  return Colors.white; // Default color
                }),
              ),
              child: Text('Get Started'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              'Welcome to',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Image.asset(
              'assets/Logo.png', // Replace 'your_logo.png' with the path to your logo image
              width: 180,
                    height: 120,// Adjust the height as needed
            ),
            // SizedBox(height: 20),
            EducationalCard(
              title: 'What is Diabetic Foot Ulcer?',
              description: 'Learn about the causes, symptoms, and treatments for DFU.',
              imageUrl: 'assets/dfu1.png',
              onTap: () {
                // Add onTap functionality if needed
              },
            ),
            SizedBox(height: 16.0),
            EducationalCard(
              title: 'Preventing Diabetic Foot Ulcer',
              description: 'Discover tips and strategies to prevent DFU and maintain foot health.',
              imageUrl: 'assets/ulcer1.jpg',
              onTap: () {
                // Add onTap functionality if needed
              },
            ),
            SizedBox(height: 16.0),
            EducationalCard(
              title: 'Diabetic foot ulcer and self-care plans',
              description: 'Discover tips and strategies to prevent DFU and maintain foot health.',
              imageUrl: 'assets/dfu3.png',
              onTap: () {
                // Add onTap functionality if needed
              },
            ),
          ],
        ),
      ),
    );
  }
}
