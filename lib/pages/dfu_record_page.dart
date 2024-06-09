import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DFURecordPage extends StatefulWidget {
  final int patientId;
  final Map<String, dynamic>? dfuRecord;
  final int? medicalRecordId;

  const DFURecordPage({Key? key, required this.patientId, this.dfuRecord, this.medicalRecordId}) : super(key: key);

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
      dfuRecord = widget.dfuRecord; 
      isLoading = false;
    } else {
      fetchDfuRecord(widget.patientId, widget.medicalRecordId!);
    }
  }

  Future<void> fetchDfuRecord(int patientId, int medicalRecordId) async {
  try {
    setState(() {
      isLoading = true;
    });

    final response = await http
        .get(Uri.parse('http://192.168.1.9:8000/api/dfu-record/$patientId/$medicalRecordId'))
        .timeout(const Duration(seconds: 10));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == true) {
        setState(() {
          dfuRecord = data['dfuRecord'];
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
    handleFetchError('Client exception: ${e.message}');
  } on TimeoutException catch (e) {
    handleFetchError('Request timed out: $e');
  } catch (e) {
    handleFetchError('An error occurred: $e');
  }
}

void handleFetchError(String errorMessage) {
  setState(() {
    isLoading = false;
  });
  showError(errorMessage);
  print('Error: $errorMessage');
}

void showError(String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
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
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your foot image:',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Center(
                              child: Container(
                                width: 300,
                                height: 300,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    dfuRecord!['image'],
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Center(
                                      child: Text(
                                        'Error loading image',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'view: ${dfuRecord!['prediction'] ?? 'Not specified'}',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '${dfuRecord!['message'] ?? 'Prediction not available'}',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
