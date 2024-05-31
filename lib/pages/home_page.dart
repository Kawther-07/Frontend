import 'dart:convert';
import 'dart:io';
import 'package:DoolabMobile/pages/AboutUsPage.dart';
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
import 'dart:async';

class HomePage extends StatefulWidget {
  final int? patientId;
  final String? userName;
  final int? doctorId;
  final String? doctorName; // Add doctorName parameter
  final bool isNewRegistration;

  HomePage({Key? key, this.patientId, this.userName, this.doctorId, this.doctorName, this.isNewRegistration = false}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String _userName = '';
  late Timer _timer;
  int _tipIndex = 0;
  List<String> _tips = [
    'Keep your feet clean and dry.',
    'Check your feet daily for any sores or wounds.',
    'Wear comfortable shoes and socks to prevent friction.',
    'Wash you feet every day in warm water, and don\'t soak them.',
    'After washing your feet, dry them and put powed between your toes.',
    'Don\'t cut corns and calluses in your feet.',
    'To keep your feet smooth, use cream but don\'t put it between your toes.',
    'Trim your toenails straight across.',
    'Protect your feet from hot and cold.',
    'Keep the blood flowing, put your feet up when sitting.',
    'Don\'t wear tight socks.',
    'Be more physically active with activities like walking, swimming, or biking.',
    'Stop smoking.',
  ];

  // Controllers for appointment date and time
  String _nextAppointmentDate = '';
  String _nextAppointmentTime = '';
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  bool _editingAppointment = false;
  bool _showAppointmentBox = false; // Added to control visibility

  // State variables for medication details
String _nextMedicationName = ''; // Updated to hold medication name
String _nextMedicationTime = ''; // Optional if not needed
TextEditingController _medicationNameController = TextEditingController(); // Controller for medication name
TextEditingController _medicationTimeController = TextEditingController(); // Controller for medication time, if needed
bool _editingMedication = false;
bool _showMedicationBox = false; // Added to control visibility

  @override
void initState() {
  super.initState();
  print('Doctor ID in HomePage: ${widget.doctorId}');
  fetchUserName(); // Fetch user name when HomePage is initialized

  // Set up timer to change tips every 5 minutes
  _timer = Timer.periodic(const Duration(hours: 1), (timer) {
    setState(() {
      _tipIndex = (_tipIndex + 1) % _tips.length;
    });
  });
}

@override
void dispose() {
  _timer.cancel(); // Cancel the timer when the widget is disposed
  super.dispose();
}


  Future<void> fetchUserName() async {
    try {
      final Uri uri = Uri.parse('http://192.168.131.120:8000/api/patient/name/${widget.patientId}');
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
  //       final Uri uri = Uri.parse('http://192.168.131.120:8000/api/dfu-record/upload');
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


  // Method to show profile completion message as a dialog
 @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (widget.isNewRegistration) {
        _showProfileCompletionMessage();
      }
    });
  }

  void _showProfileCompletionMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Welcome, $_userName!'),
          content: Text('Fill your profiles for better experience.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Color(0xFFF7F1FF),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsPage()), // Replace AboutUsPage() with your actual about us page widget
              );
            },
            child: Container(
              padding: const EdgeInsets.all(0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Logo image widget
                    Container(
                      margin: EdgeInsets.only(bottom: 10), // Adjust margin as needed
                      width: 70, // Adjust width as needed
                      height: 70, // Adjust height as needed
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/Logo3.png'), // Replace with your image path
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(25), // Adjust border radius as needed
                      ),
                    ),
                    SizedBox(width: 0), // Spacer between logo and username
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _userName.isNotEmpty ? ' $_userName' : '',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.logout, color: Colors.black),
                      onPressed: () {
                        AuthService.logout(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

   
            // const SizedBox(height: 20),

            Container(
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
              child: Text(
                _tips[_tipIndex],
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                textAlign: TextAlign.center,
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
                            final Uri uri = Uri.parse('http://192.168.131.120:8000/api/dfu-record/upload');
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
                          builder: (context) => EducationPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            SingleChildScrollView(
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

              const SizedBox(height: 20),

              // Transparent button to show appointment box
    // GestureDetector to show appointment box
// GestureDetector to show appointment box
GestureDetector(
  onTap: () {
    setState(() {
      _showAppointmentBox = true; // Show appointment box on tap
    });
  },
  child: _showAppointmentBox
      ? Container() // If appointment box is shown, render an empty container
      : Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: const [
              SizedBox(width: 4), // Adjust the space between the icon and text
              Expanded(
                child: Text(
                  'Add Appointment',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                ),
              ),
              Icon(Icons.add, color: Colors.black), // Plus sign icon
            ],
          ),
        ),
),

const SizedBox(height: 20),

// Appointment Box
if (_showAppointmentBox)
  Container(
    margin: const EdgeInsets.symmetric(horizontal: 5),
    padding: const EdgeInsets.all(16), // Increased padding for a more prominent 3D effect
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: const Color(0xFF5915BD)), // Purple border
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF300374).withOpacity(0.5), // Purple shadow color and opacity
          spreadRadius: 1,
          blurRadius: 3,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Stack( // Use a stack to position the X button in the top-right corner
      children: [
        if (!_editingAppointment) // Hide the X button when editing
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                setState(() {
                  _editingAppointment = false;
                  _dateController.clear(); // Clear date input
                  _timeController.clear(); // Clear time input
                  _showAppointmentBox = false; // Hide appointment box
                });
              },
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10), // Adjust as needed
          child: _editingAppointment
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Transform.translate(
                              offset: const Offset(6, 1),
                              child: Transform.scale(
                                scale: 0.9,
                                child: const Icon(Icons.calendar_today, color: Color(0xFF5915BD)),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Your next appointment:',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _editingAppointment = false;
                              _showAppointmentBox = false; // Hide appointment box on cancel
                            });
                          },
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    SizedBox(
                      height: 40, // Adjust height as needed
                      child: TextField(
                        controller: _dateController,
                        style: const TextStyle(fontSize: 12), // Adjust text size
                        decoration: InputDecoration(
                          hintText: 'Date (e.g., June 17, 2024)',
                          border: OutlineInputBorder(),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 40, // Adjust height as needed
                      child: TextField(
                        controller: _timeController,
                        style: const TextStyle(fontSize: 12), // Adjust text size
                        decoration: InputDecoration(
                          hintText: 'Time (e.g., 11:00 am)',
                          border: OutlineInputBorder(),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _editingAppointment = false;
                          _nextAppointmentDate = _dateController.text;
                          _nextAppointmentTime = _timeController.text;
                        });
                      },
                      child: const Text('Save'),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Transform.translate(
                          offset: const Offset(6, 2),
                          child: Transform.scale(
                            scale: 0.9,
                            child: const Icon(Icons.calendar_today, color: Color(0xFF5915BD)),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Your next appointment:',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 36), // Adjust the width for left space
                        Text(
                          _nextAppointmentDate.isNotEmpty ? _nextAppointmentDate : 'No appointment set',
                          style: const TextStyle(fontSize: 12, color: Colors.black),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _nextAppointmentTime.isNotEmpty ? _nextAppointmentTime : '',
                          style: const TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _editingAppointment = true;
                              _dateController.text = _nextAppointmentDate;
                              _timeController.text = _nextAppointmentTime;
                            });
                          },
                          child: const Text('Edit'),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ],
    ),
  ),

  
