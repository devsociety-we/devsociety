import 'dart:ui';

import 'package:devsociety/GetItC.dart';
import 'package:devsociety/Utilities/Colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'Screens/About.dart';
import 'Screens/Home.dart';
import 'Services/ThemeServcie.dart';

void main() {
  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyTheme>.value(
      value: getIt<ThemeClass>().themeController.stream,
      initialData: MyTheme.Light,
      child: DevSociety(),
    );
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
    case MyTheme.Dark:
      return darkTheme;
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

class DevSociety extends StatelessWidget {
  DevSociety({Key key});

  @override
  Widget build(BuildContext context) {
    MyTheme myTheme = Provider.of<MyTheme>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      initialRoute: '/',
      title: "Dev Society | Welcome to the City of Developers",
      themeMode: getThemeMode(myTheme),
      routes: {
        '/About': (context) => AboutPage()
      },
      home: HomePage(),
    );
  }
}
