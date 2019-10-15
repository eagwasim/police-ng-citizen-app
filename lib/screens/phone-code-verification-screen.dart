import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code_input/flutter_verification_code_input.dart';
import 'package:police_citizen_app/http/access-resource.dart';
import 'package:police_citizen_app/http/request/access-resource-request.dart';
import 'package:police_citizen_app/http/response/base-response.dart';
import 'package:police_citizen_app/models/user.dart';
import 'package:police_citizen_app/utils/navigation-utils.dart';
import 'package:police_citizen_app/utils/shared-preference-util.dart';
import 'package:police_citizen_app/utils/widget-utils.dart';

class PhoneCodeVerificationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PhoneCodeVerificationState();
  }
}

class _PhoneCodeVerificationState extends State implements BaseResponseListener {
  String _phoneForVerification = "";
  String _verificationCode = "";

  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();

    Future<String> future = SharedPreferenceUtil.getPhoneNumberForVerification();

    future.then((value) {
      _phoneForVerification = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isProcessing) {
      return WidgetUtils.getLoaderWidget("Verifying your phone number, please wait...");
    }
    return _buildWidget();
  }

  Widget _buildWidget() {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Image.asset("assets/images/citizen_app_logo.png"),
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.indigo, //change your color here
          ),
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
                          "Phone Verification",
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
                          "An 6 digit code has been sent to your phone number, please enter the code below",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15),
                        ),
                      )),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                  ),
                  Center(
                    child: VerificationCodeInput(
                      keyboardType: TextInputType.number,
                      length: 6,
                      autofocus: true,
                      onCompleted: (String value) {
                        _verificationCode = value;
                        _verifyPhoneNumber();
                        setState(() {
                          _isProcessing = true;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  @override
  void onResponse(BaseResponse response) {
    if (response.statusCode == 201) {
      Future<void> future = () async {
        Map<String, dynamic> decodedResponse = jsonDecode(response.data);

        User user = User.fromJson(decodedResponse["user"]);
        String token = decodedResponse["token"];

        await SharedPreferenceUtil.saveToken(token);
        await SharedPreferenceUtil.saveUser(user);
      }();

      future.then((_) async {
        Navigator.pushNamedAndRemoveUntil(context, await NavigationUtils.getInitialAppRoute(), (Route<dynamic> route) => false);
      });
    } else {
      setState(() {
        _isProcessing = false;
      });
      WidgetUtils.showAlertDialog(context, "Error", response.statusMessage);
    }
  }

  void _verifyPhoneNumber() {
    AccessResource.verifyPhoneNumber(
      VerifyPhoneNumberRequest(
        phoneNumber: _phoneForVerification,
        verificationCode: _verificationCode,
      ),
      this,
    );
  }
}
