import 'package:flutter/material.dart';

class LifeBox extends StatefulWidget {
  LifeBox({
    Key key,
    this.orientation,
  }) : super(key: key);

  final LifeBoxOrientation orientation;

  @override
  _LifeBoxState createState() => _LifeBoxState();
}

enum LifeBoxOrientation { Down, Left, Up, Right }

class _LifeBoxState extends State<LifeBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RotatedBox(
        quarterTurns: widget.orientation.index,
        child: Center(
          child: Text("${widget.orientation.toString()}"),
        ),
      ),
    );
  }
}
