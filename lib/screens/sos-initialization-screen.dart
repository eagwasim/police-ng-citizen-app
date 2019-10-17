import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:police_citizen_app/http/report-resource.dart';
import 'package:police_citizen_app/http/response/base-response.dart';
import 'package:police_citizen_app/utils/route.dart';
import 'package:police_citizen_app/utils/shared-preference-util.dart';
import 'package:police_citizen_app/utils/widget-utils.dart';

class SOSInitializationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SOSInitializationState();
  }
}

class _SOSInitializationState extends State<SOSInitializationScreen> implements BaseResponseListener {
  var _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    if (_isProcessing) {
      return WidgetUtils.getColoredLoaderWidget("Sending SOS!", Colors.red);
    }
    return _buildMainWidget(context);
  }

  Widget _buildMainWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text(
          "SOS",
        ),
        backgroundColor: Colors.red,
        brightness: Brightness.dark,
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: IconButton(
              icon: Icon(Icons.close),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
      body: Container(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "It is prohibited to use SOS service for testing",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Only use this feature in case of emergencies.",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Legal action may be taken if this service is misused",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "ARE YOU IN DISTRESS?",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Card(
                              color: Colors.green[800],
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: InkWell(
                                onTap: () {
                                  _sendSOS();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Column(
                                    children: <Widget>[
                                      Icon(
                                        Icons.check,
                                        size: 60,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "YES. SEND HELP",
                                        style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: FlatButton(
                            child: Text(
                              "SEND REPORT INSTEAD",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {},
                          ),
                        )
                      ],
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

  void _sendSOS() {
    setState(() {
      _isProcessing = true;
    });

    Future<Position> futurePosition = Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    futurePosition.then((position) {
      if (position != null) {
        ReportResource.sendSOS({'lat': position.latitude, 'lon': position.longitude}, this);
      } else {
        setState(() {
          _isProcessing = false;
        });
      }
    });
  }

  @override
  void onResponse(BaseResponse response) {
    setState(() {
      _isProcessing = false;
    });

    if (response.statusCode == 201) {
      Future future = SharedPreferenceUtil.setInt(SharedPreferenceUtil.LATEST_SOS_ID_KEY, jsonDecode(response.data)['data']['sos_id']);
      future.then((_) {
        Navigator.pushReplacementNamed(context, Routes.SOS_DESCRIPTION_UPDATE_SCREEN);
      });
    } else {
      WidgetUtils.showAlertDialog(context, "Error", response.statusMessage);
    }
  }
}
