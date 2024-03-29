import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;

class StatsPage extends StatefulWidget {
  final int patientId;
  const StatsPage({Key? key, required this.patientId}) : super(key: key);

  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  late List<GlycemiaData> data = [];
  final TextEditingController _glycemiaController = TextEditingController();
  late double newGlycemiaRate;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> addGlycemiaRecord() async {
    try {
      final Uri uri = Uri.parse('http://192.168.1.68:8000/api/glycemia');
      final http.Response response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'medicalRecordId': widget.patientId, // Use widget.patientId here
          'rate': newGlycemiaRate,
        }),
      );

      if (response.statusCode == 201) {
        fetchData(); // Fetch data again to update the chart
        _glycemiaController.clear(); // Clear the text field
      } else {
        print('Failed to add glycemia record: ${response.statusCode}');
      }
    } catch (error) {
      print('Error adding glycemia record: $error');
    }
  }


Future<int> fetchMedicalRecordId(int patientId) async {
  final Uri uri = Uri.parse('http://192.168.1.68:8000/api/medical-record/$patientId');
  final http.Response response = await http.get(uri);

  if (response.statusCode == 200) {
    final dynamic responseData = jsonDecode(response.body);
    return responseData['medicalRecordId']; // Assuming the response contains the medicalRecordId
  } else {
    throw Exception('Failed to fetch medical record ID');
  }
}


  Future<void> fetchData() async {
    try {
      final Uri uri = Uri.parse('http://192.168.1.68:8000/api/glycemia/${widget.patientId}');
      final http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
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

  // Future<void> addGlycemiaRecord() async {
  //   try {
  //     final Uri uri = Uri.parse('http://192.168.1.69:3000/api/glycemia');
  //     final http.Response response = await http.post(
  //       uri,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(<String, dynamic>{
  //         'medicalRecordId': 1, // Replace with the actual medical record ID
  //         'rate': newGlycemiaRate,
  //       }),
  //     );

  //     if (response.statusCode == 201) {
  //       fetchData(); // Fetch data again to update the chart
  //       _glycemiaController.clear(); // Clear the text field
  //     } else {
  //       print('Failed to add glycemia record: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     print('Error adding glycemia record: $error');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Glycemia Stats',
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildChart(),
              const SizedBox(height: 20),
              TextField(
                controller: _glycemiaController,
                decoration: InputDecoration(
                  labelText: 'Enter Glycemia Rate',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) {
                  newGlycemiaRate = double.tryParse(value) ?? 0.0;
                },
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                    Color(0xFFA67CE4),
                    Color(0xFF5915BD),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Material(
                color: Color(0x00FF0B0B),
                child: InkWell(
                  onTap: () {
                    addGlycemiaRecord();
                  },
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Center(
                      child: Text(
                        'Add Glycemia',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChart() {
  if (data.isEmpty) {
    return _emptyChart();
  } else {
    // Preprocess data using aggregation function
    List<GlycemiaData> aggregatedData = aggregateData(data);

    final List<charts.Series<GlycemiaData, DateTime>> seriesList = [
      charts.Series<GlycemiaData, DateTime>(
        id: 'Glycemia',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(const Color(0xFF595DE5)),
        domainFn: (GlycemiaData glycemia, _) => glycemia.date,
        measureFn: (GlycemiaData glycemia, _) => glycemia.glycemia,
        data: aggregatedData, // Use aggregated data
      ),
    ];

    final DateTime minDate = aggregatedData.map((e) => e.date).reduce((value, element) => value.isBefore(element) ? value : element);
    final DateTime maxDate = aggregatedData.map((e) => e.date).reduce((value, element) => value.isAfter(element) ? value : element);

    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: seriesList.length,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: charts.TimeSeriesChart(
              [seriesList[index]],
              animate: true,
              dateTimeFactory: const charts.LocalDateTimeFactory(),
              primaryMeasureAxis: const charts.NumericAxisSpec(
                tickProviderSpec: charts.BasicNumericTickProviderSpec(desiredTickCount: 7),
              ),
              domainAxis: charts.DateTimeAxisSpec(
                renderSpec: charts.SmallTickRendererSpec(
                  labelStyle: charts.TextStyleSpec(color: charts.MaterialPalette.white),
                  lineStyle: charts.LineStyleSpec(color: charts.MaterialPalette.white),
                ),
                tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
                  day: charts.TimeFormatterSpec(format: 'd', transitionFormat: 'MMM d'),
                  hour: charts.TimeFormatterSpec(format: 'HH:mm', transitionFormat: 'MMM d HH:mm'),
                ),
                viewport: charts.DateTimeExtents(
                  start: minDate, // Minimum date in the data
                  end: maxDate,   // Maximum date in the data
                ),
              ),
              behaviors: [
                charts.ChartTitle(
                  'Glycemia Stats',
                  subTitle: 'Date',
                  behaviorPosition: charts.BehaviorPosition.top,
                  titleStyleSpec: charts.TextStyleSpec(color: charts.MaterialPalette.white, fontSize: 6),
                  subTitleStyleSpec: charts.TextStyleSpec(color: charts.MaterialPalette.white, fontSize: 6),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget _emptyChart() {
  return Container(
    height: 250,
    width: double.infinity,
    child: Center(
      child: Text(
        'No glycemia data available',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
      ),
    ),
  );
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

// Function to aggregate data points with similar DateTime values
List<GlycemiaData> aggregateData(List<GlycemiaData> originalData) {
  // Map to store aggregated data points with DateTime as the key
  Map<DateTime, List<double>> aggregatedDataMap = {};

  // Iterate through the original data and group data points by DateTime
  for (var dataPoint in originalData) {
    if (!aggregatedDataMap.containsKey(dataPoint.date)) {
      aggregatedDataMap[dataPoint.date] = [];
    }
    aggregatedDataMap[dataPoint.date]!.add(dataPoint.glycemia);
  }

  // Calculate the average value for each DateTime group
  List<GlycemiaData> aggregatedData = [];
  aggregatedDataMap.forEach((dateTime, glycemiaList) {
    double averageGlycemia = glycemiaList.reduce((a, b) => a + b) / glycemiaList.length;
    aggregatedData.add(GlycemiaData(dateTime, averageGlycemia));
  });

  return aggregatedData;
}

