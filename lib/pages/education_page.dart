// import 'package:flutter/material.dart';

// class EducationPage extends StatelessWidget {
//   const EducationPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Education',
//         style: TextStyle(color: Colors.white),
//       ),
//       flexibleSpace: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFFA67CE4), 
//               Color(0xFF5915BD), 
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//       ),
//       iconTheme: const IconThemeData(
//         color: Colors.white, 
//       ),
//     ),
//       body: ListView(
//         padding: const EdgeInsets.all(16.0),
//         children: [
//           EducationalCard(
//             title: 'What is Diabetic Foot Ulcer?',
//             description: 'Learn about the causes, symptoms, and treatments for DFU.',
//             imageUrl: 'assets/dfu1.png', 
//             onTap: () {
              
//             },
//           ),
//           const SizedBox(height: 16.0),
//           EducationalCard(
//             title: 'Preventing Diabetic Foot Ulcer',
//             description: 'Discover tips and strategies to prevent DFU and maintain foot health.',
//             imageUrl: 'assets/ulcer1.jpg',
//             onTap: () {
              
//             },
//           ),
//           const SizedBox(height: 16.0),
//           EducationalCard(
//             title: 'Diabetic foot ulcer and self-care plans',
//             description: 'Discover tips and strategies to prevent DFU and maintain foot health.',
//             imageUrl: 'assets/dfu3.png', 
//             onTap: () {
              
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class EducationalCard extends StatelessWidget {
//   final String title;
//   final String description;
//   final String imageUrl;
//   final VoidCallback? onTap;

//   const EducationalCard({
//     required this.title,
//     required this.description,
//     required this.imageUrl,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4.0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: InkWell(
//         onTap: onTap,
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8.0),
//             gradient: LinearGradient(
//               colors: [
//                 Color(0xFF218BBC),
//                 Color(0xFFA67CE4),
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
//                 child: Image.asset(
//                   imageUrl,
//                   fit: BoxFit.fitWidth,
//                   width: double.infinity,
//                   height: 195.0,
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18.0,
//                         color: Colors.white, 
//                       ),
//                     ),
//                     SizedBox(height: 8.0),
//                     Text(
//                       description,
//                       style: TextStyle(fontSize: 16.0, color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EducationPage extends StatefulWidget {
  const EducationPage({super.key});

  @override
  _EducationPageState createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  List<Map<String, dynamic>> resources = [];

  Future<void> fetchResources() async {
    final url = 'http://192.168.1.29:8000/api/educational-resources'; // Replace with your backend API endpoint
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      setState(() {
        resources = jsonResponse.map((resource) {
          return {
            'title': resource['title'],
            'description': resource['description'],
            'imageUrl': 'assets/dfu${resource['id']}.png', // Replace with actual logic to get image URL or path
            'article': resource['article'],
          };
        }).toList();
      });
    } else {
      throw Exception('Failed to load resources');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchResources();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Education',
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
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Adjust padding here
        itemCount: resources.length,
        itemBuilder: (context, index) {
          var resource = resources[index];
          return Container(
            margin: EdgeInsets.only(bottom: 12.0), // Add space between cards
            child: EducationalCard(
              title: resource['title'],
              description: resource['description'],
              imageUrl: resource['imageUrl'],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArticlePage(
                      title: resource['title'],
                      article: resource['article'],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class EducationalCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final VoidCallback onTap;

  const EducationalCard({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
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
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
              child: Image.asset(imageUrl, fit: BoxFit.cover, height: 140, width: double.infinity), // Adjust height here
            ),
            Padding(
              padding: const EdgeInsets.all(12.0), // Adjust padding inside card content
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArticlePage extends StatelessWidget {
  final String title;
  final String article;

  const ArticlePage({required this.title, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  // color: Color(0xFFA67CE4), // Purple color
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                article,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


