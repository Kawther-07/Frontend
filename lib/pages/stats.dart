import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StatsPage extends StatefulWidget {
  final int patientId;
  const StatsPage({Key? key, required this.patientId}) : super(key: key);

  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  late List<GlycemiaData> data = [];
  final TextEditingController _glycemiaController = TextEditingController();
  double newGlycemiaRate = double.nan; 
  bool _showGlycemiaList = false;
  int? medicalRecordId;
  String currentMonth = DateFormat('MMMM').format(DateTime.now()); // Track the current month dynamically

  @override
  void initState() {
    super.initState();
    fetchMedicalRecordId();
  }

  Future<void> fetchMedicalRecordId() async {
    try {
      final Uri uri = Uri.parse('http://192.168.1.3:8000/api/medical-record-id/${widget.patientId}');
      final http.Response response = await http.get(uri);
      print('Fetch medical record ID - Response status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final int? fetchedMedicalRecordId = responseData['medicalRecordId'];
        if (fetchedMedicalRecordId != null) {
          setState(() {
            medicalRecordId = fetchedMedicalRecordId;
          });
          print('Fetched medical record ID: $medicalRecordId');
          fetchData();
        } else {
          print('Medical record ID not found in response data');
        }
      } else {
        print('Failed to fetch medical record ID: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching medical record ID: $error');
    }
  }

  Future<void> addGlycemiaRecord() async {
    if (medicalRecordId == null) {
      print('Medical record ID is not available yet.');
      return;
    }

    if (newGlycemiaRate.isNaN || newGlycemiaRate.isInfinite) {
      print('Invalid glycemia rate: $newGlycemiaRate');
      return;
    }

    try {
      final Uri uri = Uri.parse('http://192.168.1.3:8000/api/glycemia');
      print('Sending request to: $uri');
      print('Request body: ${jsonEncode(<String, dynamic>{
        'medicalRecordId': medicalRecordId,
        'rate': newGlycemiaRate,
      })}');

      final http.Response response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'medicalRecordId': medicalRecordId,
          'rate': newGlycemiaRate,
        }),
      );

      if (response.statusCode == 201) {
        fetchData();
        _glycemiaController.clear();
        newGlycemiaRate = double.nan;
      } else {
        print('Failed to add glycemia record: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      print('Error adding glycemia record: $error');
    }
  }

  Future<void> fetchData() async {
    try {
      final Uri uri = Uri.parse('http://192.168.1.3:8000/api/glycemia/${widget.patientId}');
      final http.Response response = await http.get(uri);
      print('Fetch glycemia data - Response status code: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        print('Fetch glycemia data - Response data: $responseData');
        
        setState(() {
          data = responseData
              .map((data) => GlycemiaData.fromJson(data))
              .where((glycemiaData) => !glycemiaData.glycemia.isNaN && !glycemiaData.glycemia.isInfinite)
              .toList();

          // Update current month based on the first data point
          if (data.isNotEmpty) {
            currentMonth = DateFormat('MMMM').format(data.first.date);
          } else {
            currentMonth = ''; // Reset if data is empty
          }
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
      backgroundColor: Color(0xFFF5EEFF),
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
              _buildGlycemiaChart(),
              const SizedBox(height: 20),
              TextField(
                controller: _glycemiaController,
                decoration: InputDecoration(
                  labelText: 'Enter Glycemia Rate',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) {
                  setState(() {
                    newGlycemiaRate = double.tryParse(value) ?? double.nan;
                  });
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: medicalRecordId != null ? addGlycemiaRecord : null,
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(vertical: 5.0),
                  ),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    medicalRecordId != null ? Colors.transparent : Colors.grey.withOpacity(0.5),
                  ),
                  elevation: MaterialStateProperty.all<double>(0),
                  shadowColor: MaterialStateProperty.all<Color>(
                    Colors.transparent,
                  ),
                  foregroundColor: MaterialStateProperty.all<Color>(
                    Colors.white,
                  ),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFA67CE4),
                        Color(0xFF5915BD),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Container(
                    constraints: BoxConstraints(minWidth: 140.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Text(
                      'Add Glycemia',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showGlycemiaList = !_showGlycemiaList;
                  });
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(vertical: 5.0),
                  ),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.transparent,
                  ),
                  overlayColor: MaterialStateProperty.all<Color>(
                    Colors.transparent,
                  ),
                  elevation: MaterialStateProperty.all<double>(0),
                  shadowColor: MaterialStateProperty.all<Color>(
                    Colors.transparent,
                  ),
                  foregroundColor: MaterialStateProperty.all<Color>(
                    Colors.white,
                  ),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFA67CE4),
                        Color(0xFF5915BD),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Container(
                    constraints: BoxConstraints(minWidth: 140.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Text(
                      _showGlycemiaList ? 'Hide Glycemia Records' : 'Show Glycemia Records',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              if (_showGlycemiaList) _buildGlycemiaList(),
            ],
          ),
        ),
      ),
    );
  }



  Widget _buildGlycemiaChart() {
  if (data.isEmpty) {
    return const Text('No glycemia data available.');
  }

  final List<FlSpot> spots = data
      .asMap()
      .entries
      .map((entry) => FlSpot(entry.key.toDouble(), entry.value.glycemia))
      .toList();

  return Card(
    elevation: 2.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Glycemia Chart of $currentMonth',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          AspectRatio(
            aspectRatio: 1.5,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Color(0xFFC6C6C6),
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: Color(0xFFC6C6C6),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 2,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        final int index = value.toInt();
                        if (index >= 0 && index < data.length) {
                          final DateTime date = data[index].date;
                          final String formattedTime =
                              DateFormat('HH:mm').format(date);
                          return Text(
                            formattedTime,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: const Border(
                    bottom: BorderSide(color: Colors.black),
                    left: BorderSide(color: Colors.black),
                  ),
                ),
                minX: 0,
                maxX: data.length.toDouble() - 1,
                minY: 0,
                maxY: data.map((e) => e.glycemia).reduce((a, b) => a > b ? a : b) + 2,
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: Colors.blue,
                    barWidth: 2,
                    belowBarData: BarAreaData(
                      show: false,
                      color: Colors.blue.withOpacity(0.3),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}



  Widget _buildGlycemiaList() {
    if (data.isEmpty) {
      return _emptyChart();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Glycemia Records:',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              final glycemia = data[index];
              String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(glycemia.date);
              return Card(
                margin: EdgeInsets.symmetric(vertical: 5.0),
                color: Color(0xFFF4EDFF), // Light color for the card
                child: ListTile(
                  title: Text('Rate: ${glycemia.glycemia}'),
                  subtitle: Text('Date: $formattedDate'),
                ),
              );
            },
          ),
        ],
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
    print('Parsing JSON: $json');
    String dateString = json['createdAtFormatted']; // Adjust date parsing as per your backend format
    return GlycemiaData(DateTime.parse(dateString), json['rate'].toDouble());
  }
}















// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:charts_flutter/flutter.dart' as charts;

// class StatsPage extends StatefulWidget {
//   final int patientId;
//   const StatsPage({Key? key, required this.patientId}) : super(key: key);

//   @override
//   _StatsPageState createState() => _StatsPageState();
// }

// class _StatsPageState extends State<StatsPage> {
//   late List<GlycemiaData> data = [];
//   final TextEditingController _glycemiaController = TextEditingController();
//   late double newGlycemiaRate;

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   Future<void> addGlycemiaRecord() async {
//     try {
//       final Uri uri = Uri.parse('http://192.168.1.69:8000/api/glycemia');
//       final http.Response response = await http.post(
//         uri,
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(<String, dynamic>{
//           'medicalRecordId': widget.patientId, 
//           'rate': newGlycemiaRate,
//         }),
//       );

//       if (response.statusCode == 201) {
//         fetchData(); 
//         _glycemiaController.clear();
//       } else {
//         print('Failed to add glycemia record: ${response.statusCode}');
//       }
//     } catch (error) {
//       print('Error adding glycemia record: $error');
//     }
//   }

//   Future<int> fetchMedicalRecordId(int patientId) async {
//     final Uri uri = Uri.parse('http://192.168.1.69:8000/api/medical-record/$patientId');
//     final http.Response response = await http.get(uri);

//     if (response.statusCode == 200) {
//       final dynamic responseData = jsonDecode(response.body);
//       return responseData['medicalRecordId'];
//     } else {
//       throw Exception('Failed to fetch medical record ID');
//     }
//   }

//   Future<void> fetchData() async {
//     try {
//       final Uri uri = Uri.parse('http://192.168.1.69:8000/api/glycemia/${widget.patientId}');
//       final http.Response response = await http.get(uri);

//       if (response.statusCode == 200) {
//         final List<dynamic> responseData = jsonDecode(response.body);
//         setState(() {
//           data = responseData.map((data) => GlycemiaData.fromJson(data)).toList();
//         });
//       } else {
//         print('Failed to fetch glycemia data: ${response.statusCode}');
//       }
//     } catch (error) {
//       print('Error fetching glycemia data: $error');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Glycemia Stats',
//           style: TextStyle(color: Colors.white),
//         ),
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: const LinearGradient(
//               colors: [
//                 Color(0xFFA67CE4),
//                 Color(0xFF5915BD),
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//         ),
//         iconTheme: IconThemeData(
//           color: Colors.white,
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               _buildChart(),
//               const SizedBox(height: 20),
//               TextField(
//                 controller: _glycemiaController,
//                 decoration: InputDecoration(
//                   labelText: 'Enter Glycemia Rate',
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.numberWithOptions(decimal: true),
//                 onChanged: (value) {
//                   newGlycemiaRate = double.tryParse(value) ?? 0.0;
//                 },
//               ),
//               const SizedBox(height: 10),
//               Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                     Color(0xFFA67CE4),
//                     Color(0xFF5915BD),
//                   ],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//               child: Material(
//                 color: Color(0x00FF0B0B),
//                 child: InkWell(
//                   onTap: () {
//                     addGlycemiaRecord();
//                   },
//                   borderRadius: BorderRadius.circular(8.0),
//                   child: Container(
//                     padding: EdgeInsets.symmetric(vertical: 15.0),
//                     child: Center(
//                       child: Text(
//                         'Add Glycemia',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildChart() {
//   if (data.isEmpty) {
//     return _emptyChart();
//   } else {
//     // Preprocess data using aggregation function
//     List<GlycemiaData> aggregatedData = aggregateData(data);

//     final List<charts.Series<GlycemiaData, DateTime>> seriesList = [
//       charts.Series<GlycemiaData, DateTime>(
//         id: 'Glycemia',
//         colorFn: (_, __) => charts.ColorUtil.fromDartColor(const Color(0xFF595DE5)),
//         domainFn: (GlycemiaData glycemia, _) => glycemia.date,
//         measureFn: (GlycemiaData glycemia, _) => glycemia.glycemia,
//         data: aggregatedData, // Use aggregated data
//       ),
//     ];

//     final DateTime minDate = aggregatedData.map((e) => e.date).reduce((value, element) => value.isBefore(element) ? value : element);
//     final DateTime maxDate = aggregatedData.map((e) => e.date).reduce((value, element) => value.isAfter(element) ? value : element);

//     return SizedBox(
//       height: 250,
//       width: MediaQuery.of(context).size.width,
//       child: charts.TimeSeriesChart(
//         seriesList,
//         animate: true,
//         primaryMeasureAxis: const charts.NumericAxisSpec(
//           tickProviderSpec: charts.BasicNumericTickProviderSpec(desiredTickCount: 7),
//         ),
//         domainAxis: charts.DateTimeAxisSpec(
//           renderSpec: charts.SmallTickRendererSpec(
//             labelStyle: charts.TextStyleSpec(color: charts.MaterialPalette.white),
//             lineStyle: charts.LineStyleSpec(color: charts.MaterialPalette.white),
//           ),
//           tickProviderSpec: charts.StaticDateTimeTickProviderSpec(
//             // Specify static time values for ticks (every 4 hours)
//             <charts.TickSpec<DateTime>>[
//               for (int hour = 0; hour < 24; hour += 4)
//                 charts.TickSpec(DateTime(2024, 1, 1, hour)),
//             ],
//           ),
//           tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
//             hour: charts.TimeFormatterSpec(format: 'HH'), // Show hour of the day
//           ),
//           viewport: charts.DateTimeExtents(
//             start: minDate.subtract(const Duration(days: 1)), // Extend the start date by 1 day
//             end: maxDate.add(const Duration(days: 1)), // Extend the end date by 1 day
//           ),
//         ),
//         behaviors: [
//           charts.ChartTitle(
//             'Glycemia Stats',
//             subTitle: 'Date',
//             behaviorPosition: charts.BehaviorPosition.top,
//             titleStyleSpec: charts.TextStyleSpec(color: charts.MaterialPalette.white, fontSize: 12),
//             subTitleStyleSpec: charts.TextStyleSpec(color: charts.MaterialPalette.white, fontSize: 10),
//           ),
//         ],
//       ),
//     );
//   }
// }




//   Widget _emptyChart() {
//     return Container(
//       height: 250,
//       width: double.infinity,
//       child: Center(
//         child: Text(
//           'No glycemia data available',
//           style: TextStyle(
//             color: Colors.grey,
//             fontSize: 16.0,
//           ),
//         ),
//       ),
//     );
//   }

// }

// class GlycemiaData {
//   final DateTime date;
//   final double glycemia;

//   GlycemiaData(this.date, this.glycemia);

//   factory GlycemiaData.fromJson(Map<String, dynamic> json) {
//     String dateString = json['createdAtFormatted'].replaceAll(' PM', '').replaceAll('T', ' ');
//     return GlycemiaData(DateTime.parse(dateString), json['rate'].toDouble());
//   }
// }

// // Function to aggregate data points with similar DateTime values
// List<GlycemiaData> aggregateData(List<GlycemiaData> originalData) {
//   // Map to store aggregated data points with DateTime as the key
//   Map<DateTime, List<double>> aggregatedDataMap = {};

//   // Iterate through the original data and group data points by DateTime
//   for (var dataPoint in originalData) {
//     if (!aggregatedDataMap.containsKey(dataPoint.date)) {
//       aggregatedDataMap[dataPoint.date] = [];
//     }
//     aggregatedDataMap[dataPoint.date]!.add(dataPoint.glycemia);
//   }

//   // Calculate the average value for each DateTime group
//   List<GlycemiaData> aggregatedData = [];
//   aggregatedDataMap.forEach((dateTime, glycemiaList) {
//     double averageGlycemia = glycemiaList.reduce((a, b) => a + b) / glycemiaList.length;
//     aggregatedData.add(GlycemiaData(dateTime, averageGlycemia));
//   });

//   return aggregatedData;
// }