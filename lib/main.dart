import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:police_citizen_app/screens/audio-capture-screen.dart';
import 'package:police_citizen_app/screens/emergency-phone-lines-screen.dart';
import 'package:police_citizen_app/screens/home-screen.dart';
import 'package:police_citizen_app/screens/image-capture-screen.dart';
import 'package:police_citizen_app/screens/locate-police-stations-screen.dart';
import 'package:police_citizen_app/screens/login-screen.dart';
import 'package:police_citizen_app/screens/missing-persons-screen.dart';
import 'package:police_citizen_app/screens/name-update-screen.dart';
import 'package:police_citizen_app/screens/phone-code-verification-screen.dart';
import 'package:police_citizen_app/screens/public-notice-screen.dart';
import 'package:police_citizen_app/screens/quick-report-screen.dart';
import 'package:police_citizen_app/screens/report-category-selection-screen.dart';
import 'package:police_citizen_app/screens/report-screen.dart';
import 'package:police_citizen_app/screens/sos-description-screen.dart';
import 'package:police_citizen_app/screens/sos-initialization-screen.dart';
import 'package:police_citizen_app/screens/splash-screen.dart';
import 'package:police_citizen_app/screens/terms-and-condition-screen.dart';
import 'package:police_citizen_app/screens/video-capture-screen.dart';
import 'package:police_citizen_app/screens/wanted-list-screen.dart';
import 'package:police_citizen_app/utils/route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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
          Routes.AUDIO_CAPTURE_SCREEN: (context) => AudioCaptureScreen(),
          Routes.EMERGENCY_PHONE_LINES_SCREEN: (context) => EmergencyPhoneLinesScreen(),
          Routes.IMAGE_CAPTURE_SCREEN: (context) => ImageCaptureScreen(),
          Routes.LOCATE_POLICE_STATION_SCREEN: (context) => LocatePoliceStationScreen(),
          Routes.MISSING_PERSONS_SCREEN: (context) => MissingPersonsScreen(),
          Routes.PUBLIC_NOTICE_SCREEN: (context) => PublicNoticeScreen(),
          Routes.QUICK_REPORT_SCREEN: (context) => QuickReportScreen(),
          Routes.REPORT_SCREEN: (context) => ReportScreen(),
          Routes.VIDEO_CAPTURE_SCREEN: (context) => VideoCaptureScreen(),
          Routes.WANTED_LIST_SCREEN: (context) => WantedListScreen(),
          Routes.REPORT_CATEGORY_SELECTION_SCREEN: (context) => ReportCategorySelectionScreen(),
        },
      ),
    );
  }
}
