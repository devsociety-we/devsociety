import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

class MyText extends Text {
  final String text;
  final double size;
  final double scale;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  MyText(
    this.text, {
    this.size = 14,
    this.textAlign = TextAlign.start,
    this.scale = 1.0,
    this.color = const Color(0xff000000),
    this.fontWeight = FontWeight.normal,
  }) : super(text,
            style:
                TextStyle(fontSize: size, fontWeight: fontWeight, color: color),
            textScaleFactor: scale);
}

class MyTextSpan extends TextSpan {
  final List<TextSpan> spans;
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final double size;
  final GestureRecognizer recognizer;
  MyTextSpan(
      {this.color,
      this.fontWeight = FontWeight.normal,
      this.textAlign,
      this.size,
      this.spans,
      this.text,
      this.recognizer})
      : super(
          children: spans,
          text: text,
          recognizer: recognizer,
          style:
              TextStyle(color: color, fontSize: size, fontWeight: fontWeight),
        );
}
