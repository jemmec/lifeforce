import 'package:scoped_model/scoped_model.dart';

class Player extends Model {
  String name;
  int lifeTotal;

  //init
  Player({this.lifeTotal, this.name});

  void setLife(int amount) {
    lifeTotal = amount;
    notifyListeners();
  }

  void increaseLife(int amount) {
    lifeTotal += amount;
    notifyListeners();
  }

  void decreaseLife(int amount) {
    lifeTotal -= amount;
    notifyListeners();
  }
}
