import 'dart:ui';
import 'package:devsociety/GetItC.dart';
import 'package:devsociety/Utilities/Colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Services/ThemeServcie.dart';
import 'Wdigets/MyTextWidget.dart';

void main() {
  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      StreamProvider<MyTheme>.value(
          initialData: MyTheme.System,
          value: getIt<ThemeClass>().themeController.stream),
    ], child: MainClass());
  }
}

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
    case MyTheme.System:
      return lightTheme;
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
    case MyTheme.System:
      return ThemeMode.system;
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
    return AnimatedSwitcher(
      duration: Duration(seconds: 1),
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: MaterialApp(
        key: UniqueKey(),
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        title: 'Dev Society',
        themeMode: getThemeMode(myTheme),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
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
                    textScaleFactor: snapshot.maxHeight * 0.02,
                  ),
                );
              }),
            ),
          ];
        },
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyText(
                "Oh The Website seems empty!",
                scale: 3,
                fontWeight: FontWeight.w300,
              ),
              Text.rich(
                TextSpan(children: [
                  MyTextSpan(
                    text: "Shall ",
                    fontWeight: FontWeight.w300,
                  ),
                  MyTextSpan(text: "WE ", fontWeight: FontWeight.bold),
                  MyTextSpan(
                    text: "start adding content in ",
                    fontWeight: FontWeight.w300,
                  ),
                  MyTextSpan(text: "OUR ", fontWeight: FontWeight.bold),
                  MyTextSpan(
                    text: "website?",
                    fontWeight: FontWeight.w300,
                  ),
                ]),
                textScaleFactor: 2.5,
              ),
              Text.rich(
                TextSpan(children: [
                  MyTextSpan(
                    text: "Let's join, ",
                    fontWeight: FontWeight.w300,
                  ),
                  MyTextSpan(text: "YOU ", fontWeight: FontWeight.bold),
                  MyTextSpan(
                    text: "and ",
                    fontWeight: FontWeight.w300,
                  ),
                  MyTextSpan(text: "US ", fontWeight: FontWeight.bold),
                  MyTextSpan(
                    text: "together and become ",
                    fontWeight: FontWeight.w300,
                  ),
                  MyTextSpan(
                      text: "ONE\nin OUR DevSociety.",
                      fontWeight: FontWeight.bold),
                ]),
                textScaleFactor: 2.5,
                textAlign: TextAlign.center,
              ),
              TextButton(
                  onPressed: () {
                    ThemeClass themeClass = getIt<ThemeClass>();
                    if (Theme.of(context).brightness == Brightness.dark)
                      themeClass.changeTheme(MyTheme.Light);
                    else {
                      themeClass.changeTheme(MyTheme.Dark);
                    }
                  },
                  child: MyText("Change"))
            ],
          ),
        ),
      ),
    );
  }
}
