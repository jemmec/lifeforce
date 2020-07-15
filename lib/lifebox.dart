import 'package:flutter/material.dart';
import 'package:lifeforce/main.dart';

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
  int lifeTotal = 40;

  void reset() {
    print("Resting lifeBox");
    setState(() {
      lifeTotal = 99;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey.shade600,
      child: RotatedBox(
          quarterTurns: widget._orientation.index,
          child: Stack(children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Center(
                      child: Icon(
                        Icons.remove,
                        size: 100,
                        color: Colors.blueGrey.shade700,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Center(
                      child: Icon(
                        Icons.add,
                        size: 100,
                        color: Colors.blueGrey.shade700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Center(
                child: Container(
              // color: Colors.black,
              child: Text(
                "$lifeTotal",
                style: TextStyle(
                    fontSize: 104,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            )),
            Row(
              children: <Widget>[
                Expanded(
                    child: FlatButton(
                  onPressed: () {
                    setState(() {
                      lifeTotal--;
                    });
                  },
                  onLongPress: () {
                    setState(() {
                      lifeTotal -= 5;
                    });
                  },
                  child: Container(),
                )),
                Expanded(
                    child: FlatButton(
                  onPressed: () {
                    setState(() {
                      lifeTotal++;
                    });
                  },
                  onLongPress: () {
                    setState(() {
                      lifeTotal += 5;
                    });
                  },
                  child: Container(),
                )),
              ],
            ),
          ])),
    );
  }
}
