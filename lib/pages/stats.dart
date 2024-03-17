import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'patient_profile_page.dart';
import 'components/my_button.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardPage(),
    );
  }
}

class DashboardPage extends StatelessWidget {
  final List<GlycemiaData> data = [
    GlycemiaData(DateTime(2024, 2, 1), 100),
    GlycemiaData(DateTime(2024, 2, 2), 170),
    GlycemiaData(DateTime(2024, 2, 3), 115),
    GlycemiaData(DateTime(2024, 2, 4), 78),
    GlycemiaData(DateTime(2024, 2, 5), 84),
    GlycemiaData(DateTime(2024, 2, 6), 105),
    GlycemiaData(DateTime(2024, 2, 7), 120),
    GlycemiaData(DateTime(2024, 2, 8), 59),
    GlycemiaData(DateTime(2024, 2, 9), 135),
    GlycemiaData(DateTime(2024, 2, 10), 140),
    GlycemiaData(DateTime(2024, 2, 11), 114),
    GlycemiaData(DateTime(2024, 2, 12), 132),
    GlycemiaData(DateTime(2024, 2, 13), 101),
    GlycemiaData(DateTime(2024, 2, 14), 117),
    GlycemiaData(DateTime(2024, 2, 15), 105),
    GlycemiaData(DateTime(2024, 2, 16), 91),
    GlycemiaData(DateTime(2024, 2, 17), 130),
    GlycemiaData(DateTime(2024, 2, 18), 185),
    GlycemiaData(DateTime(2024, 2, 19), 130),
    GlycemiaData(DateTime(2024, 2, 20), 70),
    GlycemiaData(DateTime(2024, 2, 21), 105),
    GlycemiaData(DateTime(2024, 2, 22), 67),
    GlycemiaData(DateTime(2024, 2, 23), 122),
    GlycemiaData(DateTime(2024, 2, 24), 110),
    GlycemiaData(DateTime(2024, 2, 25), 144),
    GlycemiaData(DateTime(2024, 2, 26), 118),
    GlycemiaData(DateTime(2024, 2, 27), 137),
    GlycemiaData(DateTime(2024, 2, 28), 61),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
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

            // MyButton( 
            //   onTap: () {
            //     // Navigator.push(
            //     //   context,
            //     //   MaterialPageRoute(builder: (context) => ProfilePage()),
            //     // );
            //   },
            //   text: 'Go to Profile',
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildChart() {
    final seriesList = [
      charts.Series<GlycemiaData, DateTime>(
        id: 'Glycemia',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(const Color(0xFF595DE5)),
        domainFn: (GlycemiaData glycemia, _) => glycemia.date,
        measureFn: (GlycemiaData glycemia, _) => glycemia.glycemia,
        data: data,
      ),
    ];

    return charts.TimeSeriesChart(
      seriesList,
      animate: true,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }
}

class GlycemiaData {
  final DateTime date;
  final double glycemia;

  GlycemiaData(this.date, this.glycemia);

}


// class ProfilePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile'),
//       ),
//       body: const Center(
//         child: Text('Profile Page'),
//       ),
//     );
//   }
// }

