// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class ProfileInfoPage extends StatelessWidget {
//   final int patientId;
//   final TextEditingController genderController = TextEditingController();
//   final TextEditingController heightController = TextEditingController();
//   final TextEditingController weightController = TextEditingController();
//   final TextEditingController birthDateController = TextEditingController();

//   ProfileInfoPage({Key? key, required this.patientId}) : super(key: key);

//   Future<void> saveProfileInfo(BuildContext context) async {
//   final Map<String, dynamic> profileData = {
//     'patientId': patientId,
//     'gender': genderController.text,
//     'height': heightController.text,
//     'weight': weightController.text,
//     'birth_date': birthDateController.text,
//   };

//   final Uri uri = Uri.parse('http://192.168.1.68:8000/api/patient/profile');
//   try {
//     final http.Response response = await http.post(
//       uri,
//       body: jsonEncode(profileData),
//     );

//     if (response.statusCode == 200) {
//       // Profile info saved successfully
//       Navigator.pushNamedAndRemoveUntil(
//         context,
//         '/home?patient_id=$patientId', // Pass the patient ID as a query parameter
//         (route) => false,
//       );
//     } else {
//       // Display error message if data couldn't be saved
//       print('Failed to save profile information: ${response.statusCode}');
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('Error'),
//             content: const Text('Failed to save profile information.'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   } catch (error) {
//     // Handle any errors that occurred during the process
//     print('Error saving profile information: $error');
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Error'),
//           content: const Text('An unexpected error occurred.'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile Information'),
//         leading: IconButton(
//           icon: Icon(Icons.close),
//           onPressed: () {
//             Navigator.pop(context); // Go back to the previous page (RegisterPage)
//           },
//         ),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Text fields for entering profile information
//             TextField(
//               controller: genderController,
//               decoration: InputDecoration(
//                 hintText: 'Gender',
//               ),
//             ),
//             TextField(
//               controller: heightController,
//               decoration: InputDecoration(
//                 hintText: 'Height',
//               ),
//             ),
//             TextField(
//               controller: weightController,
//               decoration: InputDecoration(
//                 hintText: 'Weight',
//               ),
//             ),
//             TextField(
//               controller: birthDateController,
//               decoration: InputDecoration(
//                 hintText: 'Birth Date',
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 saveProfileInfo(context); // Call function to save profile info
//               },
//               child: Text('Submit'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
