// import 'package:flutter/material.dart';

// class ProfilePage extends StatelessWidget {
//   final Map<String, dynamic> patientProfile;

//   ProfilePage(this.patientProfile);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Patient Profile'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Name: ${patientProfile['first_name']} ${patientProfile['last_name']}',
//               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             Text('Email: ${patientProfile['email']}'),
//             const SizedBox(height: 10),
//             Text('Phone: ${patientProfile['phone']}'),
//             // Add more profile information as needed
//           ],
//         ),
//       ),
//     );
//   }
// }
