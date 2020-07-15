import 'package:flutter/material.dart';

class LifeBox extends StatefulWidget {
  LifeBox({Key key, this.index}) : super(key: key);

  final int index;

  @override
  _LifeBoxState createState() => _LifeBoxState();
}

class _LifeBoxState extends State<LifeBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Text("HI"),
    ));
  }
}
