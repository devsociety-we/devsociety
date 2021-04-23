import 'package:devsociety/GetItC.dart';
import 'package:devsociety/Services/ThemeServcie.dart';
import 'package:devsociety/Wdigets/MyTextWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KAppBar extends StatelessWidget implements PreferredSizeWidget {
  KAppBar({Key key}) : preferredSize = Size.fromHeight(170);

  @override
  final Size preferredSize;

  final ThemeClass themeClass = getIt<ThemeClass>();

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

  @override
  Widget build(BuildContext context) {
    MyTheme theme = Provider.of<MyTheme>(context);
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(10),
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
        ],
      ),
    );
  }
}
