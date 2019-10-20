import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LocatePoliceStationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LocatePoliceStationState();
  }
}

class _LocatePoliceStationState extends State<LocatePoliceStationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey[800], //change your color here
        ),
        title: Text(
          "Locate Police Stations",
          style: TextStyle(color: Colors.grey),
        ),
        backgroundColor: Colors.grey[50],
        brightness: Brightness.light,
        elevation: 0,
      ),
      body: Container(),
    );
  }
}
