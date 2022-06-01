  import 'package:flutter/material.dart';
import 'package:new_app/widgets/colors.dart';

ontapAbout(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  SimpleDialog(
          backgroundColor: scfldWhite,
          title: Text(
            "About",
            style: TextStyle(color: amber, fontSize: 18),
          ),
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Peso Mate is a money management app where you can add all your daily money transactions. This app is made by Ashique under Brototype academy.",
                style: TextStyle(color: scaffoldbgnew, fontSize: 18),
              ),
            )
          ],
        );
      },
    );
  }