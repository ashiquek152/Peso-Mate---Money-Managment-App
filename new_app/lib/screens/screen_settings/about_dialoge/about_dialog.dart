  import 'package:flutter/material.dart';
import 'package:new_app/widgets/colors.dart';

ontapAbout(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SimpleDialog(
          backgroundColor: scfldWhite,
          title: Text(
            "About",
            style: TextStyle(color: amber, fontSize: 18),
          ),
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                style: TextStyle(color: scaffoldbgnew, fontSize: 15),
              ),
            )
          ],
        );
      },
    );
  }