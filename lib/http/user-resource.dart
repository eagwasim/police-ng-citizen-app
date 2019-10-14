import 'dart:convert';

import 'package:police_citizen_app/http/base-resource.dart';
import 'package:police_citizen_app/http/response/base-response.dart';
import 'package:police_citizen_app/models/user.dart';

class UserResource {
  static const USER_CONTEXT_PATH = "/api/v1/users";

  static void updateUserDetails(User user, BaseResponseListener listener) {
    BaseResource.makePostRequest("$USER_CONTEXT_PATH", jsonEncode(user.toJson()), listener);
  }
}
