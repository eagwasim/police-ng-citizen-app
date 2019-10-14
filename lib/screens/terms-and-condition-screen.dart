import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:police_citizen_app/utils/navigation-utils.dart';
import 'package:police_citizen_app/utils/shared-preference-util.dart';
import 'package:police_citizen_app/utils/widget-utils.dart';

class TermsAndConditionScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TermsAndConditionState();
  }
}

class _TermsAndConditionState extends State<TermsAndConditionScreen> {
  final languages = ['English', 'Igbo', 'Yoruba', 'Hausa'];
  String _selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: WidgetUtils.getLightGradientBackground(),
        child: SafeArea(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Image.asset(
              "assets/images/citizen_app_logo_with_white.png",
              width: 100.0,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "POLICE NG",
                style: TextStyle(fontSize: 20, letterSpacing: .1, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: DropdownButton<String>(
                icon: Icon(Icons.language),
                value: _selectedLanguage,
                style: TextStyle(color: Colors.white),
                isExpanded: true,
                items: languages.map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(
                      value,
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedLanguage = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<Map<String, dynamic>>(
                future: _getLanguageText(), // a previously-obtained Future<String> or null
                builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text('');
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                      return Text('Loading...');
                    case ConnectionState.done:
                      if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                      return Column(
                        children: <Widget>[
                          Html(data: snapshot.data["main"]),
                          Padding(
                            padding: EdgeInsets.all(16),
                          ),
                          Text(
                            snapshot.data["emphasized"],
                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                          )
                        ],
                      );
                  }
                  return null;
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          child: Text("I AGREE"),
                          color: Colors.yellow[600],
                          onPressed: () async {
                            await SharedPreferenceUtil.setBool(SharedPreferenceUtil.TERMS_AND_CONDITIONS_ACCEPTED_KEY, true);
                            String nextRoute = await NavigationUtils.getInitialAppRoute();
                            Navigator.pushNamedAndRemoveUntil(context, nextRoute, (Route<dynamic> route) => false);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> _getLanguageText() async {
    return jsonDecode(await DefaultAssetBundle.of(context).loadString("assets/message/$_selectedLanguage.json"))['t_and_c'];
  }
}
