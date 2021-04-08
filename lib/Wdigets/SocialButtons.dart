import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class GithubButton extends StatelessWidget {
  const GithubButton({Key key}) : super(key: key);

  final String githubLink = 'https://www.github.com/devsociety-we';
  final String githubSVG = 'assets/github.svg';
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
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
          shape: MaterialStateProperty.resolveWith<OutlinedBorder>((states) {
            if (states.contains(MaterialState.pressed)) {
              return StadiumBorder();
            } else if (states.contains(MaterialState.hovered)) {
              return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20));
            }
            return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10));
          }),
          padding: MaterialStateProperty.all(EdgeInsets.all(10))),
      onPressed: () async {
        await launch(githubLink);
      },
      icon: SvgPicture.asset(
        githubSVG,
        color: Colors.white,
      ),
      label: Text(
        "Contribute Here",
        textScaleFactor: 2.2,
      ),
    );
  }
}

class TelegramButton extends StatelessWidget {
  const TelegramButton({Key key}) : super(key: key);
  final String telegramSVG = 'assets/telegram.svg';
  final String telegramLink = "https://t.me/joinchat/_6F7xO3nItY4MjFl";
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
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
          backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
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
          shape: MaterialStateProperty.resolveWith<OutlinedBorder>((states) {
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
          padding: MaterialStateProperty.all(EdgeInsets.all(10))),
      onPressed: () async {
        await launch(telegramLink);
      },
      icon: SvgPicture.asset(telegramSVG),
      label: Text(
        "Join Us Here",
        textScaleFactor: 2.2,
      ),
    );
  }
}
