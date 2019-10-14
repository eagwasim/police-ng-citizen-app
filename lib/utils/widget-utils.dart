import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WidgetUtils {
  static BoxDecoration getDefaultGradientBackground() {
    return BoxDecoration(
      // Box decoration takes a gradient
      gradient: LinearGradient(
        // Where the linear gradient begins and ends
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        // Add one stop for each color. Stops should increase from 0 to 1
        stops: [0.2, 0.5, 0.7, 0.9],

        colors: [
          // Colors are easy thanks to Flutter's Colors class.
          Colors.indigo[800],
          Colors.indigo[600],
          Colors.indigo[300],
          Colors.indigo[100],
        ],
      ),
    );
  }

  static BoxDecoration getLightGradientBackground() {
    return BoxDecoration(
      // Box decoration takes a gradient
      gradient: LinearGradient(
        // Where the linear gradient begins and ends
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        // Add one stop for each color. Stops should increase from 0 to 1
        stops: [0.1, 0.5, 0.7, 0.9],

        colors: [
          // Colors are easy thanks to Flutter's Colors class.
          Colors.white,
          Colors.white,
          Colors.white,
          Colors.white,
        ],
      ),
    );
  }

  static void showAlertDialog(BuildContext context, String title, String message) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Widget getLoaderWidget(String text) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 100.0,
              width: 100.0,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.blue),
                strokeWidth: 8.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
            ),
            Padding(padding: const EdgeInsets.all(8.0), child: Text(text)),
          ],
        ),
      ),
    );
  }

}
