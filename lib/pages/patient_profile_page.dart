import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/components/CustomBottomNavigationBar.dart';
import 'package:flutter_application_1/pages/dfu_record_page.dart';
import 'package:flutter_application_1/pages/education_page.dart';
import 'package:flutter_application_1/pages/stats.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

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
        Uri.parse('http://192.168.1.68:8000/api/patient/profile/${widget.patientId}'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print('token $token');
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
      Uri.parse('http://192.168.1.68:8000/api/medical-record/${widget.patientId}'),
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
      title: Text(
        'More',
        style: TextStyle(color: Colors.white), // Set the text color of the app bar title here
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFA67CE4), // First color
              Color(0xFF5915BD), // Second color
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.white, // Set the color of the back arrow here
      ),
    ),
      // backgroundColor: Color(0xFFF9F6EE),
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
                      builder: (context) => PersonalProfilePage(
                        profileData: profileData,
                        patientId: widget.patientId,
                      ),
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
                      builder: (context) => DFURecordPage(imagePath: '',),
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
                      builder: (context) => StatsPage(patientId: widget.patientId),
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


// I CHANGED THIS ----------------------------------------------------------------------------------------------------------
// Personal Profile Page
class PersonalProfilePage extends StatefulWidget {
  final Map<String, dynamic>? profileData;
  final int patientId;

  PersonalProfilePage({Key? key, required this.profileData, required this.patientId}) : super(key: key);

  @override
  _PersonalProfilePageState createState() => _PersonalProfilePageState();
}

class _PersonalProfilePageState extends State<PersonalProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late double height;
  late double weight;
  late DateTime? birthDate;

  String? gender;

  @override
  void initState() {
    super.initState();
    // Initialize birthDate from profileData if available
    if (widget.profileData != null && widget.profileData!['birth_date'] != null) {
      birthDate = DateTime.parse(widget.profileData!['birth_date']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personal Profile',
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFFA67CE4),
                Color(0xFF5915BD),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  initialValue: widget.profileData?['gender'] ?? '',
                  decoration: InputDecoration(labelText: 'Gender'),
                  onChanged: (value) {
                    setState(() {
                      gender = value;
                    });
                  },
                ),
                TextFormField(
                  initialValue: widget.profileData?['height'] != null
                      ? widget.profileData!['height'].toString()
                      : '',
                  decoration: InputDecoration(labelText: 'Height'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter height';
                    }
                    return null;
                  },
                  onSaved: (value) => height = double.parse(value!),
                ),
                TextFormField(
                  initialValue: widget.profileData?['weight'] != null
                      ? widget.profileData!['weight'].toString()
                      : '',
                  decoration: InputDecoration(labelText: 'Weight'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter weight';
                    }
                    return null;
                  },
                  onSaved: (value) => weight = double.parse(value!),
                ),
                TextFormField(
                  controller: TextEditingController(
                    text: birthDate != null ? DateFormat('yyyy-MM-dd').format(birthDate!) : '',
                  ),
                  decoration: InputDecoration(labelText: 'Birth Date'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter birth date';
                    }
                    return null;
                  },
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: birthDate ?? DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        birthDate = pickedDate;
                      });
                    }
                  },
                  readOnly: true,
                ),
              SizedBox(height: 50),
              Stack(
  children: [
    GestureDetector(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          // Check if the profile already exists (profileData is not null)
          if (widget.profileData != null) {
            // If the profile already exists, call updateProfileData
            _updateProfileData();
          } else {
            // If the profile doesn't exist, call saveProfileData
            _saveProfileData();
          }
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 100),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFA67CE4),
              Color(0xFF5915BD),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
        ),
        child: Text(
          'Save',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16, 
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  ],
)
            ],
          ),
        ),
      ),
    ),
  );
}


  void _saveProfileData() async {
  // Retrieve the patient's ID from the profile data
  final int patientId = widget.patientId;
  print('Patient ID: $patientId');
  // Check if patientId is null
  if (patientId == null) {
    print('Error: Patient ID is null');
    return; // or handle the error in another way
  }

  // Validate gender field
  if (gender == null || gender!.isEmpty) {
    print('Error: Gender is required');
    return;
  }

  // Construct the body of the POST request
  final Map<String, dynamic> requestBody = {
    'patientId': patientId,
    'gender': gender,
    'height': height,
    'weight': weight,
    'birth_date': birthDate?.toIso8601String(),
  };

  print('Request Body: $requestBody');
  // Encode the request body to JSON
  final String jsonBody = jsonEncode(requestBody);
  print('JSON Body: $jsonBody');

  // Define the URI for the API endpoint
  final Uri uri = Uri.parse('http://192.168.1.68:8000/api/patient/profile');
  print('Request URI: $uri');
  try {
    // Send the POST request
    final http.Response response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonBody,
    );

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Handle successful response
      print('Profile data saved successfully!');
      // Show success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Profile data saved successfully!'),
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
    } else {
      // Handle error response
      print('Failed to save profile data: ${response.statusCode}');
      // Show error dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // title: Text('Error'),
            content: Text('Profile data saved successfully!'),
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
  } catch (error) {
    // Handle network errors
    print('Error sending request: $error');
    // Show error dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('An error occurred while trying to save profile data. Please check your internet connection and try again.'),
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
}



  void _updateProfileData() async {
  final int patientId = widget.patientId;

  // Ensure patientId is valid (not null)
  if (patientId == null) {
    print('Error: Invalid patient ID');
    return;
  }

  // Construct the request body
  final Map<String, dynamic> requestBody = {
    'patientId': patientId,
  };

  // Add non-empty fields to the request body
  if (gender != null && gender!.isNotEmpty) {
    requestBody['gender'] = gender;
  }
  if (height != null) {
    requestBody['height'] = height;
  }
  if (weight != null) {
    requestBody['weight'] = weight;
  }
  if (birthDate != null) {
    requestBody['birth_date'] = birthDate!.toIso8601String();
  }

  // Convert the request body to JSON
  final String jsonBody = jsonEncode(requestBody);
  print('PATCH Request Body: $jsonBody');
  // Define the request URI
  final Uri uri = Uri.parse('http://192.168.1.68:8000/api/patient/updateprofile/$patientId');

  try {
    // Send the PATCH request
    final http.Response response = await http.patch(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonBody,
    );

    // Handle the response
    if (response.statusCode == 200) {
      print('Profile data updated successfully!');
      // Show success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Profile data updated successfully!'),
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
    } else {
      print('Failed to update profile data: ${response.statusCode}');
      // Show error dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to update profile data. Please try again later.'),
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
  } catch (error) {
    // Handle errors
    print('Error sending request: $error');
    // Show error dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('An error occurred while trying to update profile data. Please check your internet connection and try again.'),
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
}

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
        height: 35, // Set a fixed height for the TextFormField
        child: TextFormField(
          initialValue: value,
          readOnly: label != 'Birth Date', // Make birth date field readOnly
          style: const TextStyle(fontSize: 18, color: Color(0xFF505050)),
          onTap: label == 'Birth Date' ? onPressed : null, // Show date picker only for birth date field
        ),
      ),
      trailing: label == 'Birth Date' ? IconButton(
        icon: Icon(
          icon,
          color: Color(0xFF5915BD),
        ),
        onPressed: onPressed,
      ) : null,
    ),
  );
}







