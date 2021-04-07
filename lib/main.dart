import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:devsociety/GetItC.dart';
import 'package:devsociety/Utilities/Colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Services/ThemeServcie.dart';
import 'Wdigets/MyTextWidget.dart';

void main() {
  setup();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      StreamProvider<MyTheme>.value(
          initialData: MyTheme.Light,
          value: getIt<ThemeClass>().themeController.stream),
    ], child: MainClass());
  }
}

List<dynamic> card = [1, 2];

final darkTheme = ThemeData(
    primaryColor: MyColor().createMaterialColor(mainDarkColor),
    accentColor: mainDarkColor,
    brightness: Brightness.dark);
final lightTheme = ThemeData(
    primarySwatch: MyColor().createMaterialColor(mainLightColor),
    accentColor: mainLightColor,
    brightness: Brightness.light);

ThemeData getTheme(MyTheme theme) {
  switch (theme) {
    case MyTheme.Light:
      return lightTheme;
      break;
    case MyTheme.Dark:
      return darkTheme;
      break;

    default:
      return darkTheme;
  }
}

ThemeMode getThemeMode(MyTheme theme) {
  switch (theme) {
    case MyTheme.Light:
      return ThemeMode.light;
      break;
    case MyTheme.Dark:
      return ThemeMode.dark;
      break;
    default:
      return ThemeMode.system;
  }
}

class MainClass extends StatelessWidget {
  MainClass({Key key});

