import 'dart:convert';

import 'package:police_citizen_app/http/base-resource.dart';
import 'package:police_citizen_app/http/response/base-response.dart';

class ReportResource {
  static const REPORT_CONTEXT_PATH = "/api/v1/reports";

  static void sendSOS(Map<String, dynamic> payload, BaseResponseListener listener) {
    BaseResource.makePostRequest("$REPORT_CONTEXT_PATH/sos", jsonEncode(payload), listener);
  }

  static void updateSOSDescription(int id, String description, BaseResponseListener listener) {
    BaseResource.makePostRequest("$REPORT_CONTEXT_PATH/sos/$id", jsonEncode({'description': description}), listener);
  }

  static void sendQuickReport(Map<String, dynamic> payload, BaseResponseListener listener) {
    BaseResource.makePostRequest("$REPORT_CONTEXT_PATH/quick", jsonEncode(payload), listener);
  }
}
