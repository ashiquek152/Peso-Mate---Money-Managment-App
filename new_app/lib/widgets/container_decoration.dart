import 'package:flutter/material.dart';

import 'colors.dart';

BoxDecoration ContainerDecoration() {
  return BoxDecoration(
    color: white,
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
        color: scaffoldbgnew.withOpacity(.3),
        blurRadius: 50,
      ),
    ],
  );
}