// GestureDetector to show medication box
GestureDetector(
  onTap: () {
    setState(() {
      _showMedicationBox = true; // Show medication box on tap
    });
  },
  child: _showMedicationBox
      ? Container() // If medication box is shown, render an empty container
      : Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: const [
              SizedBox(width: 4), // Adjust the space between the icon and text
              Expanded(
                child: Text(
                  'Add Medication',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                ),
              ),
              Icon(Icons.add, color: Colors.black), // Plus sign icon
            ],
          ),
        ),
),

const SizedBox(height: 20),

// Medication Box
if (_showMedicationBox)
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
    child: Stack( // Use a stack to position the X button in the top-right corner
      children: [
        if (!_editingMedication) // Hide the X button when editing
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                setState(() {
                  _editingMedication = false;
                  _medicationNameController.clear(); // Clear medication name input
                  _medicationTimeController.clear(); // Clear medication time input
                  _showMedicationBox = false; // Hide medication box
                });
              },
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10), // Adjust as needed
          child: _editingMedication
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Transform.translate(
                              offset: const Offset(6, 1),
                              child: Transform.scale(
                                scale: 0.9,
                                child: const Icon(Icons.medication, color: Color(0xFF5915BD)),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Your medication:',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _editingMedication = false;
                              _showMedicationBox = false; // Hide medication box on cancel
                            });
                          },
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 40, // Adjust height as needed
                      child: TextField(
                        controller: _medicationNameController, // Use the medication name controller
                        style: const TextStyle(fontSize: 12), // Adjust text size
                        decoration: InputDecoration(
                          hintText: 'Name (e.g., Metformin)', // Update hint text if needed
                          border: OutlineInputBorder(),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 40, // Adjust height as needed
                      child: TextField(
                        controller: _medicationTimeController, // Use the medication time controller
                        style: const TextStyle(fontSize: 12), // Adjust text size
                        decoration: InputDecoration(
                          hintText: 'Time (e.g., 11:00 am)', // Update hint text if needed
                          border: OutlineInputBorder(),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _editingMedication = false;
                          _nextMedicationName = _medicationNameController.text; // Update next medication name
                          _nextMedicationTime = _medicationTimeController.text; // Update next medication time
                        });
                      },
                      child: const Text('Save'),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Transform.translate(
                          offset: const Offset(6, 2),
                          child: Transform.scale(
                            scale: 0.9,
                            child: const Icon(Icons.medication, color: Color(0xFF5915BD)),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Your medication:',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 36), // Adjust the width for left space
                        Text(
                          _nextMedicationName.isNotEmpty ? _nextMedicationName : 'No medication set', // Display medication name
                          style: const TextStyle(fontSize: 12, color: Colors.black),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _nextMedicationTime.isNotEmpty ? _nextMedicationTime : '', // Display medication time
                          style: const TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _editingMedication = true;
                              _medicationNameController.text = _nextMedicationName; // Prefill medication name
                              _medicationTimeController.text = _nextMedicationTime; // Prefill medication time
                            });
                          },
                          child: const Text('Edit'),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ],
    ),
  ),


            ],
        ),
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
      height: 120,
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
