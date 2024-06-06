// // import 'package:flutter/material.dart';

// // class EducationPage extends StatelessWidget {
// //   const EducationPage({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text(
// //           'Education',
// //         style: TextStyle(color: Colors.white),
// //       ),
// //       flexibleSpace: Container(
// //         decoration: const BoxDecoration(
// //           gradient: LinearGradient(
// //             colors: [
// //               Color(0xFFA67CE4), 
// //               Color(0xFF5915BD), 
// //             ],
// //             begin: Alignment.topCenter,
// //             end: Alignment.bottomCenter,
// //           ),
// //         ),
// //       ),
// //       iconTheme: const IconThemeData(
// //         color: Colors.white, 
// //       ),
// //     ),
// //       body: ListView(
// //         padding: const EdgeInsets.all(16.0),
// //         children: [
// //           EducationalCard(
// //             title: 'What is Diabetic Foot Ulcer?',
// //             description: 'Learn about the causes, symptoms, and treatments for DFU.',
// //             imageUrl: 'assets/dfu1.png', 
// //             onTap: () {
              
// //             },
// //           ),
// //           const SizedBox(height: 16.0),
// //           EducationalCard(
// //             title: 'Preventing Diabetic Foot Ulcer',
// //             description: 'Discover tips and strategies to prevent DFU and maintain foot health.',
// //             imageUrl: 'assets/ulcer1.jpg',
// //             onTap: () {
              
// //             },
// //           ),
// //           const SizedBox(height: 16.0),
// //           EducationalCard(
// //             title: 'Diabetic foot ulcer and self-care plans',
// //             description: 'Discover tips and strategies to prevent DFU and maintain foot health.',
// //             imageUrl: 'assets/dfu3.png', 
// //             onTap: () {
              
