import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:police_citizen_app/http/report-resource.dart';
import 'package:police_citizen_app/http/response/base-response.dart';
import 'package:police_citizen_app/models/report.dart';
import 'package:police_citizen_app/utils/widget-utils.dart';
import 'package:time_formatter/time_formatter.dart';

class ReportsHistoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ReportsHistoryState();
  }
}

class _ReportsHistoryState extends State<ReportsHistoryScreen> implements BaseResponseListener {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final List<CitizensReport> _reports = [];
  Completer<Null> completer;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      _refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey[800], //change your color here
        ),
        title: Text(
          "Reports History",
          style: TextStyle(color: Colors.grey),
        ),
        backgroundColor: Colors.grey[50],
        brightness: Brightness.light,
        elevation: 0,
      ),
      body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refresh,
          child: ListView(
              children: _reports.map((report) {
            return _fromReport(report);
          }).toList())),
    );
  }

  Future<void> _refresh() {
    _refreshIndicatorKey.currentState.show();
    ReportResource.getUserReport(this);
    completer = new Completer();

    return completer.future;
  }

  @override
  void onResponse(BaseResponse response) {
    completer.complete();

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.data);
      setState(() {
        _reports.clear();
        _reports.addAll(List<CitizensReport>.from(data['data'].map((r) => CitizensReport.fromJson(r)).toList()));
      });
    } else {
      setState(() {
        WidgetUtils.errorToast(response.statusMessage);
      });
    }
  }

  Widget _fromReport(CitizensReport report) {
    double c_width = MediaQuery.of(context).size.width*0.8;

    return Padding(
      padding: const EdgeInsets.only(top: 2.0, bottom: 2.0, left: 8.0, right: 8.0),
      child: Card(
        elevation: 2,
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'REF: ${report.id}',
                      style: TextStyle(color: Colors.green, fontSize: 12),
                    ),
                    Expanded(
                        child: Text(
                      '${formatTime(DateTime.parse(report.dateCreated).millisecondsSinceEpoch)}',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ))
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        report.title.toUpperCase(),
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.indigo[800]),
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Container(
                        width: c_width,
                        child: Text(
                          report.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    (report.keepAnonymous
                        ? Padding(
                            padding: const EdgeInsets.only(top: 4.0, right: 8),
                            child: Text(
                              'ANNONYMOUS',
                              style: TextStyle(
                                color: Colors.white,
                                backgroundColor: Colors.green,
                                letterSpacing: 1,
                                fontSize: 10,
                              ),
                            ),
                          )
                        : Text('')),
                    (report.media.isEmpty
                        ? Text('')
                        : Icon(
                            Icons.attachment,
                            color: Colors.green,
                          )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
