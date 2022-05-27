  import 'package:flutter/material.dart';

import 'colors.dart';

OutlineInputBorder textFieldBorderStyle({Color color = white}) {
    return OutlineInputBorder(
        borderSide: BorderSide(color: color),
        borderRadius: BorderRadius.circular(5));
  }


   InputDecoration textFiledDecorations(hinttext,icon,) {
    return InputDecoration(
      prefixIcon: Icon(icon,
          size: 25.0, color: scaffoldbgnew.withOpacity(0.7)),
      fillColor: scfldWhite,
      filled: true,
      hintText: hinttext,
      hintStyle: TextStyle(color: scaffoldbgnew.withOpacity(0.4)),
      enabledBorder: textFieldBorderStyle(),
      focusedBorder: textFieldBorderStyle(),
      errorBorder: textFieldBorderStyle(color: white),
      focusedErrorBorder: textFieldBorderStyle(color: white),
    );
  }