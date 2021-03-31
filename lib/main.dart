import 'dart:ui';
import 'package:devsociety/Utilities/Colors.dart';
import 'package:flutter/material.dart';

import 'Wdigets/MyTextWidget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();
  @override
  Widget build(BuildContext context) {
    return MainClass();
  }
}

class MainClass extends StatelessWidget {
  MainClass({Key key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      key: key,
      title: 'Dev Society',
      darkTheme: ThemeData(
          primaryColor: MyColor().createMaterialColor(mainDarkColor),
          brightness: Brightness.dark),
      theme: ThemeData(
          primarySwatch: MyColor().createMaterialColor(mainLightColor),
          brightness: Brightness.light),
      home: MyHomePage(),
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
            ],
          ),
        ),
      ),
    );
  }
}
