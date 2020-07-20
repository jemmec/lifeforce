import 'package:flutter/material.dart';
import 'package:lifeforce/util/multitouch.dart';
import 'models/player_model.dart';
import 'package:scoped_model/scoped_model.dart';

enum LifeBoxOrientation {
  Down,
  Left,
  Up,
  Right,
}

class LifeBox extends StatefulWidget {
  LifeBoxOrientation orientation;

  LifeBox({
    Key key,
  }) : super(key: key);

  LifeBox setOrientation(LifeBoxOrientation o) {
    orientation = o;
    return this;
  }

  @override
  _LifeBoxState createState() => _LifeBoxState();
}

class _LifeBoxState extends State<LifeBox> with TickerProviderStateMixin {
  AnimationController transitionController;
  Tween<double> tweenDouble = Tween(begin: .6, end: 1);
  Tween<Offset> tweenOffset = Tween(begin: Offset(0, -200), end: Offset(0, 0));

  AnimationController textController;
  Animation<double> textSequence;

  double animTo = 0;

  double iconSize = 68;

  double lifeFontSize = 124;
  double lifeFontMod = 0.08; //animation mod

  void initState() {
    super.initState();

    transitionController = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 500,
        ));
    transitionController.forward();

    textController = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 550,
        ))
      ..addListener(() {
        setState(() {});
      });

    calculateTextAnim();
  }

  void doTextAnim(bool up) {
    var n = (lifeFontSize * lifeFontMod);
    animTo = up ? lifeFontSize + n : lifeFontSize - n;
    calculateTextAnim();
    textController.reset();
    textController.forward();
  }

  void calculateTextAnim() {
    textSequence = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: lifeFontSize,
          end: animTo,
        ).chain(
          CurveTween(
            curve: Curves.easeIn,
          ),
        ),
        weight: 20,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: animTo,
          end: lifeFontSize,
        ).chain(
          CurveTween(
            curve: Curves.easeOutBack,
          ),
        ),
        weight: 80,
      ),
    ]).animate(textController);
  }

  @override
  void dispose() {
    transitionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<Player>(
      builder: (BuildContext context, Widget child, Player player) {
        return ScaleTransition(
          scale: tweenDouble.animate(
            CurvedAnimation(
                parent: transitionController,
                curve: Interval(0.0, 0.8, curve: Curves.easeOutBack)),
          ),
          child: Container(
            color: player.color.shade400,
            child: RotatedBox(
              quarterTurns: widget.orientation.index,
              child: Stack(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Icon(
                              Icons.remove,
                              size: iconSize,
                              color: player.color.shade600,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Icon(
                              Icons.add,
                              size: iconSize,
                              color: player.color.shade600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //player lifetotal
                  Center(
                    child: Container(
                      // color: Colors.black,
                      child: Text(
                        "${player.lifeTotal}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: textSequence.value,
                          fontFamily: "Russo One",
                        ),
                      ),
                    ),
                  ),
                  //player name
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "/${player.name}",
                      style: TextStyle(
                        color: player.color.shade600,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  //Dead overlay
                  player.lifeTotal <= 0
                      ? Container(
                          color: Colors.black54,
                          child: Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.sentiment_very_dissatisfied,
                                size: 200,
                                color: Color.fromRGBO(10, 10, 10, 150),
                              )),
                        )
                      : Container(),
                  // Increment & decrement buttons
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: MultiTouch(
                          onMultiTouch: (touchCount) {
                            doTextAnim(false);
                            if (touchCount == 1)
                              player.decreaseLife(1);
                            else if (touchCount == 2) player.decreaseLife(5);
                          },
                          onMultiLongTap: (touchCount) {
                            doTextAnim(false);
                            if (touchCount == 1)
                              player.decreaseLife(10);
                            else if (touchCount == 2) player.decreaseLife(20);
                          },
                          child: Container(color: Colors.transparent),
                        ),
                      ),
                      Expanded(
                        child: MultiTouch(
                          onMultiTouch: (touchCount) {
                            doTextAnim(true);
                            if (touchCount == 1)
                              player.increaseLife(1);
                            else if (touchCount == 2) player.increaseLife(5);
                          },
                          onMultiLongTap: (touchCount) {
                            doTextAnim(true);
                            if (touchCount == 1)
                              player.increaseLife(10);
                            else if (touchCount == 2) player.increaseLife(20);
                          },
                          child: Container(color: Colors.transparent),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
