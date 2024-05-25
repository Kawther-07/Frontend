import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;


class DFURecordPage extends StatelessWidget {
  final String imageUrl;

  const DFURecordPage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DFU Record',
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFA67CE4),
                Color(0xFF5915BD),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 15),
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
                  if (imageUrl.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 10),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: 250,
                        height: 250,
                        errorBuilder: (context, error, stackTrace) => Text(
                          'Error loading image',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.only(left: 50, top: 20),
                      child: Text(
                        "You haven't taken any picture yet",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                  const SizedBox(height: 30),
                  const Padding(
                    padding: EdgeInsets.only(right: 207),
                    child: Text(
                      'View:',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Padding(
                    padding: EdgeInsets.only(right: 148),
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