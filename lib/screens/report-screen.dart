import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:police_citizen_app/models/report-category.dart';
import 'package:police_citizen_app/utils/widget-utils.dart';

class ReportScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ReportState();
  }
}

class _ReportState extends State<ReportScreen> {
  static final categories = [
    ReportCategory(
      title: "Distress",
      description: "Select if you are the one currently experiencing a crime like robbery, domestic violence, assault, rape etc",
      color: Colors.red,
    ),
    ReportCategory(
      title: "Homeland Security",
      description: "Like Kidnap, Hijack,Terrorism, Smuggling,Trafficking in Persons etc",
      color: Colors.orange,
    ),
    ReportCategory(
      title: "Traffic Accident",
      description: "Select this to report an accident that involves you or others. Hit and run, Motor cycle, tri cycle, car, bus etc",
      color: Colors.blue,
    ),
    ReportCategory(
      title: "Violence",
      description: "Like Assault, Harassment, Murder, Wounding/GBH, Armed robbery, Domestic Violence, Sexual offence etc",
      color: Colors.deepPurple[700],
    ),
    ReportCategory(
      title: "Public Offence",
      description: "Like Possession of weapons to cause fear, Wilding, Public Nuisance / disturbance, Drug use / possession etc",
      color: Colors.indigo,
    ),
    ReportCategory(
      title: "Citizen’s Watch / Tip-off",
      description: "Give info about Wanted persons, Missing persons, Missing Items, Election crimes, Cybercrime, Officer misconduct etc",
      color: Colors.green[700],
    ),
    ReportCategory(
      title: "Theft and Damages",
      description: "Like Property Theft, Financial theft, Burglary, Looting, Vandalisation, Arson damage etc",
      color: Colors.pink,
    ),
    ReportCategory(
      title: "Other",
      description: "Select this if you are not sure of the category or what you wish to report is not listed above",
      color: Colors.indigo[900],
    ),
  ];

  var _isProcessing = false;
  var _selectedCategory;
  var _reportDescripton;
  var _reportAnon = false;
  var _contactMe = false;

  @override
  Widget build(BuildContext context) {
    if (_selectedCategory == null) {
      _selectedCategory = ModalRoute.of(context).settings.arguments;
    }

    return _isProcessing ? WidgetUtils.getLoaderWidget("Sending Report...") : _buildWidget(context);
  }

  Widget _buildWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey[800], //change your color here
        ),
        title: Text(
          "SEND REPORT",
          style: TextStyle(color: Colors.grey),
        ),
        backgroundColor: Colors.grey[50],
        brightness: Brightness.light,
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: IconButton(
              icon: Icon(Icons.send),
              color: Colors.blue,
              onPressed: () {},
            ),
          )
        ],
      ),
      body: SafeArea(child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildCategoryWidget(),
          ),
        ],
      )),
    );
  }

  Widget _buildCategoryWidget() {
    return DropdownButton<ReportCategory>(
      value: _selectedCategory,
      style: TextStyle(
        fontSize: 10
      ),
      isDense: false,
      items: categories.map((category) {
        return DropdownMenuItem<ReportCategory>(
          value: category,
          child: Container(
            color: category.color,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      category.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      category.description,
                      style: TextStyle(fontSize: 8),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
      onChanged: (value) {
        this._selectedCategory = value;
      },
    );
  }
}
