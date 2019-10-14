import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class QuickReportItem extends StatelessWidget {
  final String image;
  final String text;
  final VoidCallback callback;

  QuickReportItem({this.image, this.text, this.callback});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/images/$image", height: 25,),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(text),
              ),
            ],
          ),
        ),
        onTap: callback,
      ),
    );
  }
}
