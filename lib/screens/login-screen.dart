import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:police_citizen_app/http/access-resource.dart';
import 'package:police_citizen_app/http/request/access-resource-request.dart';
import 'package:police_citizen_app/http/response/base-response.dart';
import 'package:police_citizen_app/utils/route.dart';
import 'package:police_citizen_app/utils/shared-preference-util.dart';
import 'package:police_citizen_app/utils/validation-utils.dart';
import 'package:police_citizen_app/utils/widget-utils.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<LoginScreen> implements BaseResponseListener {
  bool _isProcessing = false;
  String _phoneNumber = "";
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isProcessing) {
      return WidgetUtils.getLoaderWidget("Sending verification code");
    }
    return _getMainWidget();
  }

  Widget _getMainWidget() {
    _controller = new TextEditingController(text: _phoneNumber);

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
              "Next",
              style: TextStyle(color: Colors.blue[800], fontSize: 20),
            ),
            onPressed: () {
              _handleLogin();
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Your Phone",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      ),
                    )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Please enter your Nigerian phone number for confirmation",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15),
                      ),
                    )),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Nigeria ",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 20),
                      ),
                    )),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Text(
                        "+234",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    VerticalDivider(
                      width: 4,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none, hintText: "Your phone number"),
                        autofocus: true,
                        controller: _controller,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(fontSize: 20),
                        onChanged: (newValue) {
                          _phoneNumber = newValue;
                        },
                      ),
                    )
                  ],
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void onResponse(BaseResponse response) {
    setState(() {
      _isProcessing = false;
    });

    if (response.statusCode == 200) {
      Future future = SharedPreferenceUtil.savePhoneNumberForVerification(_phoneNumber);
      future.then((_) {
        Navigator.pushNamed(context, Routes.PHONE_NUMBER_VERIFICATION_SCREEN);
      });
    } else {
      WidgetUtils.showAlertDialog(context, "Error", response.statusMessage);
    }
  }

  void _handleLogin() {
    if (ValidationUtils.isValidPhoneNumber(_phoneNumber)) {
      setState(() {
        _isProcessing = true;
      });

      if (!_phoneNumber.startsWith("0")) {
        _phoneNumber = "0" + _phoneNumber;
      }

      AccessResource.sendPhoneVerificationCode(SendPhoneVerificationCodeRequest(_phoneNumber), this);
    } else {
      WidgetUtils.showAlertDialog(context, "Error", "Please provide a valid Nigerian number");
    }
  }
}
