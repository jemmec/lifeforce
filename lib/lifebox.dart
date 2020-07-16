import 'package:flutter/material.dart';
import 'models/player_model.dart';
import 'package:scoped_model/scoped_model.dart';

class LifeBox extends StatefulWidget {
  LifeBox({
    Key key,
  }) : super(key: key);

  LifeBoxOrientation _orientation;

  LifeBox setOrientation(LifeBoxOrientation o) {
    _orientation = o;
    return this;
  }

  @override
  _LifeBoxState createState() => _LifeBoxState();
}

enum LifeBoxOrientation { Down, Left, Up, Right }

class _LifeBoxState extends State<LifeBox> {
  @override
  void dispose() {
    super.dispose();
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<Player>(
      builder: (BuildContext context, Widget child, Player player) {
        return Container(
          color: Colors.blueGrey.shade600,
          child: RotatedBox(
            quarterTurns: widget._orientation.index,
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
                            color: Colors.blueGrey.shade500,
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
                            color: Colors.blueGrey.shade500,
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
                      color: Colors.blueGrey.shade500,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        onPressed: () {
                          player.decreaseLife(1);
                        },
                        onLongPress: () {
                          player.decreaseLife(5);
                        },
                        child: Container(),
                      ),
                    ),
                    Expanded(
                      child: FlatButton(
                        onPressed: () {
                          player.increaseLife(1);
                        },
                        onLongPress: () {
                          player.increaseLife(5);
                        },
                        child: Container(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
