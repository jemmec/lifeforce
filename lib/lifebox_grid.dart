import 'package:flutter/material.dart';
import 'package:lifeforce/models/life_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'lifebox.dart';
import 'models/player_model.dart';

class LifeBoxGrid extends StatefulWidget {
  LifeBoxGrid({
    Key key,
  }) : super(key: key);

  @override
  _LifeBoxGridState createState() => _LifeBoxGridState();
}

class _LifeBoxGridState extends State<LifeBoxGrid>
    with TickerProviderStateMixin {
  var columns = <Widget>[];

  double boxMargin = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<LifeModel>(
      builder: (BuildContext context, Widget child, LifeModel model) {
        //LEAVE ME GAPPS

        final lifeboxes = List<LifeBox>(model.maxPlayers);
        for (int i = 0; i < lifeboxes.length; i++) {
          lifeboxes[i] = LifeBox();
        }

        columns.clear();

        bool evenPlayers = model.currentPlayers % 2 == 0;

        if (model.currentPlayers == 1) {
          columns.add(
            Expanded(
              child: Container(
                margin: EdgeInsets.all(boxMargin),
                child: ScopedModel<Player>(
                  model: model.players[0],
                  child: lifeboxes[0].setOrientation(LifeBoxOrientation.Down),
                ),
              ),
            ),
          );
        } else if (model.currentPlayers == 2) {
          columns.add(
            Expanded(
              child: Container(
                margin: EdgeInsets.all(boxMargin),
                child: ScopedModel<Player>(
                  model: model.players[0],
                  child: lifeboxes[0].setOrientation(LifeBoxOrientation.Up),
                ),
              ),
            ),
          );
          columns.add(
            Expanded(
              child: Container(
                margin: EdgeInsets.all(boxMargin),
                child: ScopedModel<Player>(
                  model: model.players[1],
                  child: lifeboxes[1].setOrientation(LifeBoxOrientation.Down),
                ),
              ),
            ),
          );
        } else {
          //Theoretically can never go above the amount of players
          int count = 0;
          //create the top player if uneven number of players
          if (!evenPlayers) {
            columns.add(
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(boxMargin),
                  child: ScopedModel<Player>(
                    model: model.players[count],
                    child:
                        lifeboxes[count].setOrientation(LifeBoxOrientation.Up),
                  ),
                ),
              ),
            );
          } else {
            //TODO: FIX THIS TERRIBLE THING I HAVE DONE
            count = -1;
          }

          //Create the rest of the players
          for (int i = 0; i < (model.currentPlayers / 2).floor(); i++) {
            columns.add(
              Expanded(
                child: Container(
                  child: Row(
                    children: List.generate(
                      2,
                      (index) => Expanded(
                        child: Container(
                          margin: EdgeInsets.all(boxMargin),
                          child: ScopedModel<Player>(
                            model: model.players[++count],
                            child: lifeboxes[count].setOrientation(index == 0
                                ? LifeBoxOrientation.Left
                                : LifeBoxOrientation.Right),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        }

        return Container(
          child: Column(children: columns),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
