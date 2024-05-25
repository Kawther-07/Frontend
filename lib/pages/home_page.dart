import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:DoolabMobile/pages/dfu_record_page.dart';
import 'package:DoolabMobile/pages/education_page.dart';
import 'package:DoolabMobile/pages/stats.dart';
import 'package:DoolabMobile/pages/patient_profile_page.dart';
import 'package:DoolabMobile/pages/components/CustomBottomNavigationBar.dart';
import 'package:DoolabMobile/pages/auth_service.dart';

class HomePage extends StatefulWidget {
  final int? patientId;
  final String? userName;
  final int? doctorId;
  final String? doctorName; // Add doctorName parameter

  HomePage({Key? key, this.patientId, this.userName, this.doctorId, this.doctorName}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String _userName = '';

  @override
  void initState() {
    super.initState();
    fetchUserName(); // Fetch user name when HomePage is initialized
  }

  Future<void> fetchUserName() async {
    try {
      final Uri uri = Uri.parse('http://192.168.1.29:8000/api/patient/name/${widget.patientId}');
      final http.Response response = await http.get(uri);
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final name = responseData['patientName']; // Update the key to match the response data
        if (name != null && name.isNotEmpty) {
          setState(() {
            _userName = name;
          });
        } else {
          print('User name is null or empty');
        }
      } else {
        print('Failed to fetch user name: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user name: $e');
    }
  }

  // Future<void> _takePicture() async {
  //   final imagePicker = ImagePicker();
  //   try {
  //     final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
  //     if (pickedFile != null) {
  //       final File imageFile = File(pickedFile.path);

  //       // Upload image to Firebase Storage
  //       final Reference storageRef = FirebaseStorage.instance.ref().child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
  //       final UploadTask uploadTask = storageRef.putFile(imageFile);
        
  //       // Get download URL of uploaded image
  //       TaskSnapshot snapshot = await uploadTask;
  //       final String downloadUrl = await snapshot.ref.getDownloadURL();

  //       // Send downloadUrl to backend
  //       final Uri uri = Uri.parse('http://192.168.1.29:8000/api/dfu-record/upload');
  //       final http.Response response = await http.post(
  //         uri,
  //         body: json.encode({
  //           'medicalRecordId': widget.patientId,
  //           'imageUrl': downloadUrl,
  //         }),
  //         headers: {'Content-Type': 'application/json'},
  //       );

  //       if (response.statusCode == 200) {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => DFURecordPage(imageUrl: downloadUrl),
  //           ),
  //         );
  //       } else {
  //         print('Failed to upload image to backend: ${response.statusCode}');
  //       }
  //     }
  //   } catch (e) {
  //     print('Error taking picture or uploading: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: 300,
              height: 65,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFA67CE4),
                    Color(0xFF5915BD),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 15),
                          Text(
                            _userName.isNotEmpty ? ' $_userName' : '',
                            style: const TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout, color: Colors.white),
                      onPressed: () {
                        AuthService.logout(context);
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: const Color(0xFF5915BD)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF300374).withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Your blood sugar:\n',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                          ),
                          TextSpan(
                            text: '7.22 mmol/L',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: const Color(0xFF5915BD)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF300374).withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Text(
                      'Have you taken your medications for today?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: const Color(0xFF5915BD)),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF300374).withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Transform.translate(
                        offset: const Offset(6, 8),
                        child: Transform.scale(
                          scale: 0.9, // Adjust the scale factor as needed
                          child: const Icon(Icons.calendar_today, color: Color(0xFF5915BD)),
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        'Your next appointment:',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 0),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 25),
                        child: Text(
                          'June 17, 2024',
                          style: TextStyle(fontSize: 11, color: Colors.black),
                        ),
                      ),
                      SizedBox(width: 3),
                      Padding(
                        padding: EdgeInsets.only(right: 54),
                        child: Text(
                          '11:00 am',
                          style: TextStyle(fontSize: 11, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFA67CE4),
                    Color(0xFF5915BD),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text(
                    'Do you want to check your foot condition?',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 200,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () async {
                        final imagePicker = ImagePicker();
                        try {
                          final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
                          if (pickedFile != null) {
                            final File imageFile = File(pickedFile.path);

                            // Upload image to Firebase Storage
                            final Reference storageRef = FirebaseStorage.instance.ref().child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
                            final UploadTask uploadTask = storageRef.putFile(imageFile);
                            
                            // Get download URL of uploaded image
                            TaskSnapshot snapshot = await uploadTask;
                            final String downloadUrl = await snapshot.ref.getDownloadURL();

                            // Send downloadUrl to backend
                            final Uri uri = Uri.parse('http://192.168.1.29:8000/api/dfu-record/upload');
                            final http.Response response = await http.post(
                              uri,
                              body: json.encode({
                                'medicalRecordId': widget.patientId,
                                'imageUrl': downloadUrl,
                              }),
                              headers: {'Content-Type': 'application/json'},
                            );

                            if (response.statusCode == 200) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DFURecordPage(imageUrl: downloadUrl),
                                ),
                              );
                            } else {
                              print('Failed to upload image to backend: ${response.statusCode}');
                            }
                          }
                        } catch (e) {
                          print('Error taking picture or uploading: $e');
                        }
                      },
                      child: Text('Take Picture'),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 2),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Learn about your condition',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF1F1F1F)),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward, color: Color(0xFF5915BD)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EducationPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: 10),
                  FootConditionCard(imagePath: 'assets/dfu2.png'),
                  SizedBox(width: 10),
                  FootConditionCard(imagePath: 'assets/dfu1.png'),
                  SizedBox(width: 10),
                  FootConditionCard(imagePath: 'assets/dfu3.png'),
                  SizedBox(width: 10),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });

      switch (index) {
        case 0:
          if (widget.patientId != null) {
            return;
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(patientId: widget.patientId),
              ),
            );
          }
        break;
        case 1:
          // Handle navigation to the Stats page for the second icon (index 1)
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StatsPage(patientId: widget.patientId!),
            ),
          );
        break;
        case 2:
          // Handle navigation to the Education page for the third icon (index 2)
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EducationPage(),
            ),
          );
        break;
        case 3:
          if (widget.patientId != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PatientProfilePage(
                  patientId: widget.patientId!,
                  doctorId: widget.doctorId,
                  currentIndex: _selectedIndex,
                  onItemTapped: _handleItemTap,
                ),
              ),
            );
          } else {
            print('Patient ID is null');
          }
        break;
      }
    }
  }

  void _navigateToProfilePage() {
    if (widget.patientId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PatientProfilePage(
            patientId: widget.patientId!,
            currentIndex: _selectedIndex,
            onItemTapped: _handleItemTap,
          ),
        ),
      ).then((value) {
        // Reset selectedIndex when returning from profile page
        setState(() {
          _selectedIndex = 0;
        });
      });
    } else {
      print('Patient ID is null');
    }
  }

  void _handleItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class FootConditionCard extends StatelessWidget {
  final String imagePath;
  const FootConditionCard({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
