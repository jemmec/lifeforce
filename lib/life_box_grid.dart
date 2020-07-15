import 'package:flutter/material.dart';
import 'package:lifeforce/main.dart';

import 'lifebox.dart';

class LifeBoxGrid extends StatefulWidget {
  LifeBoxGrid({Key key, this.players, this.maxPlayers}) : super(key: key);
  final int players;
  final int maxPlayers;

  @override
  _LifeBoxGridState createState() => _LifeBoxGridState();
}

class _LifeBoxGridState extends State<LifeBoxGrid>
    with TickerProviderStateMixin {
  var columns = <Widget>[];

  double boxMargin = 2.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lifeboxes = new List<LifeBox>(widget.maxPlayers);
    for (int i = 0; i < lifeboxes.length; i++) {
      lifeboxes[i] = LifeBox();
    }

    columns.clear();

    bool evenPlayers = widget.players % 2 == 0;

    //Theoretically can never go above the amount of players
    int count = 0;

    if (!evenPlayers) {
      columns.add(Expanded(
          child: Container(
        margin: EdgeInsets.all(boxMargin),
        child: lifeboxes[count++].setOrientation(LifeBoxOrientation.Up),
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
                          margin: EdgeInsets.all(boxMargin),
                          child: lifeboxes[count++].setOrientation(index == 0
                              ? LifeBoxOrientation.Left
                              : LifeBoxOrientation.Right)),
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
