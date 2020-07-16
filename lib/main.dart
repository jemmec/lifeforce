import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifeforce/lifebox_grid.dart';
import 'package:lifeforce/models/life_model.dart';
import 'package:scoped_model/scoped_model.dart';

//Instantiate the life model on app start
LifeModel _lifeModel;

//App constants
void main() {
  print("Starting app...");
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  _lifeModel = LifeModel(
      maxPlayers: 6,
      currentPlayers: 4,
      startLifeIndex: 2,
      startlifeTotals: [
        20,
        30,
        40,
      ],
      colors: [
        Colors.green,
        Colors.yellow,
        Colors.purple,
        Colors.red,
        Colors.blue,
        Colors.orange,
      ]);
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<LifeModel>(
      model: _lifeModel,
      child: MaterialApp(
        title: 'Lifeforce',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LifeForce(title: 'Lifeforce'),
      ),
    );
  }
}

class LifeForce extends StatefulWidget {
  LifeForce({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LifeForceState createState() => _LifeForceState();
}

class _LifeForceState extends State<LifeForce> {
  double currentPlayers_slider = 4;
  double startLifeTotal_slider = 3;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<LifeModel>(
      builder: (BuildContext context, Widget child, LifeModel model) {
        return Scaffold(
          body: SizedBox.expand(
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                          color: Colors.black,
                          height: 56,
                          child: LifeBoxGrid()),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    child: Transform.rotate(
                      angle: 5,
                      child: Icon(
                        Icons.refresh,
                        size: 36,
                      ),
                    ),
                    onPressed: () {
                      model.resetLifeTotals();
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    child: SizedBox(
                      height: 45.0,
                      width: 80.0,
                      child: RaisedButton(
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(28.0),
                          topRight: Radius.circular(28.0),
                        )),
                        child: Icon(
                          Icons.settings,
                          size: 25.0,
                          color: Colors.white,
                        ),
                        highlightElevation: 10.0,
                        onPressed: () {
                          showModalBottomSheet(
                            enableDrag: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder: (context, setState) {
                                  return Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          height: 18,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(28.0),
                                              topRight: Radius.circular(28.0),
                                            ),
                                            color: Colors.black45,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10.0),
                                          height: (56 * 6).toDouble(),
                                          color: Colors.black45,
                                          child: SizedBox.expand(
                                            // ---- SETTINGS MENU ----
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  "Players: ${model.currentPlayers}",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.cyanAccent),
                                                ),
                                                Slider.adaptive(
                                                  label:
                                                      "${currentPlayers_slider.floor()}",
                                                  min: 1,
                                                  max: model.maxPlayers
                                                      .toDouble(),
                                                  divisions:
                                                      model.maxPlayers - 1,
                                                  activeColor:
                                                      Colors.cyanAccent,
                                                  value: currentPlayers_slider,
                                                  onChanged: (val) {
                                                    setState(
                                                      () {
                                                        currentPlayers_slider =
                                                            val;
                                                        model.setCurrentPlayers(
                                                            val.floor());
                                                      },
                                                    );
                                                  },
                                                ),
                                                Text(
                                                  "Starting Life: ${model.startlifeTotals[model.startLifeIndex]}",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.cyanAccent),
                                                ),
                                                Slider.adaptive(
                                                  label:
                                                      "${startLifeTotal_slider.floor()}",
                                                  min: 1,
                                                  max: model
                                                      .startlifeTotals.length
                                                      .toDouble(),
                                                  divisions: model
                                                          .startlifeTotals
                                                          .length -
                                                      1,
                                                  activeColor:
                                                      Colors.cyanAccent,
                                                  value: startLifeTotal_slider,
                                                  onChanged: (val) {
                                                    setState(
                                                      () {
                                                        startLifeTotal_slider =
                                                            val;
                                                        model
                                                            .setStartingLifeTotal(
                                                                val.floor() -
                                                                    1);
                                                      },
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                        onLongPress: () {},
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
