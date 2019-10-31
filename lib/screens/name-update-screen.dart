import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:police_citizen_app/http/response/base-response.dart';
import 'package:police_citizen_app/http/user-resource.dart';
import 'package:police_citizen_app/models/user.dart';
import 'package:police_citizen_app/utils/route.dart';
import 'package:police_citizen_app/utils/shared-preference-util.dart';
import 'package:police_citizen_app/utils/widget-utils.dart';

class NameUpdateScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NameUpdateState();
  }
}

class _NameUpdateState extends State<NameUpdateScreen> implements BaseResponseListener {
  var _isProcessing = false;
  var _fullName = "";
  var _email = "";
  var _gender = "";

  User _user;

  TextEditingController _controller;
  TextEditingController _emailController;
  TextEditingController _genderController;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _emailController.dispose();
    _genderController.dispose();
  }

  @override
  void initState() {
    super.initState();

    Future future = SharedPreferenceUtil.currentUser();

    future.then((user) {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isProcessing ? WidgetUtils.getLoaderWidget("Saving...") : _buildWidget();
  }

  Widget _buildWidget() {
    _controller = new TextEditingController(
      text: _fullName,
    );
    _emailController = new TextEditingController(text: _email);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset("assets/images/citizen_app_logo.png"),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0,
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Done",
              style: TextStyle(color: Colors.blue[800], fontSize: 20),
            ),
            onPressed: () {
              _doNameUpdate();
            },
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Last        First",
                hintStyle: TextStyle(
                  color: Colors.indigo[200],
                ),
              ),
              autofocus: true,
              controller: _controller,
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 30),
              onChanged: (newValue) {
                _fullName = newValue;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Please enter your full name",
              style: TextStyle(fontSize: 12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Email Address",
                hintStyle: TextStyle(
                  color: Colors.indigo[200],
                ),
              ),
              autofocus: true,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(fontSize: 30),
              onChanged: (newValue) {
                _email = newValue;
              },
              onSubmitted: (value) {
                _email = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Please enter your email",
              style: TextStyle(fontSize: 12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Gender (Male | Female)",
                hintStyle: TextStyle(
                  color: Colors.indigo[200],
                ),
              ),
              autofocus: true,
              controller: _genderController,
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 30),
              onChanged: (newValue) {
                _gender = newValue;
              },
              onSubmitted: (value) {
                _gender = value;
                _doNameUpdate();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Please enter your gender (male or female)",
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  void _doNameUpdate() {
    List<String> fullName = _fullName.split(" ");

    if (fullName.length != 2 ||
        fullName[0].length < 3 ||
        fullName[1].length < 3 ||
        !_email.contains("@") ||
        _email.length < 3 ||
        !(_gender.toLowerCase() == "male" || _gender.toLowerCase() == "female")) {
      WidgetUtils.showAlertDialog(context, "Error", "Enter a valid first name and last name");
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    User tempUser = User(firstName: fullName[1], lastName: fullName[0], emailAddress: _email);

    UserResource.updateUserDetails(tempUser, this);
  }

  @override
  void onResponse(BaseResponse response) {
    setState(() {
      _isProcessing = false;
    });

    if (response.statusCode == 200) {
      List<String> fullName = _fullName.split(RegExp(" "));

      _user.firstName = fullName[1];
      _user.lastName = fullName[0];
      _user.emailAddress = _email;
      _user.gender = _gender;

      Future future = SharedPreferenceUtil.saveUser(_user);
      future.then((_) {
        Navigator.pushNamedAndRemoveUntil(context, Routes.HOME_SCREEN, (Route<dynamic> route) => false);
      });
    } else {
      WidgetUtils.showAlertDialog(context, "Error", response.statusMessage);
    }
  }
}
