import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';
import 'package:police_citizen_app/http/file-resource.dart';
import 'package:police_citizen_app/http/report-resource.dart';
import 'package:police_citizen_app/http/response/base-response.dart';
import 'package:police_citizen_app/models/report-category.dart';
import 'package:police_citizen_app/utils/widget-utils.dart';
import 'package:path/path.dart' as path;

class ReportScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ReportState();
  }
}

class _ReportState extends State<ReportScreen> implements BaseResponseListener {
  static final categories = allCategories;

  bool _isProcessing = false;
  ReportCategory _selectedCategory;
  String _reportDescripton;
  bool _reportAnon = false;
  bool _contactMe = false;

  final _descriptionController = TextEditingController();
  final _files = [];

  @override
  Widget build(BuildContext context) {
    if (_selectedCategory == null) {
      _selectedCategory = ModalRoute.of(context).settings.arguments;
    }

    return _isProcessing ? WidgetUtils.getLoaderWidget("Sending Report...") : _buildWidget(context);
  }

  Widget _buildWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey[800], //change your color here
        ),
        title: Text(
          "Report: $_selectedCategory",
          style: TextStyle(color: Colors.grey),
        ),
        backgroundColor: Colors.grey[50],
        brightness: Brightness.light,
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: IconButton(
              icon: Icon(Icons.send),
              color: Colors.blue,
              onPressed: () {
                _reportDescripton = _descriptionController.text;
                if (_reportDescripton.length > 10) {
                  _submitReport();
                }
              },
            ),
          )
        ],
      ),
      body: SafeArea(
          child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _descriptionController,
                  maxLines: 4,
                  minLines: 4,
                  textAlign: TextAlign.start,
                  decoration: new InputDecoration(
                    labelText: "Report Details",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                      borderSide: new BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  validator: (val) {
                    if (val.length == 10) {
                      return "Details Cannot Be less than 4";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Attach Media (Optional. Max. file size: 5MB)",
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.image,
                            color: Colors.orange,
                          ),
                        ),
                        onTap: () {
                          if (_files.length == 5) {
                            WidgetUtils.infoToast("Mximum of 5 files allowed");
                          } else {
                            _optionsDialogBox(context);
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                      ),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.videocam,
                            color: Colors.purple,
                          ),
                        ),
                        onTap: () {
                          WidgetUtils.infoToast("This feature is currently unavalibale");
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                      ),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.keyboard_voice,
                            color: Colors.blue,
                          ),
                        ),
                        onTap: () {
                          WidgetUtils.infoToast("This feature is currently unavalibale");
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Divider(),
                  ),
                  Column(
                    children: _files.length == 0
                        ? [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'No Files Selected',
                                style: TextStyle(color: Colors.grey[400]),
                              ),
                            ),
                          ]
                        : _buildFileList(),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: Card(
              child: Row(
                children: <Widget>[
                  Checkbox(
                    value: _reportAnon,
                    onChanged: (value) {
                      setState(() {
                        _reportAnon = value;
                      });
                    },
                  ),
                  Text("Report Anonmosly")
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: Card(
              child: Row(
                children: <Widget>[
                  Checkbox(
                    value: _contactMe,
                    onChanged: (value) {
                      setState(() {
                        _contactMe = value;
                      });
                    },
                  ),
                  Text("Contact me for more information.")
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  List<Widget> _buildFileList() {
    List<Widget> fileWidget = [];

    for (int i = 0; i < _files.length; i++) {
      fileWidget.add(
        Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  path.basename(_files[i].path),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      setState(() {
                        _files.removeAt(i);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }
    return fileWidget;
  }

  Future<void> _optionsDialogBox(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                GestureDetector(
                  child: new Text('Take a picture'),
                  onTap: () {
                    _captureImage();
                    Navigator.pop(context);
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                GestureDetector(
                  child: new Text('Select from gallery'),
                  onTap: () {
                    _pickImage();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _pickImage() async {
    var picture = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (picture != null) {
      setState(() {
        _files.add(picture);
      });
    }
  }

  void _captureImage() async {
    var picture = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );

    if (picture != null) {
      setState(() {
        _files.add(picture);
      });
    }
  }

  void _submitReport() async {
    setState(() {
      _isProcessing = true;
    });

    var uploadedMedia = [];

    for (int i = 0; i < _files.length; i++) {
      String uploadUrl = await FileResource.uploadUrl();

      if (uploadUrl == null) {
        setState(() {
          _isProcessing = false;
          WidgetUtils.errorToast("File upload failed, please check your internet connection");
        });
        return;
      }

      String response = await FileResource.uploadFileToUrl(uploadUrl, _files[i]);

      if (response == null) {
        setState(() {
          _isProcessing = false;
          WidgetUtils.errorToast("File upload failed, please check your internet connection");
        });
        return;
      }

      uploadedMedia.add({
        'id': jsonDecode(response)['id'].toString(),
        'file_name': path.basename(_files[i].path),
        'mime_type': mime(path.basename(_files[i].path)),
      });
    }

    var position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    if (position == null) {
      WidgetUtils.errorToast("You must enable location retrival to send a quick report");
      Navigator.pop(context);
    }

    var payload = {
      'type': _selectedCategory.type,
      'title': _selectedCategory.title,
      'detail': _reportDescripton,
      'anon': _reportAnon,
      'contact_me': _contactMe,
      'location': {
        'lon': position.longitude,
        'lat': position.latitude,
      },
      'media': uploadedMedia
    };

    ReportResource.sendReport(payload, this);
  }

  @override
  void onResponse(BaseResponse response) {
    if (response.statusCode == 200) {
      WidgetUtils.successToast("Report Sent!");
      Navigator.pop(context);
    } else {
      WidgetUtils.errorToast("Quick Report Sending Failed!");
      setState(() {
        _isProcessing = false;
      });
    }
  }
}
