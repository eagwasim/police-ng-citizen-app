import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EmergencyPhoneLinesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EmergencyPhoneLinesState();
  }
}

class _EmergencyPhoneLinesState extends State<EmergencyPhoneLinesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey[800], //change your color here
        ),
        title: Text(
          "Emergency Phone Lines",
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
