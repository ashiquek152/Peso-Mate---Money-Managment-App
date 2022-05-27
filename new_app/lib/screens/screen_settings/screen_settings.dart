import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:new_app/screens/screen_settings/settings_tiles/settings_tiles.dart';
import 'package:new_app/widgets/colors.dart';
import 'package:new_app/widgets/painter_class.dart';
import 'package:new_app/widgets/text_widget.dart';

class Settingspage extends StatefulWidget {
  const Settingspage({Key? key}) : super(key: key);

  @override
  State<Settingspage> createState() => _SettingspageState();
}

class _SettingspageState extends State<Settingspage> {
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: amber,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
        title: const TextWidget(
           text: "Settings",
          
          family: 'Swera',
          color: scaffoldbgnew,
          maxsize: 20,
          minsize: 16,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          enableFeedback: true,
          icon: const Icon(
            CupertinoIcons.arrow_left_circle,
            size: 35,
            color: scaffoldbgnew,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        children: [
          ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              SettingsTiles(
                  avatar: Icons.info,
                  contents: "",
                  title: "About",
                  tileIndex: 1,
                  w: _w),
              SettingsTiles(
                  avatar: Icons.alarm,
                  contents: "",
                  title: "Notifications",
                  tileIndex: 2,
                  w: _w),
              SettingsTiles(
                  avatar: Icons.replay_circle_filled_outlined,
                  contents: "",
                  title: "Reset App",
                  tileIndex: 3,
                  w: _w),
            ],
          ),
          CustomPaint(
            painter: MyPainter(),
            child: Container(height: 0),
          ),
        ],
      ),
    );
  }
}
