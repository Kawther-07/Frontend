import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/components/CustomBottomNavigationBar.dart';
import 'package:flutter_application_1/pages/dfu_record_page.dart';
import 'package:flutter_application_1/pages/education_page.dart';
import 'package:flutter_application_1/pages/stats.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PatientProfilePage extends StatefulWidget {
  final int patientId;
  int currentIndex; 
  final Function(int) onItemTapped; 

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
  Map<String, dynamic>? medicalRecordData; 

  final storage = FlutterSecureStorage();

  late List<bool> _isTappedList;

  @override
  void initState() {
    super.initState();
    fetchProfileData();
    fetchMedicalRecordData(); 
     _isTappedList = List.filled(8, false);
  }

  Future<void> fetchProfileData() async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'token');

      final profileResponse = await http.get(
        Uri.parse('http://192.168.1.66:3000/api/patient/profile/${widget.patientId}'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (profileResponse.statusCode == 200) {
        final fetchedProfileData = jsonDecode(profileResponse.body);
        setState(() {
          profileData = fetchedProfileData['profile']; 
        });
        print('Profile Data: $profileData');
      } else {
        throw Exception('Failed to fetch patient profile: ${profileResponse.statusCode}');
      }
    } catch (error) {
      print('Error fetching profile data: $error');
    }
  }

  Future<void> fetchMedicalRecordData() async {
  try {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    final medicalRecordResponse = await http.get(
      Uri.parse('http://192.168.1.66:3000/api/medical-record/${widget.patientId}'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (medicalRecordResponse.statusCode == 200) {
      final fetchedMedicalRecordData = jsonDecode(medicalRecordResponse.body)['medicalRecord'];
      print('Medical record data fetched successfully: $fetchedMedicalRecordData');
      setState(() {
        medicalRecordData = fetchedMedicalRecordData;
      });
    } else {
      print('Failed to fetch medical record: ${medicalRecordResponse.statusCode}');
      throw Exception('Failed to fetch medical record: ${medicalRecordResponse.statusCode}');
    }
  } catch (error) {
    print('Error fetching medical record data: $error');
  }
}


  void _handleItemTap(int index) {
  widget.onItemTapped(index);
  Navigator.pop(context);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('More'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 50), 
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StatsPage(),
                    ),
                  );
                },
              ),
              buildButton(
                index: 4,
                icon: Icons.health_and_safety_rounded,
                label: "Your plan",
                onTap: () {
                },
              ),
              buildButton(
                index: 5,
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
                index: 6,
                icon: Icons.settings,
                label: "Settings",
                onTap: () {
                },
              ),
              buildButton(
                index: 7,
                icon: Icons.question_mark,
                label: "About us",
                onTap: () {
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
      onTap: () {
      print('Tapped on $label button');
      onTap();
    },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
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
              color: Color(0xFF505050), 
              size: 24,
            ),
            SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                color: Color(0xFF5915BD),
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
              _buildProfileField(
                label: 'Gender',
                value: '${profileData!['gender']}',
                icon: Icons.edit,
                onPressed: () {
                  // Handle edit action
                },
              ),
              _buildProfileField(
                label: 'Height',
                value: '${profileData!['height']}',
                icon: Icons.edit,
                onPressed: () {
                  // Handle edit action
                },
              ),
              _buildProfileField(
                label: 'Weight',
                value: '${profileData!['weight']}',
                icon: Icons.edit,
                onPressed: () {
                  // Handle edit action
                },
              ),
              _buildProfileField(
                label: 'Birth Date',
                value: '${profileData!['birth_date']}',
                icon: Icons.edit,
                onPressed: () {
                  // Handle edit action
                },
              ),
            ] else ...[
              const CircularProgressIndicator(),
              const SizedBox(height: 10),
              const Text(
                'Profile data is loading...',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProfileField({
  required String label,
  required String value,
  required IconData icon,
  required VoidCallback onPressed,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 18.0), 
    child: ListTile(
      title: Text(
        label,
        style: const TextStyle(fontSize: 18, color: Color(0xFF5915BD)),
      ),
      subtitle: Container(
        height: 50, // Set a fixed height for the TextFormField
        child: TextFormField(
          initialValue: value,
          readOnly: false,
          style: const TextStyle(fontSize: 18, color: Color(0xFF505050)), 
        ),
      ),
      trailing: IconButton(
        icon: Icon(
          icon,
          color: Color(0xFF5915BD), 
        ),
        onPressed: onPressed,
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
        child: medicalRecordData != null
            ? medicalRecordData!.isEmpty
                ? Text(
                    'Medical record data is empty.',
                    style: TextStyle(fontSize: 18),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                    ],
                  )
            : CircularProgressIndicator(),
      ),
    );
  }
}