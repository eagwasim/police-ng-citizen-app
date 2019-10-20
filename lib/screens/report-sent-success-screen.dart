import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:police_citizen_app/http/report-resource.dart';
import 'package:police_citizen_app/http/response/base-response.dart';
import 'package:police_citizen_app/utils/widget-utils.dart';

class ReportSentSuccessScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ReportSentSuccessState();
  }
}

class _ReportSentSuccessState extends State<ReportSentSuccessScreen> implements BaseResponseListener {
  int _reportReference;
  String _reportUpdate;

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    if (_reportReference == null) {
      _reportReference = ModalRoute.of(context).settings.arguments;
    }

    return _isProcessing ? WidgetUtils.getLoaderWidget("Sending update...") : _buildWidget(context);
  }

  Widget _buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey[800], //change your color here
        ),
        title: Text(
          "Report Sent!",
          style: TextStyle(color: Colors.grey),
        ),
        backgroundColor: Colors.grey[50],
        brightness: Brightness.light,
        elevation: 0,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "assets/images/success_1.png",
                        width: 100.0,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Report sent successfully!",
                          style: TextStyle(fontSize: 20, color: Colors.green[700]),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "iReport ID: $_reportReference",
                          style: TextStyle(fontSize: 12, color: Colors.indigo[700]),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "You can add follow up information by clicking the reference number above or by going to “My Reports” section via the app menu.",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Please note that reports sent via this means are for quick response and submission of evidence. You should proceed to the nearest police station to provide an official statement at your earliest convenience (especially for cases of theft, robbery, sexual offence and abuse of power).",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _sendReportUpdate() async {
    if (_reportUpdate.length < 10) {
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    ReportResource.sendReportUpdate("$_reportReference", {'update': _reportUpdate}, this);
  }

  @override
  void onResponse(BaseResponse response) {
    if (response.statusCode == 200) {
      WidgetUtils.successToast("Update Sent!");
      _reportUpdate = "";
    } else {
      WidgetUtils.errorToast("Update Sending Failed!");
    }
    setState(() {
      _isProcessing = false;
    });
  }
}
