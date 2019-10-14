import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oktoast/oktoast.dart';
import 'package:police_citizen_app/http/report-resource.dart';
import 'package:police_citizen_app/http/response/base-response.dart';
import 'package:police_citizen_app/utils/shared-preference-util.dart';
import 'package:police_citizen_app/utils/widget-utils.dart';

class SOSDescriptionUpdateScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SOSDescriptionUpdateState();
  }
}

class _SOSDescriptionUpdateState extends State<SOSDescriptionUpdateScreen> implements BaseResponseListener {
  var _isProcessing = false;
  var _description = "";

  TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return _isProcessing ? WidgetUtils.getColoredLoaderWidget("Updating SOS", Colors.red) : _buildMainWidget(context);
  }

  Widget _buildMainWidget(BuildContext context) {
    _controller = new TextEditingController(
      text: _description,
    );

    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text(
          "SOS",
        ),
        backgroundColor: Colors.red,
        brightness: Brightness.dark,
        elevation: 0,
      ),
      body: Container(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.check,
                          size: 60,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "SOS Request Sent!",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Please provide more description of your emergency",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
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
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Description (min 10 chars)",
                                  hintStyle: TextStyle(
                                    color: Colors.indigo[200],
                                  ),
                                ),
                                keyboardType: TextInputType.multiline,
                                style: TextStyle(fontSize: 20),
                                minLines: 3,
                                maxLines: 5,
                                controller: _controller,
                                onChanged: (newValue) {
                                  _description = newValue;
                                },
                              ),
                            ),
                          ),
                        ))
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: RaisedButton(
                              color: Colors.green[700],
                              onPressed: () {
                                _updateSOSDescription();
                              },
                              child: Text(
                                "UPDATE SOS",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateSOSDescription() {
    if (_description.length < 5) {
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    Future<int> future = SharedPreferenceUtil.getInt(SharedPreferenceUtil.LATEST_SOS_ID_KEY, 0);

    future.then((value) {
      ReportResource.updateSOSDescription(value, _description, this);
    });
  }

  @override
  void onResponse(BaseResponse response) {
    setState(() {
      _isProcessing = false;
    });

    if (response.statusCode == 200) {
      showToast(
        'SOS Description Updated!',
        duration: Duration(seconds: 3),
        position: ToastPosition.center,
        backgroundColor: Colors.yellow[800],
        radius: 5.0,
        textStyle: TextStyle(fontSize: 16.0, color: Colors.black),
      );
      Navigator.pop(context);
    } else {
      WidgetUtils.showAlertDialog(context, "Error", response.statusMessage);
    }
  }
}
