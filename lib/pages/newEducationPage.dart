import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_application_1/widgets/educational_card.dart'; // Import your EducationalCard widget

class NewEducationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Education',
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
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
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
    );
  }
}

class EducationalCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final VoidCallback? onTap;

  const EducationalCard({
    required this.title,
    required this.description,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 155.0, // Adjust the height as needed
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
              gradient: LinearGradient(
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
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                  ),
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: 120.0, // Adjust the width as needed
                    height: double.infinity, // Ensure the image fills the container height
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Expanded(
                          child: SingleChildScrollView( // Allow scrolling for long descriptions
                            child: Text(
                              description,
                              style: TextStyle(fontSize: 14.0, color: Colors.white),
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
