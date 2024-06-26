import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:DoolabMobile/pages/dfu_record_page.dart';

class CameraScreen extends StatefulWidget {
  final int patientId;

  CameraScreen({Key? key, required this.patientId}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  bool isProcessing = false;

  Future<int?> fetchMedicalRecordId(int patientId) async {
    final Uri uri = Uri.parse('http://192.168.1.3:8000/api/medical-record-id/$patientId');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['medicalRecordId'];
    }
    return null;
  }

  Future<void> _createDfuRecord(BuildContext context, String imageUrl, String prediction, int medicalRecordId) async {
    try {
      final Uri dfuRecordUri = Uri.parse('http://192.168.1.3:8000/api/dfu-record');
      final http.Response response = await http.post(
        dfuRecordUri,
        body: json.encode({
          'imageUrl': imageUrl,
          'prediction': prediction,
          'medicalRecordId': medicalRecordId,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        print('DFU Record created successfully');
      } else {
        _showErrorDialog(context, 'Failed to create DFU record: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorDialog(context, 'Error creating DFU record: $e');
    }
  }

  Future<void> _takePicture(BuildContext context) async {
    setState(() {
      isProcessing = true;
    });

    final imagePicker = ImagePicker();
    try {
      final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        final File imageFile = File(pickedFile.path);

        final Reference storageRef = FirebaseStorage.instance.ref().child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
        final UploadTask uploadTask = storageRef.putFile(imageFile);
        final TaskSnapshot snapshot = await uploadTask;
        final String downloadUrl = await snapshot.ref.getDownloadURL();
        print('Image uploaded. Download URL: $downloadUrl');

        int? medicalRecordId = await fetchMedicalRecordId(widget.patientId);
        if (medicalRecordId == null) {
          _showErrorDialog(context, 'Failed to fetch medical record ID.');
          setState(() {
            isProcessing = false;
          });
          return;
        }

        final Uri predictUri = Uri.parse('http://192.168.1.3:5000/predict');
        final http.Response response = await http.post(
          predictUri,
          body: json.encode({
            'medicalRecordId': medicalRecordId,
            'imageUrl': downloadUrl,
          }),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200) {
          final prediction = jsonDecode(response.body);
          final String predictionText = prediction['prediction'];
          final String message = predictionText == 'Normal'
              ? 'Take care of your feet to prevent DFU.'
              : 'You need to consult with your doctor.';

          await _createDfuRecord(context, downloadUrl, predictionText, medicalRecordId);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DFURecordPage(
                patientId: widget.patientId,
                dfuRecord: {
                  'image': downloadUrl,
                  'prediction': predictionText,
                  'message': message,
                },
              ),
            ),
          );
        } else {
          _showErrorDialog(context, 'Failed to upload image to backend: ${response.statusCode}');
        }
      }
    } catch (e) {
      _showErrorDialog(context, 'Error taking picture or uploading: $e');
    } finally {
      setState(() {
        isProcessing = false;
      });
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Camera Screen',
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
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
          color: Colors.white,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 60), // Space from the top of the screen
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'To ensure accurate diagnosis, please follow these tips:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Text(
                        '1. Place your foot on a flat surface with good lighting.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        '2. Ensure the entire foot is visible in the picture.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        '3. Keep the camera steady to avoid blurry images.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                SizedBox(height: 40), // Space between tips and button
                Container(
                  height: 50,
                  width: 280,
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  margin: EdgeInsets.symmetric(horizontal: 25),
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
                  child: ElevatedButton(
                    onPressed: isProcessing ? null : () => _takePicture(context),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.transparent), // Make button transparent
                      elevation: MaterialStateProperty.all(0), // Remove elevation
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Take a picture',
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
          if (isProcessing)
            Container(
              color: Colors.black54,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
