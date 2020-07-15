import 'package:flutter/material.dart';

import 'lifebox.dart';

class LifeBoxGrid extends StatefulWidget {
  LifeBoxGrid({Key key, this.players}) : super(key: key);
  final int players;

  void doesThisWork() {}

  @override
  _LifeBoxGridState createState() => _LifeBoxGridState();
}

class _LifeBoxGridState extends State<LifeBoxGrid>
    with TickerProviderStateMixin {
  var rows = <Widget>[];
  var columns = <Widget>[];
  var lifeBoxes = <Widget>[];

  double boxMargin = 2.0;
  Color boxColor = Colors.pink;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    columns.clear();

    bool evenPlayers = widget.players % 2 == 0;

    if (!evenPlayers) {
      columns.add(Expanded(
          child: Container(
        color: boxColor,
        margin: EdgeInsets.all(boxMargin),
        child: LifeBox(
          orientation: LifeBoxOrientation.Up,
        ),
      )));
    }

    for (int i = 0; i < (widget.players / 2).floor(); i++) {
      columns.add(Expanded(
          child: Container(
        child: Row(
            children: new List.generate(
                2,
                (index) => new Expanded(
                      child: Container(
                        color: boxColor,
                        margin: EdgeInsets.all(boxMargin),
                        child: LifeBox(
                          orientation: index == 0
                              ? LifeBoxOrientation.Left
                              : LifeBoxOrientation.Right,
                        ),
                      ),
                    ))),
      )));
    }

    return Container(
      child: Column(children: columns),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
