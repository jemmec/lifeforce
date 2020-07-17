import 'package:flutter/material.dart';
import 'package:lifeforce/util/MultiTouch.dart';
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

class _LifeBoxState extends State<LifeBox> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Tween<double> tweenDouble = Tween(begin: .6, end: 1);
  Tween<Offset> tweenOffset = Tween(begin: Offset(0, -200), end: Offset(0, 0));

  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 450,
        ));
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<Player>(
      builder: (BuildContext context, Widget child, Player player) {
        return ScaleTransition(
          scale: tweenDouble.animate(
            CurvedAnimation(
              parent: controller,
              curve: Curves.easeOutBack,
            ),
          ),
          child: Container(
            color: player.color.shade300,
            child: RotatedBox(
              quarterTurns: widget.orientation.index,
              child: Stack(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Center(
                            child: Icon(
                              Icons.remove,
                              size: 128,
                              color: player.color.shade400,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Center(
                            child: Icon(
                              Icons.add,
                              size: 128,
                              color: player.color.shade400,
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
                            fontSize: 104,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  //player name
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "/${player.name}",
                      style: TextStyle(
                        color: player.color.shade500,
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
                            if (touchCount == 1)
                              player.decreaseLife(1);
                            else if (touchCount == 2) player.decreaseLife(5);
                          },
                          onMultiLongTap: (touchCount) {
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
                            if (touchCount == 1)
                              player.increaseLife(1);
                            else if (touchCount == 2) player.increaseLife(5);
                          },
                          onMultiLongTap: (touchCount) {
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
