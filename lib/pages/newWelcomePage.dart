// import 'package:flutter/material.dart';
// import 'package:DoolabMobile/pages/welcome_page.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class NewWelcomePage extends StatefulWidget {
//   const NewWelcomePage({Key? key}) : super(key: key);

//   @override
//   _NewWelcomePageState createState() => _NewWelcomePageState();
// }

// class _NewWelcomePageState extends State<NewWelcomePage> {
//   List<Map<String, dynamic>> resources = [];

//   Future<void> fetchResources() async {
//     final url = 'http://192.168.1.29:8000/api/educational-resources'; // Replace with your backend API endpoint
//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       List<dynamic> jsonResponse = json.decode(response.body);
//       setState(() {
//         resources = jsonResponse.map((resource) {
//           return {
//             'title': resource['title'],
//             'description': resource['description'],
//             'imageUrl': 'assets/dfu${resource['id']}.png', // Replace with actual logic to get image URL or path
//           };
//         }).toList();
//       });
//     } else {
//       throw Exception('Failed to load resources');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchResources();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(height: 60),
//             Text(
//               'Welcome to',
//               style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
//             ),
//             Image.asset(
//               'assets/Logo.png',
//               width: 180,
//               height: 100,
//             ),
//             SizedBox(height: 10.0),
//             Column(
//               children: resources.map((resource) {
//                 return Column(
//                   children: [
//                     EducationalCard(
//                       title: resource['title'],
//                       description: resource['description'],
//                       imageUrl: resource['imageUrl'],
//                       onTap: () {
//                         // Handle onTap if needed
//                       },
//                     ),
//                     SizedBox(height: 14.0),
//                   ],
//                 );
//               }).toList(),
//             ),
//             SizedBox(height: 30),
//             GestureDetector(
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => WelcomePage(),
//                   ),
//                 );
//               },
//               child: Container(
//                 padding: const EdgeInsets.all(12),
//                 margin: const EdgeInsets.symmetric(horizontal: 45),
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     colors: [
//                       Color(0xFFA67CE4),
//                       Color(0xFF5915BD),
//                     ],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                   ),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: const Center(
//                   child: Text(
//                     'GET STARTED',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 15,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 18),
//           ],
//         ),
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
//     Key? key,
//     required this.title,
//     required this.description,
//     required this.imageUrl,
//     this.onTap,
//   }) : super(key: key);

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
//                               style: const TextStyle(
//                                 fontSize: 14.0,
//                                 color: Colors.white,
//                               ),
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
