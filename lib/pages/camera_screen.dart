import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'display_picture_screen.dart'; // Import the DisplayPictureScreen

import 'dart:convert';
import 'package:http/http.dart' as http;

class CameraScreen extends StatelessWidget {
  Future<void> _takePicture(BuildContext context) async {
    final imagePicker = ImagePicker();
    try {
      final pickedFile = await imagePicker.getImage(source: ImageSource.camera);
      if (pickedFile != null) {
        // Convert the image file to bytes
        List<int> imageBytes = await pickedFile.readAsBytes();

        // Convert bytes to base64 string (optional, depends on backend)
        String base64Image = base64Encode(imageBytes);

        // Send the image data to your backend server
        await sendImageDataToBackend(base64Image);

        // Navigate to the display picture screen
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

  Future<void> sendImageDataToBackend(String base64Image) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.68:8000/api/dfu-record'), // Replace with your backend endpoint
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'image': base64Image,
        }),
      );

      if (response.statusCode == 200) {
        // Image successfully saved in the backend
        print('Image saved in backend');
      } else {
        // Handle error
        print('Error saving image in backend: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending image data to backend: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _takePicture(context),
          child: Text('Take a picture'),
        ),
      ),
    );
  }
}
