import 'package:flutter/material.dart';
import 'dart:io';


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
        File(imagePath), // Use File class to create a file instance
        fit: BoxFit.cover,
      ),
    );
  }
}
