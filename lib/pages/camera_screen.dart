import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'display_picture_screen.dart'; // Import the DisplayPictureScreen

class CameraScreen extends StatelessWidget {
  Future<void> _takePicture(BuildContext context) async {
    final imagePicker = ImagePicker();
    try {
      final pickedFile = await imagePicker.getImage(source: ImageSource.camera);
      if (pickedFile != null) {
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
