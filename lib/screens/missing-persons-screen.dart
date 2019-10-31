import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MissingPersonsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MissingPersonsState();
  }
}

class MissingPerson {
  String name;
  String image;
  String description;
  String lastSeen;
  String tag;
  bool reward;
  String posted;

  MissingPerson({this.name, this.description, this.lastSeen, this.tag, this.reward, this.image, this.posted});
}

class MissingItem {
  String name;
  String image;
  String description;
  String lastSeen;
  String tag;
  bool reward;
  String posted;

  MissingItem({this.name, this.description, this.lastSeen, this.tag, this.reward, this.image, this.posted});
}

class _MissingPersonsState extends State<MissingPersonsScreen> {
  var _selectedIndex = 0;

  List<MissingPerson> _missingPersons = [
    MissingPerson(name: "Bamidele Smith", description: "Male | Dark Skin | Age: 37", lastSeen: "Maitama, Abuja", tag: "KIDNAPPED", reward: false, posted: "13/SEP/2019", image: "profile_5"),
    MissingPerson(name: "Janet Nwachukwu", description: "Female | Light Skin | Age: 25", lastSeen: "Gwarinpa, Abuja", tag: "", reward: true, posted: "13/SEP/2019", image: "profile_6"),
  ];

  List<MissingItem> _missingItems = [
    MissingItem(name: "Black Toyota Camry 2008 LE", description: "Reg Number: KJE 349 PE", lastSeen: "Maitama, Abuja", tag: "STOLEN", reward: true, posted: "13/SEP/2019", image: "camry"),
    MissingItem(name: "Silver HP Envy Laptop", description: "Serial Number: 08734GH", lastSeen: "Gwarimpa, Abuja", tag: "STOLEN", reward: true, posted: "13/SEP/2019", image: "no_image"),
    MissingItem(name: "24K Diamond Ring", description: "Sterling Silver Band", lastSeen: "Mabushi, Abuja", tag: "LOST", reward: false, posted: "13/SEP/2019", image: "no_image")
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.grey[800], //change your color here
          ),
          title: Text(
            "Missing Persons/Items",
            style: TextStyle(color: Colors.grey),
          ),
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          elevation: 0,
          bottom: TabBar(
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            indicatorColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.grey[800],
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.category),
                    Text("    ITEMS"),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.account_circle),
                    Text("    PERSONS"),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: _selectedIndex == 0 ? _getMissingItems() : _getMissingPersons(),
      ),
    );
  }

  Widget _getMissingItems() {
    return ListView(
        children: _missingItems.map((wp) {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 2, bottom: 2),
        child: Card(
          child: InkWell(
            onTap: () {},
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
                            wp.description,
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
    }).toList());
  }

  Widget _getMissingPersons() {
    return ListView(
        children: _missingPersons.map((wp) {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 2, bottom: 2),
        child: Card(
          child: InkWell(
            onTap: () {},
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
                            wp.description,
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
    }).toList());
  }
}
