import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EmergencyPhoneLinesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EmergencyPhoneLinesState();
  }
}

class _EmergencyPhoneLinesState extends State<EmergencyPhoneLinesScreen> {
  final _states = ['Abuja FCT', 'Lagos', 'Adamawa', 'Yola'];
  String _selectedState = "Abuja FCT";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey[800], //change your color here
        ),
        centerTitle: false,
        title: Text(
          "Emergency Phone",
          textAlign: TextAlign.start,
          style: TextStyle(color: Colors.grey),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: _selectedState,
              style: TextStyle(color: Colors.white),
              isExpanded: false,
              items: _states.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: new Text(
                    value,
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedState = value;
                });
              },
            ),
          ),
        ],
        backgroundColor: Colors.grey[50],
        brightness: Brightness.light,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildPhoneWidget("08130069408"),
            _buildPhoneWidget("08030069408"),
            _buildPhoneWidget("08130062408"),
            _buildPhoneWidget("08030469408"),
            _buildPhoneWidget("08030069408"),
            _buildPhoneWidget("08030059408"),
            _buildPhoneWidget("09130067408"),
            _buildPhoneWidget("09130069408"),
            _buildPhoneWidget("07130069408"),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneWidget(String phoneNumber) {
    return Padding(
      padding: const EdgeInsets.only(left:8.0, right: 8.0, top: 2.0, bottom: 2.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Text(
                phoneNumber,
                style: TextStyle(fontSize: 20, color: Colors.grey[900]),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.share,
                        color: Colors.teal,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.call,
                        color: Colors.green,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.message,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
