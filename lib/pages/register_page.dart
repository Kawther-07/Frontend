import 'dart:convert';
import 'package:DoolabMobile/pages/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:DoolabMobile/pages/components/my_texfield.dart'; // Assuming 'MyTextField' is imported correctly
import 'package:DoolabMobile/pages/home_page.dart';
import 'package:DoolabMobile/pages/patient_profile_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'login_page.dart';
import 'home_page.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  List<Map<String, dynamic>> doctors = [];
  String? selectedDoctorId;
  String? selectedDoctorName;

  @override
  void initState() {
    super.initState();
    fetchDoctorList();
  }

  Future<void> fetchDoctorList() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.29:8000/api/doctors'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> doctorsData = responseData['doctors'];
        setState(() {
          doctors = doctorsData.map((doctor) {
            String doctorName = '${doctor['first_name']} ${doctor['last_name']}';
            return {
              'id': doctor['id'].toString(),
              'name': doctorName,
            };
          }).toList();
        });
      } else {
        print('Failed to fetch doctors list');
      }
    } catch (e) {
      print('Error fetching doctors list: $e');
    }
  }

  Future<void> fetchDoctorId(String firstName, String lastName) async {
    try {
      final Uri uri = Uri.parse('http://192.168.1.29:8000/api/doctor/id')
          .replace(queryParameters: {
        'first_name': firstName,
        'last_name': lastName,
      });

      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final int? doctorId = responseData['doctor_id']; // Parse as int
        setState(() {
  selectedDoctorId = doctorId.toString(); // Convert int to String
  print('Selected Doctor ID: $selectedDoctorId');
});
      } else {
        print('Failed to fetch doctor ID: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error fetching doctor ID: $e');
    }
  }

  void registerUser(BuildContext context) async {
  final Uri uri = Uri.parse('http://192.168.1.29:8000/api/patient/register');

  // Parse selectedDoctorId to int or set to null if it's empty or null
  int? doctorId = selectedDoctorId != null && selectedDoctorId!.isNotEmpty ? int.tryParse(selectedDoctorId!) : null;

  final Map<String, dynamic> userData = {
    'first_name': fnameController.text,
    'last_name': lnameController.text,
    'phone': phoneController.text,
    'email': emailController.text,
    'password': passwordController.text,
    'selected_doctor': doctorId, // Pass doctorId here
  };

  try {
    final http.Response response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userData),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String? message = responseData['message'];
      final int? patientId = responseData['id'];

      if (message == 'Patient registered successfully' && patientId != null) {
        final storage = FlutterSecureStorage();
        await storage.write(key: 'token', value: ''); // Replace with your token logic

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(patientId: patientId, doctorId: doctorId), // Pass doctorId to HomePage
          ),
        );
      } else {
        // Handle unexpected response or message scenario
        print('Unexpected response data: $responseData');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Failed to register user.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      // Handle other status codes (e.g., 400, 500)
      print('Registration failed with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to register user.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  } catch (e) {
    print('Error during registration: $e');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Failed to register user.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}


  void navigateToSignInPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Image.asset(
                    'assets/Logo.png', // Replace 'assets/logo.png' with your logo image path
                    width: 230,
                    height: 140,
                  ),
                ),
                Text(
                  'Please enter your information.',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.grey.shade900,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 15),
                MyTextField(
                  controller: fnameController,
                  hintText: 'First name',
                  obscureText: false,
                ),

                SizedBox(height: 10),

                MyTextField(
                  controller: lnameController,
                  hintText: 'Last name',
                  obscureText: false,
                ),

                SizedBox(height: 10),

                MyTextField(
                  controller: phoneController,
                  hintText: 'Phone number',
                  obscureText: false,
                ),

                SizedBox(height: 10),

                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                SizedBox(height: 10),

                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                SizedBox(height: 10),

                Container(
                  width: 342,
                  height: 55,
                  padding: EdgeInsets.symmetric(horizontal: 13.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: DropdownButtonFormField<String>(
  value: selectedDoctorName,
  onChanged: (value) {
    setState(() {
      selectedDoctorName = value!;
      // Extract first name and last name from selectedDoctorName if needed
      List<String> nameParts = value.split(' ');
      String firstName = nameParts[0];
      String lastName = nameParts.length > 1 ? nameParts[1] : '';
      fetchDoctorId(firstName, lastName); // Call method to fetch doctor ID
    });
  },
  items: doctors.map((doctor) {
    return DropdownMenuItem<String>(
      value: doctor['name'], // Ensure doctor['name'] is a String
      child: Text(doctor['name']),
    );
  }).toList(),
  decoration: InputDecoration(
    hintText: 'Select Doctor',
    hintStyle: TextStyle(color: Colors.grey),
    border: InputBorder.none,
  ),
),
                ),

                SizedBox(height: 50),

                GestureDetector(
                  onTap: () {
                    registerUser(context); // Call registerUser without await
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.symmetric(horizontal: 25),
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
                        "Sign up",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                GestureDetector(
                  onTap: () => navigateToSignInPage(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),

                      SizedBox(width: 4),

                      Text(
                        'Sign in.',
                        style: TextStyle(
                          color: Color(0xFF218BBC),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
