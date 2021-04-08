import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  CardWidget({Key key}) : super(key: key);

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  bool showFront = true;
  bool hovering = false;
  Widget _buildCardFront() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.contain, image: AssetImage('assets/CardFront.png'))),
    );
  }

  Widget _buildCardBackground() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.contain, image: AssetImage('assets/CardBack.png'))),
    );
  }

  double _getContainerHeight(double width) {
    double height = 400;
    if (width < 500) {
      height = width * 0.5;
    } else if (width < 600) {
      height = width * 0.45;
    } else if (width < 700) {
      height = width * 0.40;
    } else if (width < 800) {
      height = width * 0.35;
    } else if (width < 900) {
      height = width * 0.30;
    } else {
      height = width * 0.25;
    }
    return height;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LayoutBuilder(builder: (context, constrainst) {
      print(size.width);
      print(constrainst.maxWidth);
      print(constrainst.maxWidth * 0.5);
      return Container(
        height: _getContainerHeight(constrainst.maxWidth),
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
                  final value = isUnder
                      ? min(rotateAnim.value, pi / 2)
                      : rotateAnim.value;
                  return Transform(
                    transform: Matrix4.rotationY(value),
                    child: child,
                    alignment: Alignment.center,
                  );
                },
              );
            },
            child: MouseRegion(
              key: ValueKey(showFront),
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
                  key: ValueKey(hovering),
                  onTap: () => setState(() {
                    showFront = !showFront;
                  }),
                  child: Stack(
                    children: [
                      Container(
                        child: showFront
                            ? _buildCardFront()
                            : _buildCardBackground(),
                      ),
                      hovering
                          ? Container(
                              alignment: Alignment.centerRight,
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5)),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 50,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
