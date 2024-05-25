import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:DoolabMobile/pages/dfu_record_page.dart';

class CameraScreen extends StatelessWidget {
  final int medicalRecordId;

  CameraScreen({Key? key, required this.medicalRecordId}) : super(key: key);

  Future<void> _takePicture(BuildContext context) async {
    final imagePicker = ImagePicker();
    try {
      final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        final File imageFile = File(pickedFile.path);

        // Upload the image to Firebase Storage
        final storageRef = FirebaseStorage.instance.ref().child('images/${DateTime.now().toIso8601String()}.jpg');
        final uploadTask = storageRef.putFile(imageFile);

        // Show loading dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(child: CircularProgressIndicator()),
        );

        // Get the download URL of the uploaded image
        final snapshot = await uploadTask.whenComplete(() {});
        final downloadUrl = await snapshot.ref.getDownloadURL();

        // Save the image URL to the server (Express/Node.js backend)
        final uri = Uri.parse('http://192.168.1.29:8000/api/dfu-record/upload');
        final response = await http.post(
          uri,
          body: json.encode({
            'medicalRecordId': medicalRecordId,
            'imageUrl': downloadUrl,
          }),
          headers: {'Content-Type': 'application/json'},
        );

        // Close loading dialog
        Navigator.of(context).pop();

        if (response.statusCode == 200) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DFURecordPage(imageUrl: downloadUrl),
            ),
          );
        } else {
          _showErrorDialog(context, 'Failed to upload image: ${response.reasonPhrase}');
        }
      }
    } catch (e) {
      print('Error taking picture: $e');
      _showErrorDialog(context, 'Error taking picture: $e');
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
      body: Center(
        child: Container(
          height: 50, // Adjust height as needed
          width: 280, // Adjust width as needed
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
            onPressed: () => _takePicture(context),
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
      ),
    );
  }
}
