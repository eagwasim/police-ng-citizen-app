import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:police_citizen_app/http/response/base-response.dart';
import 'package:police_citizen_app/utils/shared-preference-util.dart';

abstract class BaseResource {
  static const BASE_URL = "https://police-ng.appspot.com";

  static void makePostRequest(String url, String data, BaseResponseListener listener) {
    Map<String, String> headers;

    Future<String> authToken = SharedPreferenceUtil.getToken();

    authToken.then((token) {
      if (token != null) {
        headers = {"Content-type": "application/json", "Authorization": "Bearer $token"};
      } else {
        headers = {"Content-type": "application/json"};
      }

      Future<http.Response> futureResponse = http.post(
        BASE_URL + url,
        headers: headers,
        body: data,
      );

      futureResponse.then((resp) {
        String responseBody = resp.body;
        String errorMessage;

        if (responseBody != null) {
          try {
            Map<String, dynamic> payload = jsonDecode(errorMessage);
            errorMessage = payload.containsKey("message") ? payload['message'] : null;
          } catch (e) {}
        }
        listener.onResponse(
          BaseResponse(
            statusCode: resp.statusCode,
            statusMessage: errorMessage == null ? resp.reasonPhrase : errorMessage,
            data: responseBody,
          ),
        );
      }, onError: (error) {
        listener.onResponse(BaseResponse(
          statusCode: 500,
          statusMessage: "Could not process your request, check your internet connection",
          data: null,
        ));
      });
    });
  }

  static void makePutRequest(String url, String data, BaseResponseListener listener) {
    Map<String, String> headers;

    Future<String> authToken = SharedPreferenceUtil.getToken();

    authToken.then((token) {
      if (token != null) {
        headers = {"Content-type": "application/json", "Authorization": "Bearer $token"};
      } else {
        headers = {"Content-type": "application/json"};
      }

      Future<http.Response> futureResponse = http.put(
        BASE_URL + url,
        headers: headers,
        body: data,
      );

      futureResponse.then((resp) {
        String responseBody = resp.body;
        String errorMessage;

        if (responseBody != null) {
          try {
            Map<String, dynamic> payload = jsonDecode(errorMessage);
            errorMessage = payload.containsKey("message") ? payload['message'] : null;
          } catch (e) {}
        }
        listener.onResponse(
          BaseResponse(
            statusCode: resp.statusCode,
            statusMessage: errorMessage == null ? resp.reasonPhrase : errorMessage,
            data: responseBody,
          ),
        );
      }, onError: (error) {
        listener.onResponse(BaseResponse(
          statusCode: 500,
          statusMessage: "Could not process your request, check your internet connection",
          data: null,
        ));
      });
    });
  }
}
