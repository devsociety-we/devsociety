import 'dart:io';

import 'package:devsociety/Services/ThemeServcie.dart';
import 'package:devsociety/Wdigets/Card.dart';
import 'package:devsociety/Wdigets/MyTextWidget.dart';
import 'package:devsociety/Wdigets/SocialButtons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../GetItC.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ThemeClass themeClass = getIt<ThemeClass>();
  MyTheme theme = MyTheme.Light;

  bool showHiddenText = false;

  double getTitleScale(double width) {
    double scale = 1;
    if (width < 400) {
      scale = 2;
    } else if (width < 500) {
      scale = 2.3;
    } else if (width < 600) {
      scale = 2.6;
    } else if (width < 700) {
      scale = 3.0;
    } else if (width < 800) {
      scale = 3.3;
    } else if (width < 900) {
      scale = 3.6;
    } else if (width < 1000) {
      scale = 3.9;
    } else if (width < 1100) {
      scale = 4.2;
    } else if (width < 1200) {
      scale = 4.5;
    } else if (width < 1300) {
      scale = 4.8;
    } else {
      scale = 5;
    }
    return scale;
  }

  double _getSubTitleScale(double width) {
    double scale = 1;
    if (width < 400) {
      scale = 1.3;
    } else if (width < 500) {
      scale = 1.5;
    } else if (width < 600) {
      scale = 1.7;
    } else if (width < 700) {
      scale = 1.9;
    } else if (width < 800) {
      scale = 2.1;
    } else if (width < 900) {
      scale = 2.3;
    } else {
      scale = 2.5;
    }
    return scale;
  }

  Widget textWidgets() {
    return Container(
      width: 800,
      child: MouseRegion(
        onEnter: (event) => setState(() => showHiddenText = true),
        onHover: (event) {
          if (!kIsWeb) if (Platform.isIOS || Platform.isAndroid)
            setState(() => showHiddenText = !showHiddenText);
        },
        onExit: (event) => setState(() => showHiddenText = false),
        child: AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: showHiddenText
                ? Container(
                    key: ValueKey(showHiddenText),
                    child: Column(
                      children: [
                        MyText(
                          "Don't Worry Our Fellow Dev",
                          scale: 3,
                          fontWeight: FontWeight.w100,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                          textAlign: TextAlign.center,
                        ),
                        Text.rich(
                          TextSpan(children: [
                            MyTextSpan(
                              text: "Welcome to the ",
                              fontWeight: FontWeight.w100,
                            ),
                            MyTextSpan(
                                text: "City Of Devs, \n",
                                fontWeight: FontWeight.bold),
                            MyTextSpan(
                              text: "We're gonna ",
                              fontWeight: FontWeight.w100,
                            ),
                            MyTextSpan(
                                text: "Rise High together.",
                                fontWeight: FontWeight.bold),
                          ]),
                          textScaleFactor: 2.5,
                          textAlign: TextAlign.center,
                        ),
                        Text.rich(
                          TextSpan(children: [
                            MyTextSpan(
                              text: "Join in and we'll ",
                              fontWeight: FontWeight.w100,
                            ),
                            MyTextSpan(
                                text: "Initiate the Development\n",
                                fontWeight: FontWeight.bold),
                            MyTextSpan(
                              text: "of one of the ",
                              fontWeight: FontWeight.w100,
                            ),
                            MyTextSpan(
                                text: "Largest Community of Developers ",
                                fontWeight: FontWeight.bold)
                          ]),
                          textScaleFactor: 2.5,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : Container(
                    key: ValueKey(showHiddenText),
                    child: Column(
                      children: [
                        MyText(
                          "Oh The Website seems empty!",
                          scale: 3,
                          fontWeight: FontWeight.w100,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                          textAlign: TextAlign.center,
                        ),
                        Text.rich(
                          TextSpan(children: [
                            MyTextSpan(
                              text: "Shall ",
                              fontWeight: FontWeight.w100,
                            ),
                            MyTextSpan(
                                text: "WE ", fontWeight: FontWeight.bold),
                            MyTextSpan(
                              text: "start adding content in ",
                              fontWeight: FontWeight.w100,
                            ),
                            MyTextSpan(
                                text: "OUR ", fontWeight: FontWeight.bold),
                            MyTextSpan(
                              text: "website?",
                              fontWeight: FontWeight.w100,
                            ),
                          ]),
                          textScaleFactor: 2.5,
                          textAlign: TextAlign.center,
                        ),
                        Text.rich(
                          TextSpan(children: [
                            MyTextSpan(
                              text: "Let's join, ",
                              fontWeight: FontWeight.w100,
                            ),
                            MyTextSpan(
                                text: "YOU ", fontWeight: FontWeight.bold),
                            MyTextSpan(
                              text: "and ",
                              fontWeight: FontWeight.w100,
                            ),
                            MyTextSpan(
                                text: "US ", fontWeight: FontWeight.bold),
                            MyTextSpan(
                              text: "together and become ",
                              fontWeight: FontWeight.w100,
                            ),
                            MyTextSpan(
                                text: "ONE in OUR DevSociety.",
                                fontWeight: FontWeight.bold),
                          ]),
                          textScaleFactor: 2.5,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    theme = Provider.of<MyTheme>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyText(
                    "Dev Society",
                    scale: getTitleScale(size.width),
                    fontWeight: FontWeight.w300,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      if (theme != MyTheme.Dark) {
                        themeClass.changeTheme(MyTheme.Dark);
                      } else {
                        themeClass.changeTheme(MyTheme.Light);
                      }
                    },
                    icon: AnimatedSwitcher(
                        duration: Duration(milliseconds: 100),
                        child: Icon(
                          theme != MyTheme.Dark
                              ? Icons.nights_stay
                              : Icons.wb_sunny,
                          key: ValueKey(theme),
                        )),
                  ),
                ],
              ),
              MyText(
                "A Group of Geeks Joined together for all tech innovation",
                scale: _getSubTitleScale(size.width),
                textAlign: TextAlign.center,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runSpacing: 10,
                  spacing: 10,
                  children: [
                    CardWidget(),
                    SizedBox(
                      width: 20,
                    ),
                    textWidgets(),
                    if (size.width > 650)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TelegramButton(),
                          SizedBox(
                            width: 50,
                          ),
                          GithubButton(),
                        ],
                      )
                    else
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TelegramButton(),
                          SizedBox(
                            height: 25,
                          ),
                          GithubButton(),
                        ],
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
