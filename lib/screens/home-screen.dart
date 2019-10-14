import 'package:flutter/material.dart';
import 'package:police_citizen_app/screens/widgets/misc-list-item.dart';
import 'package:police_citizen_app/screens/widgets/ordered-list-item.dart';
import 'package:police_citizen_app/screens/widgets/quick-report-item.dart';

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
                        () {},
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
                        () {},
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
                            callback: () {},
                          ),
                          QuickReportItem(
                            image: "take_photo.png",
                            text: "Send Photo",
                            callback: () {},
                          ),
                          QuickReportItem(
                            image: "record_video.png",
                            text: "Send Video",
                            callback: () {},
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
                  children: <Widget>[
                    MiscListItem(
                      title: "Tip-off",
                      message: "Click on this card to provide information about any suspicious inividual or activities",
                      actionButtonColor: Colors.green[900],
                      actionLabel: "Submit Tip-off",
                      onclick: () {},
                    ),
                    MiscListItem(
                      title: "Accident",
                      message: "Click on this card to report a traffic accident involving you or others, hit&run etc",
                      actionButtonColor: Colors.blue[700],
                      actionLabel: "Report Accident",
                      onclick: () {},
                    ),
                    MiscListItem(
                      title: "Public Offence",
                      message: "Click on this card to report wilding, drug use/possesion, public nuisance, gang activity etc",
                      actionButtonColor: Colors.indigo[500],
                      actionLabel: "Report Public Offence",
                      onclick: () {},
                    ),
                    MiscListItem(
                      title: "Theft/Damages",
                      message: "Click on this card to report property theft, burglary, arson, vandalization",
                      actionButtonColor: Colors.indigo[500],
                      actionLabel: "Theft/Damages",
                      onclick: () {},
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
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
