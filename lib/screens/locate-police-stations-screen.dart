import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocatePoliceStationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LocatePoliceStationState();
  }
}

class PoliceStation {
  String name;
  String address;
  String phoneNumber;

  List<double> location;

  PoliceStation({this.name, this.address, this.phoneNumber, this.location});
}

class _LocatePoliceStationState extends State<LocatePoliceStationScreen> {
  final _states = ['Abuja FCT', 'Lagos', 'Adamawa', 'Yola'];
  String _selectedState = "Abuja FCT";
  int _selectedIndex = 0;

  final Set<Marker> _markers = Set();

  final List<PoliceStation> policeStations = [
    PoliceStation(name: "Shaya Police Station", address: "17th Road, Opp. Fha, Gwarinpa, Abuja.", phoneNumber: "08059113555", location: [9.110194, 6.424357]),
    PoliceStation(name: "Divisional HQ, Gwarinpa", address: "Life Camp, Gwarimpa, Abuja.", phoneNumber: "08059113555", location: [9.710194, 7.824357]),
    PoliceStation(name: "Kubwa Police Station", address: "Arab Road, Kubwa, Abuja.", phoneNumber: "095211199", location: [9.410194, 7.624357]),
    PoliceStation(name: "Bwari Police Station", address: "Bwari, Kubwa, Abuja.", phoneNumber: "08075804475", location: [9.310194, 7.924357]),
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
          centerTitle: false,
          title: Text(
            "Find Police Stations",
            style: TextStyle(color: Colors.grey[600]),
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
                    Icon(Icons.list),
                    Text("    LIST VIEW"),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.map),
                    Text("    MAP VIEW"),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Container(
          child: _selectedIndex == 0 ? _buildPoliceStationListView() : _buildPoliceStationMapView(),
        ),
      ),
    );
  }

  Widget _buildPoliceStationListView() {
    return Container(
      child: ListView(
        children: policeStations.map((ps) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0, bottom: 2.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          ps.name,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          ps.address,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          ps.phoneNumber,
                        ),
                        Expanded(
                          child: Text(
                            "1.2km away",
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.call,
                                color: Colors.green,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                              ),
                              Icon(
                                Icons.share,
                                color: Colors.blue,
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: RaisedButton(
                            color: Colors.blue,
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Naviigate",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(
                                  Icons.navigation,
                                  size: 13,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPoliceStationMapView() {
    _markers.clear();
    const LatLng _center = const LatLng(9.110194, 7.424357);
    _markers.addAll(policeStations.map((ps) {
      return Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(ps.phoneNumber),
        position: LatLng(ps.location[0], ps.location[0]),
        infoWindow: InfoWindow(
          title: ps.name,
          snippet: ps.name,
        ),
        icon: BitmapDescriptor.defaultMarker,
      );
    }).toList());

    return Container(
      child: GoogleMap(
        myLocationEnabled: true,
        onMapCreated: (c) async {
          var location = await Geolocator().getCurrentPosition();
          Future.delayed(Duration(seconds: 3), () {
            c.animateCamera(CameraUpdate.newLatLngZoom(LatLng(location.latitude, location.longitude), 15.0));
          });
        },
        markers: _markers,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 9.0,
        ),
      ),
    );
  }
}
