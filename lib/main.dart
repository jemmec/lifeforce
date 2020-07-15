import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifeforce/life_box_grid.dart';
import 'package:lifeforce/lifebox.dart';
import 'dart:async';
import 'package:event/event.dart';

void main() {
  print("Starting app...");
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lifeforce',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LifeForce(title: 'Lifeforce'),
    );
  }
}

class LifeForce extends StatefulWidget {
  LifeForce({Key key, this.title}) : super(key: key);

  final String title;

  static Event onResetEvent = Event();

  void reset() {
    onResetEvent.broadcast();
  }

  @override
  _LifeForceState createState() => _LifeForceState();
}

class _LifeForceState extends State<LifeForce> {
  void setPlayers(int val) {
    setState(() {
      this.players = val;
    });
  }

  int players = 4;
  double sliderVal = 4;

  int maxPlayers = 6;

  //The starting life total
  int startingLifeTotal = 40;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      child: LifeBoxGrid(
                        players: this.players,
                        maxPlayers: this.maxPlayers,
                      )),
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
                    widget.reset();
                  },
                )),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                              "Players: ${this.players}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.cyanAccent),
                                            ),
                                            Slider.adaptive(
                                              label: "${sliderVal.floor()}",
                                              min: 1,
                                              max: this.maxPlayers.toDouble(),
                                              divisions: this.maxPlayers - 1,
                                              activeColor: Colors.cyanAccent,
                                              value: sliderVal,
                                              onChanged: (val) {
                                                setState(() {
                                                  this.sliderVal = val;
                                                  this.setPlayers(val.floor());
                                                });
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                          });
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
  }
}
