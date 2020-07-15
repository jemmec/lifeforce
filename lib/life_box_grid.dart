import 'package:flutter/material.dart';

import 'lifebox.dart';

class LifeBoxGrid extends StatefulWidget {
  LifeBoxGrid({Key key, this.players}) : super(key: key);
  final int players;

  void doesThisWork() {}

  @override
  _LifeBoxGridState createState() => _LifeBoxGridState();
}

class _LifeBoxGridState extends State<LifeBoxGrid> {
  var _rows = <Widget>[];
  var _columns = <Widget>[];
  var _lifeBoxes = <Widget>[];

  @override
  Widget build(BuildContext context) {
    //Build the lifeBoxes
    // for (int i = 0; i < widget.players; i++) {
    //   this._lifeBoxes.add(LifeBox(
    //         index: i,
    //       ));
    // }

    var boxMargin = 1.0;

    var boxColor = Colors.pink;

    return Container(
      child: Row(
          children: new List.generate(
              2,
              (index) => new Expanded(
                    child: Column(
                        children: new List.generate(
                            (widget.players / 2).ceil(),
                            (index) => new Expanded(
                                  child: Container(
                                    color: boxColor,
                                    margin: EdgeInsets.all(boxMargin),
                                    child: LifeBox(
                                      index: 1,
                                    ),
                                  ),
                                ))),
                  ))),
    );
  }
}
