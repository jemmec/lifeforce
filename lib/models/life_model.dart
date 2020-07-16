import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'player_model.dart';

class LifeModel extends Model {
  final int maxPlayers;

  int currentPlayers = 4;

  int startLifeIndex = 2;

  List<int> startlifeTotals = [20, 30, 40];

  List<Player> players;

  List<MaterialColor> colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.purple,
    Colors.pink
  ];

  //init
  LifeModel(
      {this.maxPlayers,
      this.startLifeIndex,
      this.currentPlayers,
      this.startlifeTotals,
      this.colors}) {
    players = List<Player>(maxPlayers);
    for (int i = 0; i < maxPlayers; i++) {
      players[i] = Player(
          name: "Player/$i",
          lifeTotal: startlifeTotals[startLifeIndex],
          color: colors[i]);
    }
  }

  //Resets all of the life totals
  void resetLifeTotals() {
    if (players == null) return;
    for (Player player in players) {
      player.setLife(startlifeTotals[startLifeIndex]);
    }
    notifyListeners();
  }

  void setStartingLifeTotal(int index) {
    startLifeIndex = index;
    notifyListeners();
  }

  void setCurrentPlayers(int players) {
    currentPlayers = players;
    notifyListeners();
  }
}
