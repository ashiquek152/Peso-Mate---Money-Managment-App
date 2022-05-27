import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:new_app/screens/screen_splash/screen_splash_page2.dart';
import 'package:new_app/widgets/colors.dart';
import 'package:new_app/widgets/text_widget.dart';



class SplashPage1 extends StatefulWidget {
  const SplashPage1({Key? key}) : super(key: key);

  @override
  _SplashPage1State createState() => _SplashPage1State();
}

class _SplashPage1State extends State<SplashPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: scfldWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Lets begin...',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                fontFamily: fontComforataa,
                color: scaffoldbgnew
              ),
            ),
            OpenContainer(
              closedBuilder: (_, openContainer) {
                return  Container(
                  color: amber,
                  height: 80,
                  width: 80,
                  child: const Center(
                    child: Text(
                      'Hello !',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: fontComforataa
                      ),
                    ),
                  ),
                );
              },
              openColor:scaffoldbgnew,
              closedElevation: 20,
              closedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              transitionDuration: const Duration(milliseconds: 700),
              openBuilder: (_, closeContainer) {
                return const Splashpage2();
              },
            ),
          ],
        ),
      ),
    );
  }
}



