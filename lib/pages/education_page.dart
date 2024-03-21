import 'package:flutter/material.dart';

class EducationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Education',
        style: TextStyle(color: Colors.white), // Set the text color of the app bar title here
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFA67CE4), // First color
              Color(0xFF5915BD), // Second color
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.white, // Set the color of the back arrow here
      ),
    ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          EducationalCard(
            title: 'What is Diabetic Foot Ulcer?',
            description: 'Learn about the causes, symptoms, and treatments for DFU.',
            imageUrl: 'assets/dfu1.png', // Replace with actual image asset path
            onTap: () {
              // Handle tap action for this card
            },
          ),
          SizedBox(height: 16.0),
          EducationalCard(
            title: 'Preventing Diabetic Foot Ulcer',
            description: 'Discover tips and strategies to prevent DFU and maintain foot health.',
            imageUrl: 'assets/ulcer1.jpg', // Replace with actual image asset path
            onTap: () {
              // Handle tap action for this card
            },
          ),
          SizedBox(height: 16.0),
          EducationalCard(
            title: 'Diabetic foot ulcer and self-care plans',
            description: 'Discover tips and strategies to prevent DFU and maintain foot health.',
            imageUrl: 'assets/dfu3.png', // Replace with actual image asset path
            onTap: () {
              // Handle tap action for this card
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
    return Card(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                  height: 195.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white, // Text color
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      description,
                      style: TextStyle(fontSize: 16.0, color: Colors.white), // Text color
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
