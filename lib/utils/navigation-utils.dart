import 'package:police_citizen_app/models/user.dart';
import 'package:police_citizen_app/utils/route.dart';
import 'package:police_citizen_app/utils/shared-preference-util.dart';

class NavigationUtils {
  static Future<String> getInitialAppRoute() async {
    bool hasAcceptedTerms = await SharedPreferenceUtil.getBool(SharedPreferenceUtil.TERMS_AND_CONDITIONS_ACCEPTED_KEY, false);

    if (!hasAcceptedTerms) {
      return Routes.TERMS_AND_CONDITION_SCREEN;
    } else {
      User user = await SharedPreferenceUtil.currentUser();
      if (user == null) {
        return Routes.LOGIN_SCREEN;
      } else if (user.firstName == null || user.emailAddress == null) {
        return Routes.NAME_UPDATE_SCREEN;
      } else {
        return Routes.HOME_SCREEN;
      }
    }
  }
}
