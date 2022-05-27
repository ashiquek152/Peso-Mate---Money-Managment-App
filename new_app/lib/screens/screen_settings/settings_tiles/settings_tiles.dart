import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:new_app/notification_model/notification_model.dart';
import 'package:new_app/screens/screen_home/screen_home.dart';
import 'package:new_app/screens/screen_settings/about_dialoge/about_dialog.dart';
import 'package:new_app/screens/screen_settings/wipe_data/wipe_app_data.dart';
import 'package:new_app/widgets/colors.dart';
import 'package:new_app/widgets/snackbar.dart';
import 'package:new_app/widgets/text_widget.dart';

class SettingsTiles extends StatefulWidget {
  const SettingsTiles({
    Key? key,
    required this.avatar,
    required this.contents,
    required this.title,
    required double w,
    required this.tileIndex,
  })  : _w = w,
        super(key: key);

  final double _w;
  final String title;
  final IconData avatar;
  final String? contents;
  final int tileIndex;

  @override
  State<SettingsTiles> createState() => _SettingsTilesState();
}

class _SettingsTilesState extends State<SettingsTiles>
    with TickerProviderStateMixin {
  bool isTapped = false;
  TimeOfDay? pickedTIme;
  final timeRightNow = TimeOfDay.now();

  @override
  void initState() {
    NotificationApi().init(initScheduled: true);
    listenNotifications();
    super.initState();
  }
      listenNotifications(){
        NotificationApi.onNotifications.listen(onclickNotifications);
      
    }
    onclickNotifications(String? payload){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder:  (context) => const Homepage()));
    }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      enableFeedback: true,
      onTap: () {
        switch (widget.tileIndex) {
          case 1:
            ontapAbout(context); // Working properly
            break;
          case 2:
            timePicking(context: context);
            break;
          case 3:
            wipeAppdata(context); // Working properly
            break;
        }
      },
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.fromLTRB(
            widget._w / 20, widget._w / 20, widget._w / 20, 0),
        padding: EdgeInsets.all(widget._w / 20),
        height: widget._w / 4.4,
        width: widget._w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xffEDECEA),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
                backgroundColor: scaffoldbgnew.withOpacity(.1),
                radius: widget._w / 15,
                child: Icon(
                  widget.avatar,
                  color: amber,
                  size: 35,
                )),
            Container(
              alignment: Alignment.centerLeft,
              width: widget._w / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    textScaleFactor: 1.6,
                    style: TextStyle(
                      fontFamily: fontComforataa,
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(.7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //
  //
  //
  //
  //
  //
  ontapNotifications(context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: Colors.amber,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const TextWidget(
                text: "Add Notification",
                minsize: 18,
                maxsize: 20,
                fontWeight: FontWeight.bold,
              ),
              ElevatedButton(
                child: const Text('Set Time'),
                onPressed: () => timePicking(context: context),
              )
            ],
          ),
        );
      },
    );
  }

  //
  //
  //
  //
  timePicking({required context}) async {
    pickedTIme = await showTimePicker(
        helpText: "Set time for notification",
        initialEntryMode: TimePickerEntryMode.dial,
        context: context,
        initialTime: timeRightNow);
    if (pickedTIme != null && pickedTIme != timeRightNow) {
      NotificationApi.showScheduledNotifications(
          title: "Peso Mate",
          body: "You forgot to add something",
          scheduledTime: Time(pickedTIme!.hour, pickedTIme!.minute, 0));
      Navigator.of(context).pop();
      snackbar(content: "Notification added", color: amber);
    }
  }
}
