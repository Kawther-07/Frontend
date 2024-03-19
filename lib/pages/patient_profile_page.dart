import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/dfu_record_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PatientProfilePage extends StatefulWidget {
  final int patientId;
  int currentIndex; // New field to store the current selected index
  final Function(int) onItemTapped; // Callback function to handle item tap

  PatientProfilePage({Key? key, required this.patientId, required this.currentIndex, required this.onItemTapped}) : super(key: key);

  @override
  _PatientProfilePageState createState() => _PatientProfilePageState();
}

class _PatientProfilePageState extends State<PatientProfilePage> {

  Map<String, dynamic>? profileData;
  Map<String, dynamic>? medicalRecordData; // Add medical record data

  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    fetchProfileData();
    fetchMedicalRecordData(); // Call the method to fetch medical record data
  }

  Future<void> fetchProfileData() async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'token');

      final profileResponse = await http.get(
        Uri.parse('http://192.168.1.68:3000/api/patient/profile/${widget.patientId}'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (profileResponse.statusCode == 200) {
        final fetchedProfileData = jsonDecode(profileResponse.body);
        setState(() {
          profileData = fetchedProfileData['profile']; // Access profile data from the 'profile' key
        });
      } else {
        throw Exception('Failed to fetch patient profile: ${profileResponse.statusCode}');
      }
    } catch (error) {
      print('Error fetching profile data: $error');
    }
  }

  // Method to fetch medical record data
  Future<void> fetchMedicalRecordData() async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'token');

      final medicalRecordResponse = await http.get(
        Uri.parse('http://192.168.1.68:3000/api/medical-record/${widget.patientId}'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (medicalRecordResponse.statusCode == 200) {
        final fetchedMedicalRecordData = jsonDecode(medicalRecordResponse.body)['medical-record'];
        setState(() {
          medicalRecordData = fetchedMedicalRecordData;
        });
        print('Medical record response body: ${medicalRecordResponse.body}');

      } else {
        throw Exception('Failed to fetch medical record: ${medicalRecordResponse.statusCode}');
      }
    } catch (error) {
      print('Error fetching medical record data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                await fetchProfileData();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PersonalProfilePage(profileData: profileData),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
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
                    "Personal Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                await fetchMedicalRecordData();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MedicalRecordPage(medicalRecordData: medicalRecordData),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
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
                    "Medical Record",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DFURecordPage(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
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
                    "DFU Record",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Personal Profile Page
class PersonalProfilePage extends StatelessWidget {
  final Map<String, dynamic>? profileData;

  PersonalProfilePage({Key? key, required this.profileData}) : super(key: key);

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Personal Profile'),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (profileData != null) ...[
            Text(
              'Gender: ${profileData!['gender']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Height: ${profileData!['height']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Weight: ${profileData!['weight']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Birth Date: ${profileData!['birth_date']}',
              style: TextStyle(fontSize: 18),
            ),
          ] else ...[
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text(
              'Profile data is loading...',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ],
      ),
    ),
  );
}
}

// Medical Record Page
class MedicalRecordPage extends StatelessWidget {
  final Map<String, dynamic>? medicalRecordData;

  MedicalRecordPage({Key? key, required this.medicalRecordData}) : super(key: key);

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Medical Record'),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (medicalRecordData != null) ...[
            Text(
              'Diabetes Type: ${medicalRecordData!['diabetesType']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Has DFU: ${medicalRecordData!['hasDFU']}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
                    'Is Smoker: ${medicalRecordData!['isSmoker']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Diabetes Date: ${medicalRecordData!['hadDiabetes']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Blood group: ${medicalRecordData!['bloodGroup']}',
                    style: TextStyle(fontSize: 18),
                  ),
            
          ] else ...[
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text(
              'Medical record data is loading...',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ],
      ),
    ),
  );
}
}
