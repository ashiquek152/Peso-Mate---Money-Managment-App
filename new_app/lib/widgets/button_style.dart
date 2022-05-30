import 'package:flutter/material.dart';
import 'package:new_app/widgets/colors.dart';

ButtonStyle buttonStyle({Color color=white,double radius=10,pressed}) {

  return ButtonStyle(
    foregroundColor: MaterialStateProperty.all(Colors.white),

    backgroundColor: MaterialStateProperty.all(pressed==true?red:amber),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    
    ),
  );
}


