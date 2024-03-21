import 'package:flutter/material.dart';
import 'dart:io';

class DFURecordPage extends StatelessWidget {
  final String imagePath;

  const DFURecordPage({Key? key, required this.imagePath}) : super(key: key);

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('DFU Record'),
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 15),
          child: Text(
            'Your foot image:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Image.file(
                    File(imagePath),
                    fit: BoxFit.cover,
                    width: 250,
                    height: 250,
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(right: 182),
                  child: Text(
                    'View:',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.only(right: 125),
                  child: Text(
                    'Description:',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

}