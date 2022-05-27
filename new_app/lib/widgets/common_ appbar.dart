import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_app/screens/screen_home/screen_home.dart';
import 'package:new_app/widgets/colors.dart';
import 'package:new_app/widgets/text_widget.dart';

class AppBarcommon extends StatelessWidget {
  const AppBarcommon({
    Key? key,
    required this.pageHeading,
  }) : super(key: key);

  final String pageHeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: amber,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
        title: TextWidget(
          text: pageHeading,
          family: 'Swera',
          color: scaffoldbgnew,
          maxsize: 20,
          minsize: 16,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
            enableFeedback: true,
            icon: const Icon(CupertinoIcons.arrow_left_circle,
                size: 35, color: scfldWhite),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const Homepage()),
                  (route) => false);
            }));
  }
}
