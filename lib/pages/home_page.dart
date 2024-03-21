import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/auth_service.dart';
import 'package:flutter_application_1/pages/components/CustomBottomNavigationBar.dart';
import 'package:flutter_application_1/pages/education_page.dart';
import 'package:flutter_application_1/pages/stats.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'patient_profile_page.dart';
import 'dart:convert';

// import 'camera_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  final int? patientId;
  final String? userName;

  HomePage({Key? key, this.patientId, this.userName}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String _userName = '';
  

   @override
  void initState() {
    super.initState();
    fetchUserName();
  }

Future<void> fetchUserName() async {
  try {
    final Uri uri = Uri.parse('http://192.168.1.66:3000/api/patient/name/${widget.patientId}');
    final http.Response response = await http.get(uri);

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final name = responseData['patientName']; // Use the correct key 'patientName'

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

 Future<void> _takePicture() async {
    final imagePicker = ImagePicker();
    try {
      final pickedFile = await imagePicker.getImage(source: ImageSource.camera);
      if (pickedFile != null) {
        // Do something with the captured image
        // For example, you can display it in a new screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DisplayPictureScreen(imagePath: pickedFile.path),
          ),
        );
      }
    } catch (e) {
      print('Error taking picture: $e');
      // Handle error
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SizedBox.shrink(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              width: 300,
              height: 65,
              decoration: BoxDecoration(
                gradient: LinearGradient(
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
                          Icon(Icons.person, color: Colors.white),
                          SizedBox(width: 10),
                          Text(
                            _userName.isNotEmpty ? ' $_userName' : '',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.logout, color: Colors.white),
                      onPressed: () {
                        // Call the logout method from the AuthService class
                        AuthService.logout(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20), 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Color(0xFF5915BD)),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF300374).withOpacity(0.5), 
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 2), 
                        ),
                      ],
                    ),
                    child: RichText(
                      text: TextSpan(
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
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Color(0xFF5915BD)), 
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF300374).withOpacity(0.5), 
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 2), 
                        ),
                      ],
                    ),
                    child: Text(
                      'Have you taken your medications for today?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20), 
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Color(0xFF5915BD)), 
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF300374).withOpacity(0.5), 
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Transform.translate(
                        offset: Offset(0, 12), 
                        child: Icon(Icons.calendar_today, color: Color(0xFF5915BD)),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Your next appointment:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround, 
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Text(
                          'June 17, 2024',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      ),
                      SizedBox(width: 8), 
                      Padding(
                        padding: const EdgeInsets.only(right: 90),
                        child: Text(
                          '11:00 am',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                gradient: LinearGradient(
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
    Text(
      'Do you want to check your foot condition?',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    SizedBox(height: 16),
    SizedBox(
      width: 200,
      height: 50, 
      child: ElevatedButton(
        onPressed: _takePicture,

        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), 
          ),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          backgroundColor: Colors.white, 
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Take a picture',
              style: TextStyle(color: Color(0xFF5915BD)), 
            ),
            Icon(
              Icons.camera_alt,
              color: Color(0xFF5915BD), 
            ),
          ],
        ),
      ),
    ),
  ],
),
            ),
            SizedBox(height: 5), 
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Learn about your condition',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF262626)),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: 10),
                  FootConditionCard(imagePath: 'assets/dfu2.png'),
                  SizedBox(width: 10),
                  FootConditionCard(imagePath: 'assets/ulcer1.jpg'),
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
            builder: (context) => StatsPage(),
          ),
        );
        break;
      case 2:
        // Handle navigation to the Education page for the third icon (index 2)
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EducationPage(),
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

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display Picture'),
      ),
      body: Image.file(
        File(imagePath),
        fit: BoxFit.cover,
      ),
    );
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