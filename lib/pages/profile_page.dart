import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String first_name = '';
  String last_name = '';
  String email = '';
  String phone = '';
  String diabetesType = '';
  bool isSmoker = false;
  bool hasDFU = false;
  int diab_duration = 0;
  double glycemia = 0.0;
  int age = 0;
  String gender = '';
  double height = 0.0;
  double weight = 0.0;

  TextEditingController patientIdController = TextEditingController();

  Future<void> fetchProfileData(int patientId) async {
    final url = Uri.parse('http://192.168.1.69:3000/api/patient/profile?patientId=$patientId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final profileData = jsonDecode(response.body);
      
      // Extract patient information
      setState(() {
        first_name = profileData['first_name'];
        last_name = profileData['last_name'];
        email = profileData['email'];
        phone = profileData['phone'];
      });

      // Extract medical record information
      setState(() {
        diabetesType = profileData['medicalRecord']['diabetesType'];
        isSmoker = profileData['medicalRecord']['isSmoker'];
        hasDFU = profileData['medicalRecord']['hasDFU'];
        diab_duration = profileData['medicalRecord']['diab_duration'];
        glycemia = profileData['medicalRecord']['glycemia'];
        age = profileData['medicalRecord']['age'];
        gender = profileData['medicalRecord']['gender'];
        height = profileData['medicalRecord']['height'];
        weight = profileData['medicalRecord']['weight'];
      });
    } else {
      throw Exception('Failed to load profile data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: patientIdController,
              decoration: InputDecoration(labelText: 'Enter Patient ID'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                int patientId = int.tryParse(patientIdController.text) ?? 0;
                if (patientId != 0) {
                  fetchProfileData(patientId);
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Invalid Patient ID'),
                        content: Text('Please enter a valid patient ID.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Fetch Profile'),
            ),
            SizedBox(height: 16.0),
            Text('First Name: $first_name'),
            Text('Last Name: $last_name'),
            Text('Email: $email'),
            Text('Phone Number: $phone'),
            Text('Diabetes Type: $diabetesType'),
            Text('Is Smoker: ${isSmoker ? 'Yes' : 'No'}'),
            Text('Has DFU: ${hasDFU ? 'Yes' : 'No'}'),
            Text('Diabetes Duration: $diab_duration years'),
            Text('Glycemia: $glycemia'),
            Text('Age: $age'),
            Text('Gender: $gender'),
            Text('Height: $height'),
            Text('Weight: $weight'),
          ],
        ),
      ),
    );
  }
}
