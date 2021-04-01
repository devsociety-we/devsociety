import 'dart:ui';
import 'package:devsociety/GetItC.dart';
import 'package:devsociety/Utilities/CardShapes.dart';
import 'package:devsociety/Utilities/Colors.dart';
import 'package:flutter/material.dart';
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
          initialData: MyTheme.Dark,
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
      title: 'Dev Society',
      themeMode: getThemeMode(myTheme),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final ThemeClass themeClass = getIt<ThemeClass>();
  final List<Map<String, String>> admins = [
    {'url': "https://t.me/incrediblezayed", 'name': 'Hassan Ansari'},
    {'url': "https://t.me/Rockz_31", 'name': 'Atish Manala'}
  ];
  final String telegram = 'assets/telegram.svg';
  @override
  Widget build(BuildContext context) {
    MyTheme theme = Provider.of<MyTheme>(context);
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          physics: BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                collapsedHeight: kToolbarHeight,
                expandedHeight: 100,
                flexibleSpace: LayoutBuilder(builder: (context, snapshot) {
                  return FlexibleSpaceBar(
                      title: Text(
                        "Dev Society",
                        textScaleFactor: snapshot.maxHeight * 0.015,
                      ),
                      titlePadding:
                          EdgeInsetsDirectional.only(start: 35, bottom: 16));
                }),
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
                          key: UniqueKey(),
                        )),
                  ),
                ],
              ),
            ];
          },
          body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 500,
                  height: 100,
                  child: Wrap(
                      children: List<Widget>.generate(
                    2,
                    (index) => AspectRatio(
                      aspectRatio: 23 / 15,
                      child: Card(
                        elevation: 4,
                        child: LayoutBuilder(builder: (context, constraints) {
                          return Container(
                            child: Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                Container(
                                  color: Colors.white,
                                  width: constraints.maxWidth,
                                  height: constraints.maxHeight,
                                  child: CustomPaint(
                                    painter: RPSCustomPainter(),
                                    size: Size(constraints.maxWidth,
                                        constraints.maxHeight),
                                    isComplex: true,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ).toList()

/*                      [
                      AspectRatio(
                        aspectRatio: 7 / 3,
                        child: Card(
                          elevation: 4,
                          child: Container(
                            child: Stack(
                              children: [
                                Container(
                                  color: Colors.red,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      AspectRatio(
                        aspectRatio: 7 / 3,
                        child: Card(
                          elevation: 4,
                          child: Stack(
                            children: [
                              Container(
                                color: Colors.red,
                              )
                            ],
                          ),
                        ),
                      ),
                    ], */
                      ),
                ),
                SizedBox(
                  height: 500,
                ),
                MyText(
                  "Oh The Website seems empty!",
                  scale: 3,
                  fontWeight: FontWeight.w100,
                  color: Theme.of(context).brightness == Brightness.light
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
                    MyTextSpan(text: "WE ", fontWeight: FontWeight.bold),
                    MyTextSpan(
                      text: "start adding content in ",
                      fontWeight: FontWeight.w100,
                    ),
                    MyTextSpan(text: "OUR ", fontWeight: FontWeight.bold),
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
                    MyTextSpan(text: "YOU ", fontWeight: FontWeight.bold),
                    MyTextSpan(
                      text: "and ",
                      fontWeight: FontWeight.w100,
                    ),
                    MyTextSpan(text: "US ", fontWeight: FontWeight.bold),
                    MyTextSpan(
                      text: "together and become ",
                      fontWeight: FontWeight.w100,
                    ),
                    MyTextSpan(
                        text: "ONE\nin OUR DevSociety.",
                        fontWeight: FontWeight.bold),
                  ]),
                  textScaleFactor: 2.5,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton.icon(
                  style: ButtonStyle(
                      animationDuration: Duration(milliseconds: 300),
                      elevation:
                          MaterialStateProperty.resolveWith<double>((states) {
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
                            states.contains(MaterialState.pressed)) {
                          return theme == MyTheme.Dark
                              ? Colors.white
                              : mainLightColor;
                        }
                        return Colors.transparent;
                      }),
                      foregroundColor: MaterialStateProperty.all(mainDarkColor),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                          (states) {
                        if (states.contains(MaterialState.pressed)) {
                          return StadiumBorder();
                        } else if (states.contains(MaterialState.hovered)) {
                          return RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20));
                        }
                        return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5));
                      }),
                      padding: MaterialStateProperty.all(EdgeInsets.all(20))),
                  onPressed: () async {
                    await launch('https://t.me/joinchat/_6F7xO3nItY4MjFl');
                  },
                  icon: SvgPicture.asset(telegram),
                  label: MyText(
                    "Join Us Here",
                    scale: 2.2,
                    color: mainDarkColor,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
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
                  data: "https://t.me/joinchat/_6F7xO3nItY4MjFl",
                  size: 250,
                  backgroundColor: Colors.white,
                ),
/*               Wrap(
                    children: admins
                        .map((e) => InkWell(
                              onTap: () async {
                                await launch(e['url']);
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  QrImage(
                                    data: e['url'],
                                    size: 250,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(telegram),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      MyText(
                                        e['name'],
                                        scale: 2,
                                        color: mainDarkColor,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ))
                        .toList()) */
              ],
            ),
          ),
        ),
      ),
    );
  }
}
