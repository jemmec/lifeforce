import 'package:flutter/material.dart';

import 'lifebox.dart';

class LifeBoxGrid extends StatefulWidget {
  LifeBoxGrid({Key key, this.tuples}) : super(key: key);
  final int tuples;

  void doesThisWork() {}

  @override
  _LifeBoxGridState createState() => _LifeBoxGridState();
}

class _LifeBoxGridState extends State<LifeBoxGrid> {
  var _lifeBoxes = <Widget>[];

  @override
  Widget build(BuildContext context) {
    //Build the lifeBoxes
    for (int i = 0; i < widget.tuples; i++) {
      this._lifeBoxes.add(LifeBox(
            index: i,
          ));
    }

    return Container();
  }
}
