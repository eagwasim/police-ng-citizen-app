import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:police_citizen_app/http/file-resource.dart';
import 'package:police_citizen_app/http/report-resource.dart';
import 'package:police_citizen_app/http/response/base-response.dart';
import 'package:police_citizen_app/utils/route.dart';
import 'package:police_citizen_app/utils/widget-utils.dart';
import 'package:path/path.dart' as path;
import 'package:mime_type/mime_type.dart';

class QuickReportScreen extends StatefulWidget {
  static const QUICK_REPORT_TYPE_AUDIO = "QUICK_REPORT_TYPE_AUDIO";
  static const QUICK_REPORT_TYPE_VIDEO = "QUICK_REPORT_TYPE_VIDEO";
  static const QUICK_REPORT_TYPE_PHOTO = "QUICK_REPORT_TYPE_PHOTO";
  static const QUICK_REPORT_TYPE_PHOTO_GALLERY = "QUICK_REPORT_TYPE_PHOTO_GALLERY";

  @override
  State<StatefulWidget> createState() {
    return _QuickReportState();
  }
}

class QuickReportType {
  final String type;

  QuickReportType({@required this.type});
}

class _QuickReportState extends State<QuickReportScreen> implements BaseResponseListener {
  bool _isProcessing = false;
  bool _isInitialStateDone = false;
  QuickReportType _reportType;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialStateDone) {
      _isInitialStateDone = true;
      _reportType = ModalRoute.of(context).settings.arguments;

      switch (_reportType.type) {
        case QuickReportScreen.QUICK_REPORT_TYPE_AUDIO:
          _captureAudio();
          break;
        case QuickReportScreen.QUICK_REPORT_TYPE_VIDEO:
          _captureVideo();
          break;
        case QuickReportScreen.QUICK_REPORT_TYPE_PHOTO:
          _captureImage();
          break;
        case QuickReportScreen.QUICK_REPORT_TYPE_PHOTO_GALLERY:
          _pickImage();
          break;
      }
    }
    return _isProcessing ? WidgetUtils.getLoaderWidget("Sending report...") : WidgetUtils.getLoaderWidget("Capturing...");
  }

  void _captureVideo() async {
    final CaptureResult result = await Navigator.pushNamed(context, Routes.VIDEO_CAPTURE_SCREEN);
    if (result == null) {
      Navigator.pop(context);
    }
  }

  void _captureAudio() async {
    final CaptureResult result = await Navigator.pushNamed(context, Routes.AUDIO_CAPTURE_SCREEN);
    if (result == null) {
      Navigator.pop(context);
    }
  }

  void _pickImage() async {
    var picture = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (picture != null) {
      _sendQuickReport(picture);
      setState(() {
        _isProcessing = true;
      });
    } else {
      Navigator.pop(context);
    }
  }

  void _captureImage() async {
    var picture = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );

    if (picture != null) {
      _sendQuickReport(picture);
      setState(() {
        _isProcessing = true;
      });
    } else {
      Navigator.pop(context);
    }
  }

  void _sendQuickReport(File file) async {
    Future<Position> futurePosition = Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    futurePosition.then((position) {
      FileResource.uploadFile(file, (response) {
        if (response == null) {
          WidgetUtils.errorToast("Could not get your current location!");
          Navigator.pop(context);
          return;
        }
        print({
          jsonDecode(response)['id']: {
            'file_name': path.basename(file.path),
            'mime_type': mime(path.basename(file.path)),
          }
        });

        ReportResource.sendQuickReport({
          'lon': position.longitude,
          'lat': position.latitude,
          'media': {
            jsonDecode(response)['id'].toString(): {
              'file_name': path.basename(file.path),
              'mime_type': mime(path.basename(file.path)),
            }
          }
        }, this);
      });
    }, onError: (error) {
      WidgetUtils.errorToast(error);
      Navigator.pop(context);
    });
  }

  @override
  void onResponse(BaseResponse response) {
    if (response.statusCode == 200) {
      WidgetUtils.successToast("Quick Report Sent!");
      Navigator.pop(context);
    } else {
      WidgetUtils.errorToast("Quick Report Sending Failed!");
      Navigator.pop(context);
    }
  }
}

class CaptureResult {
  String status;
}
