import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'colors.dart';

class TextWidget extends StatelessWidget {
   const TextWidget({
    Key? key,
    required this.text,
    this.fontWeight = FontWeight.normal,
    this.color = white,
    this.family = "Comfortaa",
    this.maxsize,
    this.minsize,
    this.defaultFont,
  }) : super(key: key);

  final String text;
  final Color color;
  final String family;
  final FontWeight fontWeight;
  final double? maxsize;
  final double? minsize;
  final double? defaultFont;
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      maxLines: 2,
      textAlign: TextAlign.center,
      maxFontSize: maxsize!,
      minFontSize: minsize!,
      style: TextStyle(
        overflow: TextOverflow.ellipsis,       
        color: color,
        fontWeight: fontWeight,
        fontFamily: family,
        fontSize: defaultFont,
      ),
    );
  }
}
const fontComforataa = "Comfortaa";
