import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/newEducationPage.dart';
import 'package:flutter_application_1/pages/welcome_page.dart';

class NewWelcomePage extends StatelessWidget {
  const NewWelcomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60),
            Text(
              'Welcome to',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Image.asset(
              'assets/Logo.png', 
              width: 180,
              height: 100,
            ),
            SizedBox(height: 10.0),
            // Text(
            //   'Learn about Diabetic Foot Ulcer (DFU).',
            //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            // ),
            SizedBox(height: 14.0),
            EducationalCard(
              title: 'What is Diabetic Foot Ulcer?',
              description: 'Learn about the causes, symptoms, and treatments for DFU.',
              imageUrl: 'assets/dfu1.png',
              onTap: () {},
            ),
            SizedBox(height: 14.0),
            EducationalCard(
              title: 'Preventing Diabetic Foot Ulcer',
              description: 'Discover tips and strategies to prevent DFU and maintain foot health.',
              imageUrl: 'assets/ulcer1.jpg',
              onTap: () {},
            ),
            SizedBox(height: 14.0),
            EducationalCard(
              title: 'Diabetic foot ulcer and self-care plans',
              description: 'Discover tips and strategies to prevent DFU and maintain foot health.',
              imageUrl: 'assets/dfu3.png',
              onTap: () {},
            ),
            SizedBox(height: 30),
            GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => WelcomePage(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(horizontal: 45),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFA67CE4), 
                          Color(0xFF5915BD), 
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'GET STARTED',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}
