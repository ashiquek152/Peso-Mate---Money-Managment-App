import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_app/screens/screen_home/screen_home.dart';
import 'package:new_app/widgets/colors.dart';
import 'package:new_app/widgets/textfield_border.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  _LoginpgageState createState() => _LoginpgageState();
}

class _LoginpgageState extends State<Loginpage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: .7, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    )
      ..addListener(
        () {
          setState(() {});
        },
      )
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            _controller.reverse();
          } else if (status == AnimationStatus.dismissed) {
            _controller.forward();
          }
        },
      );

    _controller.forward();
  }

  final logincontroller = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: scfldWhite,
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: _height,
            child: Column(
              children: [
                const Expanded(child: SizedBox()),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(),
                      const Text(
                        'What should we call you ?',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: scaffoldbgnew,
                            fontFamily: "Comfortaa"),
                      ),
                      component1(
                          Icons.account_circle_outlined, 'Enter your name...'),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(bottom: _width * .07),
                          height: _width * .7,
                          width: _width * .7,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.transparent,
                                Color(0xff09090A),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Transform.scale(
                          scale: _animation.value,
                          child: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              if (formkey.currentState!.validate()) {
                                HapticFeedback.lightImpact();
                                usernameStore(logincontroller.text, context);
                              }
                            },
                            child: Container(
                              height: _width * .2,
                              width: _width * .2,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: Colors.amber,
                                shape: BoxShape.circle,
                              ),
                              child: const Text(
                                'Let\'s start',
                                style: TextStyle(
                                  color: scfldWhite,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> usernameStore(String name, context) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('username', name);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Homepage()),
        (route) => false);
  }

  Widget component1(IconData icon, String hintText) {
    double _width = MediaQuery.of(context).size.width;
    return Form(
      key: formkey,
      child: Container(
        height: _width / 6,
        width: _width / 1.22,
        alignment: Alignment.center,
        child: Center(
          child: TextFormField(
            style: const TextStyle(color: scaffoldbgnew),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name ';
              } else {
                return null;
              }
            },
            controller: logincontroller,
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                fillColor: white,
                filled: true,
                errorStyle:  TextStyle(fontSize: 13, color: amber),
                hintText: 'Enter your name...',
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: scaffoldbgnew.withOpacity(.5),
                ),
                enabledBorder: textFieldBorderStyle(color: scfldWhite),
                focusedBorder: textFieldBorderStyle(color: scfldWhite),
                errorBorder: textFieldBorderStyle(color: scfldWhite),
                focusedErrorBorder: textFieldBorderStyle(color: scfldWhite),
                prefixIcon: Icon(icon)),
            maxLength: 12,
          ),
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
