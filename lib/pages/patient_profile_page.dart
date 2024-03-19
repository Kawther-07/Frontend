import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/components/CustomBottomNavigationBar.dart';
import 'package:flutter_application_1/pages/dfu_record_page.dart';
import 'package:flutter_application_1/pages/education_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PatientProfilePage extends StatefulWidget {
  final int patientId;
  int currentIndex; // New field to store the current selected index
  final Function(int) onItemTapped; // Callback function to handle item tap

  PatientProfilePage({
    Key? key, required this.patientId, 
    required this.currentIndex, 
    required this.onItemTapped
    }) : super(key: key);

  @override
  _PatientProfilePageState createState() => _PatientProfilePageState();
}

class _PatientProfilePageState extends State<PatientProfilePage> {

  Map<String, dynamic>? profileData;
  Map<String, dynamic>? medicalRecordData; // Add medical record data

  final storage = FlutterSecureStorage();

  late List<bool> _isTappedList;

  @override
  void initState() {
    super.initState();
    fetchProfileData();
    fetchMedicalRecordData(); 
     _isTappedList = List.filled(7, false);
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
        print('Profile Data: $profileData');
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

  void _handleItemTap(int index) {
  // Call the onItemTapped callback function to update selectedIndex in HomePage
  widget.onItemTapped(index);
  Navigator.pop(context); // Return to the previous screen
}

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('More'),
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.only(top: 50), // Adjust top padding as needed
      child: Center(
        child: Column(
          children: [
            buildButton(
              index: 0,
              icon: Icons.person,
              label: "Personal Profile",
              onTap: () async {
                await fetchProfileData();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PersonalProfilePage(profileData: profileData),
                  ),
                );
              },
            ),
            buildButton(
              index: 1,
              icon: Icons.local_hospital,
              label: "Medical Record",
              onTap: () async {
                await fetchMedicalRecordData();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MedicalRecordPage(medicalRecordData: medicalRecordData),
                  ),
                );
              },
            ),
            buildButton(
              index: 2,
              icon: Icons.description,
              label: "DFU Record",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DFURecordPage(),
                  ),
                );
              },
            ),
            buildButton(
              index: 3,
              icon: Icons.bar_chart,
              label: "Stats",
              onTap: () {
                // Handle tap for Stats button
                // Navigate to the Stats page
              },
            ),
            buildButton(
              index: 4,
              icon: Icons.school,
              label: "Education",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EducationPage(),
                  ),
                );
              },
            ),
            buildButton(
              index: 5,
              icon: Icons.settings,
              label: "Settings",
              onTap: () {
                // Handle tap for Settings button
                // Navigate to the Settings page
              },
            ),
            buildButton(
              index: 6,
              icon: Icons.question_mark,
              label: "About us",
              onTap: () {
                // Handle tap for Settings button
                // Navigate to the Settings page
              },
            ),
          ],
        ),
      ),
    ),
    bottomNavigationBar: CustomBottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: (index) => _handleItemTap(index),
    ),
  );
}



Widget buildButton({required int index, required IconData icon, required String label, required Function onTap}) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isTappedList[index] = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isTappedList[index] = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isTappedList[index] = false;
        });
      },
      onTap: onTap as void Function()?,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        decoration: BoxDecoration(
        border: _isTappedList[index]
            ? Border(
                top: BorderSide(color: Color(0xFFD3D3D3), width: 1.0),
                bottom: BorderSide(color: Color(0xFFD3D3D3), width: 1.0),
              )
            : null,
        borderRadius: BorderRadius.circular(0),
      ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Color(0xFF505050), // Icon color
              size: 24,
            ),
            SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                color: Color(0xFF5915BD), // Text color
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }





   @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Reset selectedIndex when returning from profile page
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (widget.currentIndex != 0) {
        widget.onItemTapped(0);
      }
    });
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
