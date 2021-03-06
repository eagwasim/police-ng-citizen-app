import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:police_citizen_app/http/base-resource.dart';

class FileResource {
  static const FILE_CONTEXT_PATH = "/api/v1/files";

  static void uploadFile(File imageFile, Function(String) listener) async {
    Future<http.Response> response = http.post(BaseResource.BASE_URL + "$FILE_CONTEXT_PATH/upload/url", body: {});

    response.then((resp2) async {
      if (resp2.statusCode == 200) {
        String body = resp2.body;
        _upload(imageFile, body, listener);
      } else {
        listener(null);
      }
    }, onError: (error) {
      listener(null);
    });
  }

  static _upload(File imageFile, String url, Function(String) listener) async {
    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse(url);

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length, filename: basename(imageFile.path));

    request.files.add(multipartFile);

    var response = await request.send();

    response.stream.transform(utf8.decoder).listen(listener);
  }

  static Future<String> uploadUrl() async {
    var response = await http.post(BaseResource.BASE_URL + "$FILE_CONTEXT_PATH/upload/url", body: {});

    if (response.statusCode == 200) {
      return response.body;
    }

    return null;
  }

  static Future<String> uploadFileToUrl(String url, File media) async {
    var stream = new http.ByteStream(DelegatingStream.typed(media.openRead()));
    var length = await media.length();

    var uri = Uri.parse(url);

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length, filename: basename(media.path));

    request.files.add(multipartFile);

    var response = await request.send();
    return await utf8.decodeStream(response.stream);
  }
}
