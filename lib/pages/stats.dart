import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const StatsPage(),
    );
  }
}

class StatsPage extends StatefulWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  late List<GlycemiaData> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final Uri uri = Uri.parse('http://192.168.1.66:3000/api/glycemia/1'); // Replace '1' with the actual patient ID
      final http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        print('Response Data: $responseData');
        setState(() {
          data = responseData.map((data) => GlycemiaData.fromJson(data)).toList();
        });
      } else {
        print('Failed to fetch glycemia data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching glycemia data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Glycemia Stats',
        style: TextStyle(color: Colors.white), // Set the text color of the app bar title here
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
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
        color: Colors.white, // Set the color of the back arrow here
      ),
    ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              height: 250,
              child: _buildChart(),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildChart() {
    if (data.isEmpty) {
      return const CircularProgressIndicator(); // Show loading indicator while data is being fetched
    } else {
      final seriesList = [
        charts.Series<GlycemiaData, DateTime>(
          id: 'Glycemia',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(const Color(0xFF595DE5)),
          domainFn: (GlycemiaData glycemia, _) => glycemia.date,
          measureFn: (GlycemiaData glycemia, _) => glycemia.glycemia,
          data: data,
        ),
      ];

      return Column(
        children: [
          Expanded(
            child: charts.TimeSeriesChart(
              seriesList,
              animate: true,
              dateTimeFactory: const charts.LocalDateTimeFactory(),
              primaryMeasureAxis: const charts.NumericAxisSpec(
                tickProviderSpec: const charts.BasicNumericTickProviderSpec(
                  desiredTickCount: 5,
                ),
              ),
              domainAxis: charts.DateTimeAxisSpec(
                renderSpec: charts.SmallTickRendererSpec(
                  labelStyle: charts.TextStyleSpec(
                    color: charts.MaterialPalette.white,
                  ),
                  lineStyle: charts.LineStyleSpec(
                    color: charts.MaterialPalette.white,
                  ),
                ),
                tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
                  day: charts.TimeFormatterSpec(
                    format: 'd',
                    transitionFormat: 'MMM d',
                  ),
                  hour: charts.TimeFormatterSpec(
                    format: 'HH:mm',
                    transitionFormat: 'MMM d HH:mm',
                  ),
                ),
              ),
              behaviors: [
                charts.ChartTitle(
                  'Glycemia Stats',
                  subTitle: 'Date',
                  behaviorPosition: charts.BehaviorPosition.top,
                  titleStyleSpec: charts.TextStyleSpec(
                    color: charts.MaterialPalette.white,
                    fontSize: 16,
                  ),
                  subTitleStyleSpec: charts.TextStyleSpec(
                    color: charts.MaterialPalette.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }
}

class GlycemiaData {
  final DateTime date;
  final double glycemia;

  GlycemiaData(this.date, this.glycemia);

  factory GlycemiaData.fromJson(Map<String, dynamic> json) {
    String dateString = json['createdAtFormatted'].replaceAll(' PM', '').replaceAll('T', ' ');
    return GlycemiaData(DateTime.parse(dateString), json['rate'].toDouble());
  }
}
