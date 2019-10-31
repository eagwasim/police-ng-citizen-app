import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PublicNoticeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PublicNoticeState();
  }
}

class _PublicNoticeState extends State<PublicNoticeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey[800], //change your color here
        ),
        title: Text(
          "Public Notice",
          style: TextStyle(color: Colors.grey),
        ),
        backgroundColor: Colors.grey[50],
        brightness: Brightness.light,
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          " HIGH ALERT ",
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white, backgroundColor: Colors.red),
                        ),
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "21 mins ago",
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "SHIITE VIOLENT PROTEST IN ABUJA",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.indigo[800]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "Abuja residents are advised to avoid Wuse 2 areas around Bannex Plaza and Maitama areas around Transcorp Hilton today the 21st of September 2019 as there are reports of ..."),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          " HIGH ALERT ",
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white, backgroundColor: Colors.red),
                        ),
                      ),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "40 mins ago",
                              textAlign: TextAlign.end,
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "ROBBERY AT ZENITH BANK, KARU",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.indigo[800]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "Lorem Ipsum dolor seit amet must gain another lorem ipsum dolor seit amet wey dey sit for inside lorem ipsum dolor seit amet that always lorem ipsum dolor seit amet..."),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
