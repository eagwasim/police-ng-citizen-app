import 'package:flutter/material.dart';
import 'package:police_citizen_app/models/report-category.dart';
import 'package:police_citizen_app/screens/quick-report-screen.dart';
import 'package:police_citizen_app/screens/widgets/misc-list-item.dart';
import 'package:police_citizen_app/screens/widgets/ordered-list-item.dart';
import 'package:police_citizen_app/screens/widgets/quick-report-item.dart';
import 'package:police_citizen_app/utils/route.dart';
import 'package:police_citizen_app/utils/widget-utils.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          "POLICE NG",
          style: TextStyle(color: Colors.grey),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset("assets/images/citizen_app_logo.png"),
        ),
        backgroundColor: Colors.grey[50],
        brightness: Brightness.light,
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: IconButton(
              icon: Icon(Icons.account_circle),
              color: Colors.grey,
              iconSize: 35,
              onPressed: () {},
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: _buildHeaderWidgets(
                        "SOS",
                        Image.asset(
                          "assets/images/sos.png",
                          width: 60,
                        ),
                        Colors.red,
                        () {
                          Navigator.pushNamed(context, Routes.SOS_INITIALIZATION_SCREEN);
                        },
                      ),
                    ),
                    Expanded(
                      child: _buildHeaderWidgets(
                        "Report",
                        Image.asset(
                          "assets/images/send_report.png",
                          width: 60,
                        ),
                        Colors.indigo,
                        () {
                          Navigator.pushNamed(context, Routes.REPORT_CATEGORY_SELECTION_SCREEN);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text("Quick Report"),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Divider(
                                color: Colors.indigo,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          QuickReportItem(
                            image: "record_audio_1.png",
                            text: "Send Audio",
                            callback: () {
                              WidgetUtils.infoToast("Feature not availiable at this time...");
                            },
                          ),
                          QuickReportItem(
                              image: "take_photo.png",
                              text: "Send Photo",
                              callback: () {
                                _optionsDialogBox(context);
                              }),
                          QuickReportItem(
                            image: "record_video.png",
                            text: "Send Video",
                            callback: () {
                              WidgetUtils.infoToast("Feature not availiable at this time...");
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        OrderedListItem(
                          imageAsset: "emergency_lines.png",
                          textLabel: "Emergency Phone Lines",
                          callback: () {},
                        ),
                        Divider(),
                        OrderedListItem(
                          imageAsset: "locate_stations.png",
                          textLabel: "Locate Police Stations",
                          callback: () {},
                        ),
                        Divider(),
                        OrderedListItem(
                          imageAsset: "most_wanted.png",
                          textLabel: "Wanted List",
                          callback: () {},
                        ),
                        Divider(),
                        OrderedListItem(
                          imageAsset: "missing_items.png",
                          textLabel: "Missing Persons/Items",
                          callback: () {},
                        ),
                        Divider(),
                        OrderedListItem(
                          imageAsset: "notices.png",
                          textLabel: "Public Notices",
                          callback: () {},
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: new Row(
                  children: allCategories.map((value) {
                    return MiscListItem(
                      title: value.title,
                      message: value.description,
                      actionButtonColor: value.color,
                      actionLabel: value.title,
                      onclick: () {
                        Navigator.pushNamed(context, Routes.REPORT_SCREEN, arguments: value);
                      },
                    );
                  }).toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _optionsDialogBox(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: new Text('Take a picture'),
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pop(true);

                      Navigator.pushNamed(
                        context,
                        Routes.QUICK_REPORT_SCREEN,
                        arguments: QuickReportType(
                          type: QuickReportScreen.QUICK_REPORT_TYPE_PHOTO,
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: new Text('Select from gallery'),
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pop(true);
                      Navigator.pushNamed(
                        context,
                        Routes.QUICK_REPORT_SCREEN,
                        arguments: QuickReportType(
                          type: QuickReportScreen.QUICK_REPORT_TYPE_PHOTO_GALLERY,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildHeaderWidgets(String text, Image image, Color color, VoidCallback onclick) {
    return Card(
      color: color,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: image,
            ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Text(
                text,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        onTap: onclick,
      ),
    );
  }
}
