import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:police_citizen_app/screens/home-screen.dart';
import 'package:police_citizen_app/screens/login-screen.dart';
import 'package:police_citizen_app/screens/name-update-screen.dart';
import 'package:police_citizen_app/screens/phone-code-verification-screen.dart';
import 'package:police_citizen_app/screens/sos-description-screen.dart';
import 'package:police_citizen_app/screens/sos-initialization-screen.dart';
import 'package:police_citizen_app/screens/splash-screen.dart';
import 'package:police_citizen_app/screens/terms-and-condition-screen.dart';
import 'package:police_citizen_app/utils/route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: 'Police NG',
        theme: ThemeData(primarySwatch: Colors.indigo),
        initialRoute: Routes.SPLASH_SCREEN,
        routes: {
          Routes.SPLASH_SCREEN: (context) => SplashScreen(),
          Routes.LOGIN_SCREEN: (context) => LoginScreen(),
          Routes.HOME_SCREEN: (context) => HomeScreen(),
          Routes.TERMS_AND_CONDITION_SCREEN: (context) => TermsAndConditionScreen(),
          Routes.PHONE_NUMBER_VERIFICATION_SCREEN: (context) => PhoneCodeVerificationScreen(),
          Routes.NAME_UPDATE_SCREEN: (context) => NameUpdateScreen(),
          Routes.SOS_INITIALIZATION_SCREEN: (context) => SOSInitializationScreen(),
          Routes.SOS_DESCRIPTION_UPDATE_SCREEN: (context) => SOSDescriptionUpdateScreen(),
        },
      ),
    );
  }
}
