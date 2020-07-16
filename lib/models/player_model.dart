import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Player extends Model {
  String name;
  int lifeTotal;
  MaterialColor color;

  //init
  Player({this.lifeTotal, this.name, this.color});

  void setLife(int amount) {
    lifeTotal = amount;
    notifyListeners();
  }

  void increaseLife(int amount) {
    lifeTotal += amount;
    if (lifeTotal > 999) lifeTotal = 999;
    notifyListeners();
  }

  void decreaseLife(int amount) {
    lifeTotal -= amount;
    if (lifeTotal < -999) lifeTotal = -999;
    notifyListeners();
  }
}
