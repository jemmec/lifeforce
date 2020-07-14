import 'package:flutter/material.dart';

import 'lifebox.dart';

class DynamicGrid extends StatefulWidget {
  DynamicGrid({Key key, this.tuples}) : super(key: key);

  final int tuples;

  @override
  _DynamicGridState createState() => _DynamicGridState();
}

class _DynamicGridState extends State<DynamicGrid> {
  var _lifeBoxes = <Widget>[];

  @override
  Widget build(BuildContext context) {
    //Build the lifeBoxes
    for (int i = 0; i < widget.tuples; i++) {
      this._lifeBoxes.add(LifeBox(
            index: i,
          ));
    }

    return Expanded(
      child: (Container(
        margin: EdgeInsets.all(5.0),
        color: Colors.orange,
      )),
    );
  }
}
