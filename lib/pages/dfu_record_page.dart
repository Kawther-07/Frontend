import 'package:flutter/material.dart';


class DFURecordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DFU Record'),
      ),
      body: Center(
        child: Text(
          'DFU Record',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