// //             },
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class EducationalCard extends StatelessWidget {
// //   final String title;
// //   final String description;
// //   final String imageUrl;
// //   final VoidCallback? onTap;

// //   const EducationalCard({
// //     required this.title,
// //     required this.description,
// //     required this.imageUrl,
// //     this.onTap,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return Card(
// //       elevation: 4.0,
// //       shape: RoundedRectangleBorder(
// //         borderRadius: BorderRadius.circular(8.0),
// //       ),
// //       child: InkWell(
// //         onTap: onTap,
// //         child: Container(
// //           decoration: BoxDecoration(
// //             borderRadius: BorderRadius.circular(8.0),
// //             gradient: LinearGradient(
// //               colors: [
// //                 Color(0xFF218BBC),
// //                 Color(0xFFA67CE4),
// //               ],
// //               begin: Alignment.topCenter,
// //               end: Alignment.bottomCenter,
// //             ),
// //           ),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               ClipRRect(
// //                 borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
// //                 child: Image.asset(
// //                   imageUrl,
// //                   fit: BoxFit.fitWidth,
// //                   width: double.infinity,
// //                   height: 195.0,
// //                 ),
// //               ),
// //               Padding(
// //                 padding: EdgeInsets.all(16.0),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       title,
// //                       style: TextStyle(
// //                         fontWeight: FontWeight.bold,
// //                         fontSize: 18.0,
// //                         color: Colors.white, 
// //                       ),
// //                     ),
// //                     SizedBox(height: 8.0),
// //                     Text(
// //                       description,
// //                       style: TextStyle(fontSize: 16.0, color: Colors.white),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }


// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class EducationPage extends StatefulWidget {
//   const EducationPage({super.key});

//   @override
//   _EducationPageState createState() => _EducationPageState();
// }

// class _EducationPageState extends State<EducationPage> {
//   List<Map<String, dynamic>> resources = [];

// Future<void> fetchResources() async {
//   final url = 'http://192.168.1.9:8000/api/educational-resources';
//   final response = await http.get(Uri.parse(url));

//   if (response.statusCode == 200) {
//     List<dynamic> jsonResponse = json.decode(response.body);
//     setState(() {
//       resources = jsonResponse.map((resource) {
//         return {
//           'title': resource['title'],
//           'description': resource['description'],
//           'imageUrl': 'assets/dfu${resource['id']}.png', // Replace with actual logic to get image URL or path
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
//         title: const Text(
//           'Education',
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
//       body: ListView.builder(
//   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//   itemCount: resources.length,
//   itemBuilder: (context, index) {
//     var resource = resources[index];
//     return Container(
//       margin: EdgeInsets.only(bottom: 12.0),
//       child: EducationalCard(
//         title: resource['title'],
//         description: resource['description'],
//         imageUrl: resource['imageUrl'],
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ArticlePage(
//                 title: resource['title'],
//                 article: resource['article'],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   },
// ),
//     );
//   }
// }

// class EducationalCard extends StatelessWidget {
//   final String title;
//   final String description;
//   final String imageUrl;
//   final VoidCallback onTap;

//   const EducationalCard({
//     required this.title,
//     required this.description,
//     required this.imageUrl,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12.0),
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFF218BBC),
//               Color(0xFFA67CE4),
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
//               child: Image.asset(imageUrl, fit: BoxFit.cover, height: 140, width: double.infinity), // Adjust height here
//             ),
//             Padding(
//               padding: const EdgeInsets.all(12.0), // Adjust padding inside card content
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16.0,
//                     ),
//                   ),
//                   SizedBox(height: 4.0),
//                   Text(
//                     description,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 14.0,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
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



import 'package:flutter/material.dart';

class EducationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F1FF),
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
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          EducationalCard(
            title: 'What is Diabetic Foot Ulcer?',
            description: 'Learn about the causes, symptoms, and treatments for DFU.',
            imageUrl: 'assets/dfu1.png', // Replace with actual image asset path
            content: 'Detailed content about Diabetic Foot Ulcer goes here.',
          ),
          SizedBox(height: 16.0),
          EducationalCard(
            title: 'Preventing Diabetic Foot Ulcer',
            description: 'Discover tips and strategies to prevent DFU and maintain foot health.',
            imageUrl: 'assets/dfu3.png', // Replace with actual image asset path
            content: '''
To prevent DFUs, follow these tips:

1- Check your feet every day
  You may have foot problems, but feel no pain in your feet. Checking your feet each day will help you spot problems early before they get worse. Look for problems such as:
  - cuts, sores, or red spots.
  - swelling or fluid-filled blisters.
  - ingrown toenails, corns or calluses.

2- Wash your feet every day
  Wash your feet in warm water, and do not soak your feet. After washing and drying your feet, put powder between your toes to keep them dry and help prevent an infection.

3- Trim your toenails straight across
  Trim your toenails after you wash and dry your feet. Using toenail clippers, trim your toenails straight across. Do not cut into the corners of your toenail. Trimming this way helps prevent cutting your skin and keeps the nails from growing into your skin.

4- Wear shoes and socks at all times
  - Do not walk barefoot even when you are indoors. You could step on something and hurt your feet. You may not feel any pain and may not know that you hurt yourself.
  - Wear shoes that fit well and protect your feet.

5- Protect your feet from hot and cold
  If you have nerve damage from diabetes, you may burn your feet and not know you did. Here is how you can protect your feet from heat:
  - Wear shoes at the beach and on hot pavement.
  - Put sunscreen on the tops of your feet to prevent sunburn.
  - Keep your feet away from heaters and open fires.

6- Keep the blood flowing to your feet
  Try the following tips to improve blood flow to your feet:
  - Put your feet up when you are sitting.
  - Wiggle your toes for a few minutes throughout the day. Move your ankles up and down and in and out to help blood flow in your feet and legs.
  - Don't wear tight socks.
  - Be more physically active. Choose activities that are easy on your feet, such as walking, stretching, swimming, or bike riding.
  - Stop smoking.
''',
),
          SizedBox(height: 16.0),
          EducationalCard(
            title: 'Diabetic foot ulcer and self-care plans',
            description: 'Discover tips and strategies to prevent DFU and maintain foot health.',
            imageUrl: 'assets/dfu2.png', // Replace with actual image asset path
            content: 'Detailed content about self-care plans goes here.',
          ),
        ],
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String title;
  final String content;

  const DetailPage({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F1FF),
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
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
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              content,
              style: TextStyle(fontSize: 16.0),
            ),
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
  final String content;

  const EducationalCard({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailPage(
              title: title,
              content: content,
            )),
          );
        },
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
                  height: 145.0,
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
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      description,
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
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