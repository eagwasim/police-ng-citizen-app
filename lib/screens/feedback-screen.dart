import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:police_citizen_app/utils/widget-utils.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FeedbackState();
  }
}

class _FeedbackState extends State<FeedbackScreen> {
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey[800], //change your color here
        ),
        title: Text(
          "Feedback",
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
                var _reportDescription = _descriptionController.text;
                if (_reportDescription.length > 10) {
                  WidgetUtils.successToast("Feedback sent!");
                  Navigator.pop(context);
                }
              },
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Padding(
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
                    labelText: "Feedback Details (min 10 characters)",
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
        ),
      ),
    );
  }
}
