import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DFURecordPage extends StatefulWidget {
  final int patientId;
  final Map<String, dynamic>? dfuRecord;

  const DFURecordPage({Key? key, required this.patientId, this.dfuRecord}) : super(key: key);

  @override
  _DFURecordPageState createState() => _DFURecordPageState();
}

class _DFURecordPageState extends State<DFURecordPage> {
  Map<String, dynamic>? dfuRecord; // Make dfuRecord nullable
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.dfuRecord != null) {
      dfuRecord = widget.dfuRecord; // Assign widget.dfuRecord to dfuRecord if not null
      isLoading = false;
    } else {
      fetchDfuRecord(widget.patientId); // Fetch DFU record if widget.dfuRecord is null
    }
  }

  Future<void> fetchDfuRecord(int patientId) async {
    try {
      setState(() {
        isLoading = true; // Set loading state
      });
      print('Fetching DFU record for patient ID: $patientId');
      final response = await http
          .get(Uri.parse('http://192.168.1.9:8000/api/dfu-record/$patientId'))
          .timeout(const Duration(seconds: 10));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == true) {
          setState(() {
            dfuRecord = data['dfuRecord']; // Update dfuRecord with fetched data
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
          showError('No DFU record found');
        }
      } else {
        setState(() {
          isLoading = false;
        });
        showError('Failed to load DFU record');
      }
    } on http.ClientException catch (e) {
      setState(() {
        isLoading = false;
      });
      showError('Client exception: ${e.message}');
      print('Client exception: ${e.message}');
    } on TimeoutException catch (e) {
      setState(() {
        isLoading = false;
      });
      showError('Request timed out');
      print('Request timed out: $e');
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showError('An error occurred: $e');
      print('Error: $e');
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    // You can navigate back or handle the error state as per your app logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DFU Record', style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
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
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : dfuRecord == null // Check if dfuRecord is null
              ? Center(child: Text('No DFU record found for this patient ID'))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
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
                            Padding(
                              padding: const EdgeInsets.only(left: 20, top: 10),
                              child: Image.network(
                                dfuRecord!['image'],
                                fit: BoxFit.cover,
                                width: 250,
                                height: 250,
                                errorBuilder: (context, error, stackTrace) => Text(
                                  'Error loading image',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            Padding(
                              padding: EdgeInsets.only(right: 32),
                              child: Text(
                                'View: ${dfuRecord!['view'] ?? 'Not specified'}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            // SizedBox(height: 25),
                            // Padding(
                            //   padding: EdgeInsets.only(left: 30),
                            //   child: Text(
                            //     'Description: ${dfuRecord!['description'] ?? 'Not specified'}',
                            //     style: TextStyle(fontSize: 16),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}

