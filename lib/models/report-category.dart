import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final allCategories =  [
   ReportCategory(
    title: "Distress",
    description: "Select if you are the one currently experiencing a crime like robbery, domestic violence, assault, rape etc",
    color: Colors.red,
    type: "DISTRESS",
  ),
  ReportCategory(
    title: "Homeland Security",
    description: "Like Kidnap, Hijack,Terrorism, Smuggling,Trafficking in Persons etc",
    color: Colors.orange,
    type: "HOMELAND_SECURITY",
  ),
  ReportCategory(
    title: "Traffic Accident",
    description: "Select this to report an accident that involves you or others. Hit and run, Motor cycle, tri cycle, car, bus etc",
    color: Colors.blue,
    type: "TRAFFIC_ACCIDENT",
  ),
  ReportCategory(
    title: "Violence",
    description: "Like Assault, Harassment, Murder, Wounding/GBH, Armed robbery, Domestic Violence, Sexual offence etc",
    color: Colors.deepPurple[700],
    type: "VIOLENCE",
  ),
  ReportCategory(
    title: "Public Offence",
    description: "Like Possession of weapons to cause fear, Wilding, Public Nuisance / disturbance, Drug use / possession etc",
    color: Colors.indigo,
    type: "PUBLIC_OFFENCE",
  ),
  ReportCategory(
    title: "Citizen's Watch / Tip-off",
    description: "Give info about Wanted persons, Missing persons, Missing Items, Election crimes, Cybercrime, Officer misconduct etc",
    color: Colors.green[700],
    type: "CITIZENS_WATCH_OR_TIP_OFF",
  ),
  ReportCategory(
    title: "Theft and Damages",
    description: "Like Property Theft, Financial theft, Burglary, Looting, Vandalisation, Arson damage etc",
    color: Colors.pink,
    type: "THEFT_AND_DAMAGES",
  ),
  ReportCategory(
    title: "Other",
    description: "Select this if you are not sure of the category or what you wish to report is not listed above",
    color: Colors.indigo[900],
    type: "OTHER",
  ),
];

class ReportCategory {
  final String title;
  final String description;
  final Color color;
  final String type;

  ReportCategory({@required this.title, @required this.description, @required this.color, @required this.type});

  @override
  bool operator ==(Object other) => identical(this, other) || other is ReportCategory && runtimeType == other.runtimeType && type == other.type;

  @override
  int get hashCode => type.hashCode;

  @override
  String toString() {
    return title;
  }
}
