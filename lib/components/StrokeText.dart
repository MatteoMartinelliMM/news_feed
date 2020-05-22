import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StrokeText extends StatelessWidget {
  String text;
  Color strokeColor, textColor;
  double textSize;

  StrokeText(@required this.text, @required this.strokeColor,
      @required this.textColor, @required this.textSize);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Text(
          text,
          style: TextStyle(
              fontSize: textSize,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 2
                ..color = strokeColor),
        ),
        Text(
          text,
          style: TextStyle(fontSize: textSize, color: textColor),
        )
      ],
    );
  }
}
