import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MedicalRecordPage extends StatefulWidget {
  final int patientId;

  MedicalRecordPage({Key? key, required this.patientId}) : super(key: key);

  @override
  _MedicalRecordPageState createState() => _MedicalRecordPageState();
}

class _MedicalRecordPageState extends State<MedicalRecordPage> {
  Map<String, dynamic>? medicalRecordData;
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    fetchMedicalRecordData();
  }

  Future<void> fetchMedicalRecordData() async {
  try {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    print('Fetching medical record data for patientId: ${widget.patientId}');

    final medicalRecordResponse = await http.get(
      Uri.parse('http://192.168.1.66:3000/api/medical-record/${widget.patientId}'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    print('Medical record data fetch response status code: ${medicalRecordResponse.statusCode}');
    print('Medical record data fetch response body: ${medicalRecordResponse.body}');

    if (medicalRecordResponse.statusCode == 200) {
      final fetchedMedicalRecordData = jsonDecode(medicalRecordResponse.body);
      print('Fetched medical record data: $fetchedMedicalRecordData');

      setState(() {
        medicalRecordData = fetchedMedicalRecordData['medical-record'];
      });
    } else {
      throw Exception('Failed to fetch medical record: ${medicalRecordResponse.statusCode}');
    }
  } catch (error) {
    print('Error fetching medical record data: $error');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical Record'),
      ),
      body: Center(
        child: medicalRecordData != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Diabetes Type: ${medicalRecordData!['diabetesType']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Has DFU: ${medicalRecordData!['hasDFU']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Is Smoker: ${medicalRecordData!['isSmoker']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Diabetes Date: ${medicalRecordData!['hadDiabetes']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Blood group: ${medicalRecordData!['bloodGroup']}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
