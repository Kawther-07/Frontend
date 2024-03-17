import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home_page.dart';
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
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    fetchProfileData();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: profileData != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
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
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: widget.currentIndex == 0 ? Color(0xFF5915BD) : Color(0xFF505050)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart, color: widget.currentIndex == 1 ? Color(0xFF5915BD) : Color(0xFF505050)),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school, color: widget.currentIndex == 2 ? Color(0xFF5915BD) : Color(0xFF505050)),
            label: 'Education',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: widget.currentIndex == 3 ? Color(0xFF5915BD) : Color(0xFF505050)),
            label: 'Profile',
          ),
        ],
        currentIndex: widget.currentIndex,
        selectedItemColor: Color(0xFF5915BD),
        unselectedItemColor: Color(0xFF505050),
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
  if (index != widget.currentIndex) {
    setState(() {
      widget.currentIndex = index;
    });

    switch (index) {
      case 0:
        // Navigate to the home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(patientId: widget.patientId),
          ),
        );
        break;
      case 1:
        // Handle navigation to Stats page
        break;
      case 2:
        // Handle navigation to Education page
        break;
      case 3:
        // Check if patientId is available
        if (widget.patientId != null) {
          // Navigate to the profile page passing patientId and the current selected index
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PatientProfilePage(
                patientId: widget.patientId!,
                currentIndex: index,
                onItemTapped: widget.onItemTapped,
              ),
            ),
          );
        } else {
          // Patient ID is null
          print('Patient ID is null');
        }
        break;
    }
  }
}
}