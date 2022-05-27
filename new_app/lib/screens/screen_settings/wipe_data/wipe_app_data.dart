import 'package:flutter/material.dart';
import 'package:new_app/db_helper/db_helper.dart';
import 'package:new_app/screens/screen_splash/screen_splash_page1.dart';
import 'package:new_app/widgets/button_style.dart';
import 'package:new_app/widgets/colors.dart';
Future<dynamic> wipeAppdata(context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text(
            "Are you sure want to clear all data ?",
            style: TextStyle(color: scaffoldbgnew),
          ),
          actions: [
            TextButton(
                style: buttonStyle(color: amber),
                onPressed: () {
                  DbHelper dbHelper = DbHelper();
                  dbHelper.clearDB();
                  dbHelper.deleteSharedPref();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const SplashPage1()),
                      (route) => false);
                },
                child: const Text(
                  "Clear",
                  style: TextStyle(color: scfldWhite),
                )),
            TextButton(
                style: buttonStyle(color: white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: amber),
                ))
          ],
          backgroundColor: scfldWhite,
        );
      });
}

Future settingsTiles({required title, required content, context}) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentTextStyle: const TextStyle(color: Colors.white),
        backgroundColor: scaffoldbgnew,
        title: const Text(
            "Are you sure want to clear all data ?",
            style: TextStyle(color: scfldWhite),
          ),
        content: 
         const Text(
            "Are you sure want to clear all data ?",
            style: TextStyle(color: scfldWhite),
          ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                "Close",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      );
    },
  );
}
