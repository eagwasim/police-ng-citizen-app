import 'dart:convert';

import 'package:police_citizen_app/http/base-resource.dart';
import 'package:police_citizen_app/http/response/base-response.dart';

class ReportResource {
  static const USER_CONTEXT_PATH = "/api/v1/reports";

  static void sendSOS(Map<String, dynamic> payload, BaseResponseListener listener) {
    BaseResource.makePostRequest("$USER_CONTEXT_PATH/sos", jsonEncode(payload), listener);
  }

  static void updateSOSDescription(int id, String description, BaseResponseListener listener) {
    BaseResource.makePostRequest("$USER_CONTEXT_PATH/sos/$id", jsonEncode({'description': description}), listener);
  }
}
