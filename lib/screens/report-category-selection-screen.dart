import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:police_citizen_app/models/report-category.dart';
import 'package:police_citizen_app/utils/route.dart';

class ReportCategorySelectionScreen extends StatelessWidget {
  static final categories = allCategories;

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
          child: ListView(
        children: categories.map((category) {
          return Container(
            color: category.color,
            child: InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, Routes.REPORT_SCREEN, arguments: category);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
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
                          padding: const EdgeInsets.all(8.0),
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
          );
        }).toList(),
      )),
    );
  }
}
