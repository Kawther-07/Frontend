import 'package:flutter/material.dart';
import 'package:DoolabMobile/pages/newEducationPage.dart';
import 'package:DoolabMobile/pages/welcome_page.dart';

class NewWelcomePage extends StatelessWidget {
  const NewWelcomePage({Key? key}) : super(key: key);

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
            SizedBox(height: 14.0),
            EducationalCard(
              title: 'What is Diabetic Foot Ulcer?',
              description: 'Learn about the causes, symptoms, and treatments for DFU.',
              imageUrl: 'assets/dfu1.png',
              content: 'Detailed content about What is Diabetic Foot Ulcer.',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DetailPage(
                    title: 'What is Diabetic Foot Ulcer?', 
                    content: 'Detailed content about What is Diabetic Foot Ulcer.',
                  )),
                );
              },
            ),
            SizedBox(height: 14.0),
            EducationalCard(
              title: 'Preventing Diabetic Foot Ulcer',
              description: 'Discover tips and strategies to prevent DFU and maintain foot health.',
              imageUrl: 'assets/dfu2.png',
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DetailPage(
                    title: 'Preventing Diabetic Foot Ulcer', 
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
                  )),
                );
              },
            ),
            SizedBox(height: 14.0),
            EducationalCard(
              title: 'Diabetic foot ulcer and self-care plans',
              description: 'Discover tips and strategies to prevent DFU and maintain foot health.',
              imageUrl: 'assets/dfu3.png',
              content: 'Detailed content about Diabetic foot ulcer and self-care plans.',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DetailPage(
                    title: 'Diabetic foot ulcer and self-care plans', 
                    content: 'Detailed content about Diabetic foot ulcer and self-care plans.',
                  )),
                );
              },
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

class EducationalCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String content;
  final VoidCallback? onTap;

  const EducationalCard({
    Key? key, 
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.content,
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

class DetailPage extends StatelessWidget {
  final String title;
  final String content;

  const DetailPage({Key? key, required this.title, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(content),
        ),
      ),
    );
  }
}










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
//     final url = 'http://192.168.131.120:8000/api/educational-resources'; // Replace with your backend API endpoint
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
