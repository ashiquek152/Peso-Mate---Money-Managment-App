import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:new_app/notification_model/notification_model.dart';
import 'package:new_app/screens/screen_home/screen_home.dart';
import 'package:new_app/screens/screen_settings/about_dialoge/about_dialog.dart';
import 'package:new_app/screens/screen_settings/wipe_data/wipe_app_data.dart';
import 'package:new_app/widgets/colors.dart';
import 'package:new_app/widgets/sized_boxes.dart';
import 'package:new_app/widgets/text_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  final double _w ;
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
  bool switchButtonstate = false;

  @override
  void initState() {
    NotificationApi().init(initScheduled: true);
    listenNotifications();
    super.initState();
  }

  listenNotifications() {
    NotificationApi.onNotifications.listen(onclickNotifications);
  }

  onclickNotifications(String? payload) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Homepage()));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      enableFeedback: true,
      onTap: () {
        switch (widget.tileIndex) {
          case 1:
            ontapAbout(context); 
            break;
          case 2: 
            ontapNotification(context);
            break;
          case 3:
            wipeAppdata(context);
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
          children: [
            CircleAvatar(
                backgroundColor: scaffoldbgnew.withOpacity(.1),
                radius: widget._w / 15,
                child: Icon(
                  widget.avatar,
                  color: amber,
                  size: 35,
                )),
                sizedW10,
            Container(
              alignment: Alignment.centerLeft,
              width: widget._w / 2.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Text(
                     widget.title,
                    textScaleFactor: 1.3,
                    style: TextStyle(
                      fontFamily: fontComforataa,
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(.7),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 40),
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
  ontapNotification(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  SimpleDialog(
          backgroundColor: scfldWhite,
          title: const Text(
            "Set Notifications",
            style: TextStyle(color: amber, fontSize: 18),
          ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: ()async{
                 await pickNotificationTime(context: context);
                 Navigator.of(context).pop();
                }, child: const Text("Add")),
                ElevatedButton(onPressed: ()async{
                await NotificationApi.cancellNotifications();
                 Fluttertoast.showToast(
                   backgroundColor: red,
                   msg:"All notifications cleared");
                 Navigator.of(context).pop();
                }, child: const Text("Cancel Notifications")),
              ],
            )
          ],
        );
      },
    );
  }




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
                onPressed: () => pickNotificationTime(context: context),
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

  pickNotificationTime({required context}) async {
    pickedTIme = await showTimePicker(
        helpText: "Set time for notification",
        initialEntryMode: TimePickerEntryMode.dial,
        context: context,
        initialTime: timeRightNow);
    if (pickedTIme != null && pickedTIme != timeRightNow) {
      String amORpm=pickedTIme!.hour>12?"PM":"AM";
      Fluttertoast.showToast(
        backgroundColor:red,
        gravity: ToastGravity.SNACKBAR,
        msg: "Notification set at ${pickedTIme!.hour>12? pickedTIme!.hour-12:pickedTIme!.hour }:${pickedTIme!.minute} $amORpm");
      NotificationApi.showScheduledNotifications(
          title: "Peso Mate",
          body: "You forgot to add something",
          scheduledTime: Time(pickedTIme!.hour, pickedTIme!.minute, 0));
      
    } else {
      setState(() {
        switchButtonstate = false;
      });
    }
  }
}
