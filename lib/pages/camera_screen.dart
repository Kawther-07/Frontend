import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/dfu_record_page.dart';
import 'package:image_picker/image_picker.dart';
// import 'display_picture_screen.dart'; 
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

// import 'package:image/image.dart' as img;

class CameraScreen extends StatelessWidget {
  final int medicalRecordId;

  CameraScreen({Key? key, required this.medicalRecordId}) : super(key: key);

  Future<void> _takePicture(BuildContext context) async {
  final imagePicker = ImagePicker();
  try {
    print('Attempting to pick image from camera...');
    final pickedFile = await imagePicker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      print('Image picked successfully');
      
      // Get the directory for saving the image
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String imagePath = '${appDir.path}/image.jpg';
      final File imageFile = File(imagePath);
      await imageFile.writeAsBytes(await pickedFile.readAsBytes());
      print('Image saved to: $imagePath');

      // Create a multipart request
      final uri = Uri.parse('http://192.168.1.69:8000/api/dfu-record/upload');
      final request = http.MultipartRequest('POST', uri);
      
      // Add the image file to the request
      final file = await http.MultipartFile.fromPath('image', imageFile.path);
      request.files.add(file);
      print('Image added to request');

      // Add other fields if needed
      request.fields['medicalRecordId'] = medicalRecordId.toString();
      print('Request data: ${request.fields}');

      // Send the request
      final streamedResponse = await request.send();
      
      // Check the response status
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
    print('Image uploaded successfully');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DFURecordPage(imagePath: imagePath),
      ),
    );
  } else {
        print('Failed to upload image: ${response.reasonPhrase}');
        // Handle failure
      }
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






// Future<void> sendImageDataToBackend(int medicalRecordId, String base64Image) async {
//   try {
//     final response = await http.post(
//       Uri.parse('http://192.168.1.69:8000/api/dfu-record'), 
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, dynamic>{
//         'medicalRecordId': medicalRecordId.toString(), // Convert int to String
//         'view': 'front', // Example view, replace with actual view information
//         'description': 'Description of the image', // Example description, replace with actual description
//         'image': base64Image,
//       }),
//     );
//     if (response.statusCode == 200) {
//       // Image successfully saved in the backend
//       print('Image saved in backend');
//     } else {
//       // Handle error
//       print('Error saving image in backend: ${response.statusCode}');
//     }
//   } catch (e) {
//     print('Error sending image data to backend: $e');
//     // Handle error
//   }
// }