// Medical Record Page
class MedicalRecordPage extends StatelessWidget {
  final Map<String, dynamic>? medicalRecordData;

  MedicalRecordPage({Key? key, required this.medicalRecordData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Medical Record',
          style: TextStyle(color: Colors.white), // Set the text color of the app bar title here
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFA67CE4), // First color
              Color(0xFF5915BD), // Second color
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.white, // Set the color of the back arrow here
      ),
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
                      _buildMedicalRecordField(
                        label: 'Diabetes Type',
                        value: '${medicalRecordData!['diabetesType']}',
                        icon: Icons.edit,
                        onPressed: () {
                          // Handle edit action
                        },
                      ),
                      _buildMedicalRecordField(
                        label: 'Do you have DFU?',
                        value: '${medicalRecordData!['hasDFU']}',
                        icon: Icons.edit,
                        onPressed: () {
                          // Handle edit action
                        },
                      ),
                      _buildMedicalRecordField(
                        label: 'Do you smoke?',
                        value: '${medicalRecordData!['isSmoker']}',
                        icon: Icons.edit,
                        onPressed: () {
                          // Handle edit action
                        },
                      ),
                      _buildMedicalRecordField(
                        label: 'When did you get diagnosed with diabetes?',
                        value: '${medicalRecordData!['hadDiabetes']}',
                        icon: Icons.edit,
                        onPressed: () {
                          // Handle edit action
                        },
                      ),
                      _buildMedicalRecordField(
                        label: 'Blood group',
                        value: '${medicalRecordData!['bloodGroup']}',
                        icon: Icons.edit,
                        onPressed: () {
                          // Handle edit action
                        },
                      ),
                      SizedBox(height: 25), // Add spacing between the last field and the button
                      GestureDetector(
                  onTap: () => (),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.symmetric(horizontal: 85),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFA67CE4), // First color
                          Color(0xFF5915BD), // Second color
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        "Save",
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
                  )
            : CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildMedicalRecordField({
    required String label,
    required String value,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 1.0, right: 0), 
      child: ListTile(
        title: Text(
          label,
          style: const TextStyle(fontSize: 16, color: Color(0xFF5915BD)),
        ),
        subtitle: Container(
          height: 27, // Set a fixed height for the TextFormField
          child: TextFormField(
            initialValue: value,
            readOnly: false,
            style: const TextStyle(fontSize: 15, color: Color(0xFF505050)), 
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
