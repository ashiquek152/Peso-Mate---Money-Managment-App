import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:new_app/notification_model/notification_model.dart';
import 'package:new_app/screens/screen_settings/wipe_data/wipe_app_data.dart';
import 'package:new_app/widgets/colors.dart';
import 'package:new_app/widgets/sized_boxes.dart';
import 'package:new_app/widgets/text_widget.dart';
import 'package:new_app/widgets/textfield_border.dart';
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
  final messageController = TextEditingController();
  final timeNow = TimeOfDay.now();

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
            ontapNotifications(context);
            // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResponsiveButton()));

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

  ontapAbout(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SimpleDialog(
          backgroundColor: scaffoldbgnew,
          title: Text(
            "About",
            style: TextStyle(color: amber, fontSize: 18),
          ),
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                style: TextStyle(color: scfldWhite, fontSize: 15),
              ),
            )
          ],
        );
      },
    );
  }

  //
  ontapNotifications(context) {
    showModalBottomSheet(
      isDismissible: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: 400,
          decoration: BoxDecoration(
              color: white.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Column(
            children: [
              sizedH20,
              const TextWidget(
                text: "What should be notified ?",
                maxsize: 20,
                minsize: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: messageController,
                  style: const TextStyle(color: white),
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter a message max : 20';
                  //   } else {
                  //     return null;
                  //   }
                  // },
                  decoration: InputDecoration(
                    fillColor: const Color.fromARGB(6, 2, 2, 2),
                    filled: true,
                    hintText: 'Message...',
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(92, 255, 255, 255)),
                    enabledBorder: textFieldBorderStyle(),
                    focusedBorder: textFieldBorderStyle(),
                    errorBorder: textFieldBorderStyle(color: red),
                    focusedErrorBorder: textFieldBorderStyle(color: red),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    bottomSheetButtons(1),
                    bottomSheetButtons(2),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  InkWell bottomSheetButtons(int buttonIndex) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onHighlightChanged: (value) {
        setState(() {
          isTapped = value;
        });
      },
      onTap: () {
        switch (buttonIndex) {
          case 1:
            timePicking(context: context);
            break;
          case 2:
            notifymessageadded();
            //  Navigator.of(context).pop();
            break;
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastLinearToSlowEaseIn,
        height: isTapped ? 35 : 45,
        width: isTapped ? 80 : 100,
        decoration: BoxDecoration(
          color: amber,
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 30,
              offset: const Offset(3, 7),
            ),
          ],
        ),
        child: Center(
          child: TextWidget(
            text: buttonIndex == 1 ? "Set timer" : "Done",
            color: buttonIndex == 1 ? scaffoldbgnew : white,
            fontWeight: FontWeight.bold,
            maxsize: 16,
            minsize: 12,
          ),
        ),
      ),
    );
  }

  timePicking({required context}) async {
    pickedTIme = await showTimePicker(
        initialEntryMode: TimePickerEntryMode.dial,
        context: context,
        initialTime: timeNow);
  }

  notifymessageadded() {
    if (pickedTIme != null && pickedTIme != timeNow) {
      String? message = messageController.text;
      setState(() {
        NotificationApi.showScheduledNotifications(
            title: "Peso Mate",
            body: message,
            scheduledTime: Time(pickedTIme!.hour, pickedTIme!.minute, 0));
        Navigator.of(context).pop();
        messageController.text = "";
        // snackbar(content: "Notification added", color: blueGrey);
      });
    } else {
      showAboutDialog(context: context);
    }
  }
}
