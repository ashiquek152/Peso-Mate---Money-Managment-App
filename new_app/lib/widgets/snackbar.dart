import 'package:flutter/material.dart';
import 'package:new_app/widgets/colors.dart';

SnackBar snackbar({required String content, Color color=amber}) {
  return SnackBar(
dismissDirection: DismissDirection.down,
duration: const Duration(seconds: 1),
// behavior: SnackBarBehavior.floating,
shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(10.0),
),
backgroundColor: color,
content:  Text(content),
);
}
