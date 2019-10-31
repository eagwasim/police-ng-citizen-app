import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WantedListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WantedListState();
  }
}

class WantedPerson {
  String name;
  String image;
  String wantedFor;
  String lastSeen;
  String tag;
  bool reward;
  String posted;

  WantedPerson({this.name, this.wantedFor, this.lastSeen, this.tag, this.reward, this.image, this.posted});
}

class _WantedListState extends State<WantedListScreen> {
  List<WantedPerson> _wantedPersons = [
    WantedPerson(name: "BASHIR OBI", image: "profile_1", wantedFor: "Murder", lastSeen: "Bwari, Abuja", tag: "DANGEROURS", reward: true, posted: "13 SEP 2019"),
    WantedPerson(name: "NAME UNKWOWN", image: "profile_2", wantedFor: "Theft", lastSeen: "Wuse, Abuja", tag: "", reward: false, posted: "14 SEP 2019"),
    WantedPerson(name: "KELECHI ALI", image: "profile_3", wantedFor: "Fraud", lastSeen: "Maitama, Abuja", tag: "", reward: true, posted: "15 SEP 2019"),
    WantedPerson(name: "NAME UNKWOWN", image: "profile_4", wantedFor: "Armed Robbery", lastSeen: "Utako, Abuja", tag: "DANGEROURS", reward: true, posted: "16 SEP 2019")
  ];

  final _states = ['All', 'Dangerous', 'With Reward', 'Male', 'Female'];
  String _selectedState = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey[800], //change your color here
        ),
        title: Text(
          "Wanted List",
          style: TextStyle(color: Colors.grey),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 16.0),
            child: DropdownButton<String>(
              value: _selectedState,
              style: TextStyle(color: Colors.white),
              isExpanded: false,
              items: _states.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: new Text(
                    value,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedState = value;
                });
              },
            ),
          ),
        ],
      ),
      body: ListView(
        children: _wantedPersons.map((wp) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 2, bottom: 2),
            child: Card(
              child: InkWell(
                onTap: (){},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Image.asset("assets/images/${wp.image}.png"),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Posted: ${wp.posted}",
                                    textAlign: TextAlign.end,
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                wp.name,
                                textAlign: TextAlign.start,
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "Wanted For: ${wp.wantedFor}",
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "Last Seen: ${wp.lastSeen}",
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    wp.tag,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(fontSize: 10, backgroundColor: Colors.red, color: Colors.white),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0, top: 8),
                                  ),
                                  wp.reward
                                      ? Image.asset(
                                          "assets/images/reward.png",
                                          height: 15,
                                        )
                                      : Text(""),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Icon(
                                          Icons.chevron_right,
                                          color: Colors.orange,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
