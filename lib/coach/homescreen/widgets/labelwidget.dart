import 'package:flutter/material.dart';

class LabelWidget extends StatelessWidget {
  final String labelText;
  final Color colorText;
  final double sizeText;

  LabelWidget(
      {Key key,
      @required this.labelText,
      @required this.colorText,
      this.sizeText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(labelText,
        style: TextStyle(color: colorText, fontSize: sizeText));
  }
}
