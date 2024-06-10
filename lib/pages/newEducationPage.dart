import 'package:DoolabMobile/pages/newWelcomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// class NewEducationPage extends StatelessWidget {
//   const NewEducationPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'New Education',
//           style: TextStyle(color: Colors.white),
//         ),
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color(0xFFA67CE4),
//                 Color(0xFF5915BD),
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//         ),
//         iconTheme: const IconThemeData(
//           color: Colors.white,
//         ),
//       ),
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
//             imageUrl: 'assets/dfu2.png',
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

//   const EducationalCard({super.key, 
//     required this.title,
//     required this.description,
//     required this.imageUrl,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 145.0,
//       child: Card(
//         elevation: 4.0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//         child: InkWell(
//           onTap: onTap,
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8.0),
//               gradient: const LinearGradient(
//                 colors: [
//                   Color(0xFF218BBC),
//                   Color(0xFFA67CE4),
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(8.0),
//                     bottomLeft: Radius.circular(8.0),
//                   ),
//                   child: Image.asset(
//                     imageUrl,
//                     fit: BoxFit.cover,
//                     width: 120.0, 
//                     height: double.infinity, 
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           title,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16.0,
//                             color: Colors.white,
//                           ),
//                         ),

//                         const SizedBox(height: 8.0),

//                         Expanded(
//                           // Allow scrolling for long descriptions
//                           child: SingleChildScrollView( 
//                             child: Text(
//                               description,
//                               style: const TextStyle(fontSize: 14.0, color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }















import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NewEducationPage extends StatefulWidget {
  const NewEducationPage({Key? key}) : super(key: key);

  @override
  _NewEducationPageState createState() => _NewEducationPageState();
}

class _NewEducationPageState extends State<NewEducationPage> {
  List<Map<String, dynamic>> resources = [];

  Future<void> fetchResources() async {
    final url = 'http://192.168.1.3:8000/api/educational-resources'; // Replace with your backend API endpoint
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
            Column(
              children: resources.map((resource) {
                return Column(
                  children: [
                    EducationalCard(
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
                    SizedBox(height: 14.0),
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NewWelcomePage(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(horizontal: 25),
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

class EducationalCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final VoidCallback? onTap;

  const EducationalCard({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.onTap,
  }) : super(key: key);

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
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.white,
                              ),
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

// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class NewEducationPage extends StatefulWidget {
//   const NewEducationPage({super.key});

//   @override
//   _NewEducationPageState createState() => _NewEducationPageState();
// }

// class _NewEducationPageState extends State<NewEducationPage> {
//   List<Map<String, dynamic>> resources = [];

//   Future<void> fetchResources() async {
//   final url = 'http://192.168.1.3:8000/api/educational-resources';
//   final response = await http.get(Uri.parse(url));

//   if (response.statusCode == 200) {
//     List<dynamic> jsonResponse = json.decode(response.body);
//     setState(() {
//       resources = jsonResponse.map((resource) {
//         return {
//           'title': resource['title'],
//           'description': resource['description'],
//           'imageUrl': 'assets/dfu${resource['id']}.png', // Ensure correct path
//           'article': resource['article'],
//         };
//       }).toList();
//     });
//   } else {
//     throw Exception('Failed to load resources');
//   }
// }


//   @override
//   void initState() {
//     super.initState();
//     fetchResources();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // title: const Text(
//         //   'New Education',
//         //   style: TextStyle(color: Colors.white),
//         // ),
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color(0xFFA67CE4),
//                 Color(0xFF5915BD),
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//         ),
//         iconTheme: const IconThemeData(
//           color: Colors.white,
//         ),
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Adjust padding here
//         itemCount: resources.length,
//         itemBuilder: (context, index) {
//           var resource = resources[index];
//           return Container(
//             margin: EdgeInsets.only(bottom: 12.0), // Add space between cards
//             child: EducationalCard(
//               title: resource['title'],
//               description: resource['description'],
//               imageUrl: resource['imageUrl'],
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ArticlePage(
//                       title: resource['title'],
//                       article: resource['article'],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class EducationalCard extends StatelessWidget {
//   final String title;
//   final String description;
//   final String imageUrl;
//   final VoidCallback? onTap;

//   const EducationalCard({super.key, 
//     required this.title,
//     required this.description,
//     required this.imageUrl,
//     this.onTap,
//   });

//   @override
// Widget build(BuildContext context) {
//   return GestureDetector(
//     onTap: onTap,
//     child: Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12.0),
//       ),
//       elevation: 5.0,
//       child: Row( // Changed from Column to Row
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(12.0),
//             child: Image.asset(
//               imageUrl,
//               fit: BoxFit.cover,
//               height: double.infinity,
//               width: 120, // Set a fixed width for the image
//             ),
//           ),
//           Expanded( // Expanded to take remaining space for the text content
//             child: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: Theme.of(context).textTheme.headline6,
//                   ),
//                   SizedBox(height: 4.0),
//                   Text(
//                     description,
//                     style: Theme.of(context).textTheme.bodyText2,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

// }

// class ArticlePage extends StatelessWidget {
//   final String title;
//   final String article;

//   const ArticlePage({required this.title, required this.article});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           title,
//           style: TextStyle(color: Colors.white),
//         ),
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color(0xFFA67CE4),
//                 Color(0xFF5915BD),
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//         ),
//         iconTheme: const IconThemeData(
//           color: Colors.white,
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                   // color: Color(0xFFA67CE4), // Purple color
//                   fontSize: 24.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               Text(
//                 article,
//                 style: TextStyle(
//                   fontSize: 16.0,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
