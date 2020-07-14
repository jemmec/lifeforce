import 'package:flutter/material.dart';
import 'package:lifeforce/life_box_grid.dart';

const _darkGrey = Color.fromRGBO(68, 68, 68, 1.0);
const _midGrey = Color.fromRGBO(112, 112, 112, 1.0);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lifeforce',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Lifeforce'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
                    color: Colors.tealAccent,
                    height: 56,
                    child: LifeBoxGrid(
                      tuples: 4,
                    ),
                  ),
                ),
              ],
            ),
            Align(
                alignment: Alignment.center,
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.pink,
                  child: Icon(
                    Icons.autorenew,
                    size: 36,
                  ),
                  onPressed: () {},
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
                                      color: Colors.lime,
                                    ),
                                  ),
                                  Container(
                                    height: (56 * 6).toDouble(),
                                    color: Colors.lime,
                                    child: SizedBox.expand(
                                      child: Column(
                                        children: <Widget>[],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
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
