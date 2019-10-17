import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:police_citizen_app/models/report-category.dart';

class ReportCategorySelectionScreen extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey[800], //change your color here
        ),
        title: Text(
          "SELECT REPORT CATEGORY",
          style: TextStyle(color: Colors.grey),
        ),
        backgroundColor: Colors.grey[50],
        brightness: Brightness.light,
        elevation: 0,
      ),
      body: SafeArea(
          child: Column(
        children: categories.map((category) {
          return Expanded(
            child: Container(
              color: category.color,
              child: InkWell(
                onTap: () {
                  print("tapped");
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              category.title,
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              category.description,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      )),
    );
  }
}
