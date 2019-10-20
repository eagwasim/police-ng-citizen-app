import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:police_citizen_app/http/response/base-response.dart';
import 'package:police_citizen_app/http/user-resource.dart';
import 'package:police_citizen_app/models/user.dart';
import 'package:police_citizen_app/utils/shared-preference-util.dart';
import 'package:police_citizen_app/utils/widget-utils.dart';

class ProfileUpdateScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileUpdateState();
  }
}

class _ProfileUpdateState extends State<ProfileUpdateScreen> implements BaseResponseListener {
  var _isProcessing = false;
  User user;

  final _bvnController = TextEditingController();
  final _ninController = TextEditingController();
  final _houseController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _bvnController.dispose();
    _ninController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      Future<User> future = SharedPreferenceUtil.currentUser();
      future.then((_user) {
        setState(() {
          user = _user;
          _bvnController.text = user.bvn == null ? "" : user.bvn;
          _ninController.text = user.nin == null ? "" : user.nin;
          _houseController.text = user.houseAddress == null ? "" : user.houseAddress;
        });
      });
    }
    return user == null ? WidgetUtils.getLoaderWidget("Loading...") : _isProcessing ? WidgetUtils.getLoaderWidget("Updating profile...") : _build(context);
  }

  Widget _build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Account",
          style: TextStyle(color: Colors.grey),
        ),
        backgroundColor: Colors.grey[50],
        brightness: Brightness.light,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.grey[800], //change your color here
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: IconButton(
              icon: Icon(Icons.save),
              color: Colors.blueGrey,
              onPressed: () {
                _updateUser();
              },
            ),
          )
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "" + user.firstName + " " + user.lastName,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "" + user.phoneNumber,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "" + user.emailAddress,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _bvnController,
                          textAlign: TextAlign.start,
                          decoration: new InputDecoration(
                            labelText: "BVN",
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                              borderSide: new BorderSide(),
                            ),
                            //fillColor: Colors.green
                          ),
                          validator: (val) {
                            if (val.length != 11) {
                              return "BVN Cannot Be less than 11";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _ninController,
                          textAlign: TextAlign.start,
                          decoration: new InputDecoration(
                            labelText: "NIN",
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                              borderSide: new BorderSide(),
                            ),
                            //fillColor: Colors.green
                          ),
                          validator: (val) {
                            if (val.length != 11) {
                              return "NIN Cannot Be less than 11";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _houseController,
                          textAlign: TextAlign.start,
                          decoration: new InputDecoration(
                            labelText: "House Address",
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                              borderSide: new BorderSide(),
                            ),
                            //fillColor: Colors.green
                          ),
                          validator: (val) {
                            if (val.length < 3) {
                              return "House Address Cannot Be less 3 characters";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _updateUser() async {
    user.bvn = _bvnController.text;
    user.nin = _ninController.text;
    user.houseAddress = _houseController.text;

    UserResource.updateUserDetails(user, this);

    setState(() {
      _isProcessing = true;
    });
  }

  @override
  void onResponse(BaseResponse response) {
    if (response.statusCode == 200) {
      Future<void> f = SharedPreferenceUtil.saveUser(user);
      f.then((_) {
        WidgetUtils.successToast("Details Updated");
        setState(() {
          _isProcessing = false;
        });
      });
    } else {
      setState(() {
        _isProcessing = false;
      });
      WidgetUtils.errorToast("Update failed... ");
    }
  }
}
