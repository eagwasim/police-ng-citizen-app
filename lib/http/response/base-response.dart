class BaseResponse {
  int statusCode;
  String statusMessage;
  String data;

  BaseResponse({this.statusCode, this.statusMessage, this.data});
}

abstract class BaseResponseListener {
  void onResponse(BaseResponse response);
}