  @override
  Widget build(BuildContext context) {
    MyTheme myTheme = Provider.of<MyTheme>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      title: "Dev Society | Welcome to the City of Developers",
      themeMode: getThemeMode(myTheme),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ThemeClass themeClass = getIt<ThemeClass>();
  MyTheme theme = MyTheme.Light;
  bool showFront = true;
  bool hovering = false;
  bool showHiddenText = false;
  Size originalSize;
  Key key = UniqueKey();
  final String telegramSVG = 'assets/telegram.svg';
  final String telegramLink = "https://t.me/joinchat/_6F7xO3nItY4MjFl";
  final String githubLink = 'https://www.github.com/devsociety-we';
  final String githubSVG = 'assets/github.svg';

  Widget _buildCardFront() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.contain, image: AssetImage('assets/CardFront.png'))),
    );
  }

  void initState() {
    super.initState();
  }

  Widget _buildCardBackground() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.contain, image: AssetImage('assets/CardBack.png'))),
    );
  }

  Widget cardWidget(Size size) {
    return Container(
      height: size.width > size.height ? size.width * 0.25 : size.width * 0.5,
      child: AspectRatio(
        aspectRatio: 7 / 4,
        child: AnimatedSwitcher(
          switchOutCurve: Curves.easeOut,
          switchInCurve: Curves.easeIn,
          duration: Duration(milliseconds: 500),
          transitionBuilder: (child, animation) {
            final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
            return AnimatedBuilder(
              animation: rotateAnim,
              child: child,
              builder: (context, child) {
                final isUnder = (ValueKey(showFront) != widget.key);
                final value =
                    isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
                return Transform(
                  transform: Matrix4.rotationY(value),
                  child: child,
                  alignment: Alignment.center,
                );
              },
            );
          },
          child: MouseRegion(
            key: key,
            onEnter: (event) {
              setState(() {
                hovering = true;
              });
            },
            onExit: (event) {
              setState(() {
                hovering = false;
              });
            },
            onHover: (event) {
              if (!kIsWeb) if (Platform.isIOS || Platform.isAndroid)
                setState(() => hovering = !hovering);
            },
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: InkWell(
                key: UniqueKey(),
                onTap: () => setState(() {
                  key = UniqueKey();
                  showFront = !showFront;
                }),
                child: Stack(
                  key: UniqueKey(),
                  children: [
                    Container(
                      child: showFront
                          ? _buildCardFront()
                          : _buildCardBackground(),
                    ),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 100),
                      child: hovering
                          ? Container(
                              alignment: Alignment.centerRight,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      stops: [
                                    0,
                                    0.8,
                                    1
                                  ],
                                      colors: [
                                    Colors.black.withOpacity(0.1),
                                    Colors.black.withOpacity(0.2),
                                    Colors.black.withOpacity(0.35),
                                  ])),
                              key: UniqueKey(),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 50,
                              ),
                            )
                          : Container(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
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
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(6),
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
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.all(4),
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

  Widget telegramWidget(double width) {
    return Column(
      children: [
        TextButton.icon(
          style: ButtonStyle(
              animationDuration: Duration(milliseconds: 300),
              elevation: MaterialStateProperty.resolveWith<double>((states) {
                if (states.contains(MaterialState.pressed)) {
                  return 8;
                } else if (states.contains(MaterialState.hovered)) {
                  return 4;
                }
                return 0;
              }),
              backgroundColor:
                  MaterialStateProperty.resolveWith<Color>((states) {
                if (states.contains(MaterialState.hovered) ||
                    states.contains(MaterialState.pressed) ||
                    states.contains(MaterialState.focused)) {
                  return Color(0xff29b6f6);
                }
                return Colors.transparent;
              }),
              foregroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.hovered) ||
                    states.contains(MaterialState.pressed) ||
                    states.contains(MaterialState.focused)) {
                  return Colors.white;
                }
                return Color(0xff29b6f6);
              }),
              shape:
                  MaterialStateProperty.resolveWith<OutlinedBorder>((states) {
                if (states.contains(MaterialState.pressed)) {
                  return StadiumBorder();
                } else if (states.contains(MaterialState.hovered) ||
                    states.contains(MaterialState.focused)) {
                  return RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20));
                }
                return RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10));
              }),
              padding: MaterialStateProperty.all(EdgeInsets.all(20))),
          onPressed: () async {
            await launch('https://t.me/joinchat/_6F7xO3nItY4MjFl');
          },
          icon: SvgPicture.asset(telegramSVG),
          label: Text(
            "Join Us Here",
            textScaleFactor: 2.2,
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 100, height: 1, color: mainDarkColor),
              SizedBox(
                width: 15,
              ),
              MyText(
                'OR',
                scale: 1.5,
                color: mainDarkColor,
              ),
              SizedBox(
                width: 15,
              ),
              Container(width: 100, height: 1, color: mainDarkColor),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        QrImage(
          data: telegramLink,
          size: width * 0.12 < 250 ? 250 : width * 0.12,
          backgroundColor: Colors.white,
        ),
      ],
    );
  }

  Widget githubWidget(double width) {
    return Column(
      children: [
        TextButton.icon(
          style: ButtonStyle(
              animationDuration: Duration(milliseconds: 300),
              elevation: MaterialStateProperty.resolveWith<double>((states) {
                if (states.contains(MaterialState.pressed)) {
                  return 8;
                } else if (states.contains(MaterialState.hovered)) {
                  return 4;
                }
                return 0;
              }),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              shape:
                  MaterialStateProperty.resolveWith<OutlinedBorder>((states) {
                if (states.contains(MaterialState.pressed)) {
                  return StadiumBorder();
                } else if (states.contains(MaterialState.hovered)) {
                  return RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20));
                }
                return RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10));
              }),
              padding: MaterialStateProperty.all(EdgeInsets.all(20))),
          onPressed: () async {
            await launch(githubLink);
          },
          icon: SvgPicture.asset(
            githubSVG,
          ),
          label: Text(
            "Contribute Here",
            textScaleFactor: 2.2,
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 100, height: 1, color: mainDarkColor),
              SizedBox(
                width: 15,
              ),
              MyText(
                'OR',
                scale: 1.5,
                color: mainDarkColor,
              ),
              SizedBox(
                width: 15,
              ),
              Container(width: 100, height: 1, color: mainDarkColor),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        QrImage(
          data: githubLink,
          size: width * 0.12 < 250 ? 250 : width * 0.12,
          backgroundColor: Colors.white,
        ),
      ],
    );
  }

  Widget screenLayout(Size size) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.center,
        runSpacing: 50,
        spacing: 50,
        runAlignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          cardWidget(size),
          textWidgets(),
          telegramWidget(size.width),
          githubWidget(size.width)
        ],
      ),
    );
  }

  int a = 0;

  @override
  Widget build(BuildContext context) {
    theme = Provider.of<MyTheme>(context);
    if (a == 0 || originalSize == null) {
      originalSize = MediaQuery.of(context).size;
      a++;
    }
    return Scaffold(
      body: NestedScrollView(
          physics: BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                collapsedHeight: 100,
                expandedHeight: 140,
                title: Text(
                  "Dev Society",
                  textScaleFactor: 1.5,
                ),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    "A Group of Geeks Joined together for all tech innovation",
                  ),
                ),
                actions: [
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
            ];
          },
          body: screenLayout(MediaQuery.of(context).size)),
    );
  }
}
