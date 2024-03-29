import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewEducationPage extends StatelessWidget {
  const NewEducationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Education',
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFA67CE4),
                Color(0xFF5915BD),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          EducationalCard(
            title: 'What is Diabetic Foot Ulcer?',
            description: 'Learn about the causes, symptoms, and treatments for DFU.',
            imageUrl: 'assets/dfu1.png',
            onTap: () {
            },
          ),

          const SizedBox(height: 16.0),

          EducationalCard(
            title: 'Preventing Diabetic Foot Ulcer',
            description: 'Discover tips and strategies to prevent DFU and maintain foot health.',
            imageUrl: 'assets/ulcer1.jpg',
            onTap: () {
            },
          ),

          const SizedBox(height: 16.0),

          EducationalCard(
            title: 'Diabetic foot ulcer and self-care plans',
            description: 'Discover tips and strategies to prevent DFU and maintain foot health.',
            imageUrl: 'assets/dfu3.png',
            onTap: () {
            },
          ),
        ],
      ),
    );
  }
}

class EducationalCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final VoidCallback? onTap;

  const EducationalCard({super.key, 
    required this.title,
    required this.description,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 145.0,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF218BBC),
                  Color(0xFFA67CE4),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                  ),
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: 120.0, 
                    height: double.infinity, 
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 8.0),

                        Expanded(
                          // Allow scrolling for long descriptions
                          child: SingleChildScrollView( 
                            child: Text(
                              description,
                              style: const TextStyle(fontSize: 14.0, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
