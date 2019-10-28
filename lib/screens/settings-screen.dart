import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:police_citizen_app/utils/route.dart';
import 'package:police_citizen_app/utils/shared-preference-util.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingState();
  }
}

class _SettingState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey[800], //change your color here
        ),
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.grey),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                "assets/images/citizen_app_logo_with_white.png",
                                height: 100,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "POLICE NG",
                                  style: TextStyle(fontSize: 40, letterSpacing: .1, fontWeight: FontWeight.bold, color: Colors.indigo),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "The Nigerian Police Force",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Copyright 2019",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Version 1.0.0",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    color: Colors.red,
                    onPressed: () {
                      Future f = SharedPreferenceUtil.logout();
                      f.then((_) {
                        Navigator.pushNamedAndRemoveUntil(context, Routes.LOGIN_SCREEN, (route) {
                          return true;
                        });
                      });
                    },
                    child: Text(
                      "LOG OUT",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
