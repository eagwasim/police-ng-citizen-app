import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MissingPersonsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MissingPersonsState();
  }
}

class _MissingPersonsState extends State<MissingPersonsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey[800], //change your color here
        ),
        title: Text(
          "Missing Persons/Items",
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
