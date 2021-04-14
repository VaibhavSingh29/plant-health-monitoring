import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:planthealth/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: splashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        body: Container(
      child: Stack(
        children: [
          Image.asset(
            'assets/images/background.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                Text('Plant Name',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Righteous',
                    )),
                Text('Status: Connected',
                    style: TextStyle(
                      fontSize: 15,
                      // fontFamily: 'Righteous',
                    )),
                FlatButton(
                  color: Color(0xffF8DB3B),
                  splashColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Text(
                      'Remove plant',
                      style: TextStyle(color: Colors.black87, fontSize: 15),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                CircularPercentIndicator(
                  animation: true,
                  animationDuration: 1200,
                  radius: 80.0,
                  lineWidth: 7.0,
                  percent: 0.90,
                  circularStrokeCap: CircularStrokeCap.round,
                  center: new Text("90%"),
                  footer: Text("Moisture"),
                  progressColor: Colors.green,
                ),
                SizedBox(height: 20),
                CircularPercentIndicator(
                  animation: true,
                  animationDuration: 1200,
                  radius: 80.0,
                  lineWidth: 7.0,
                  percent: 0.5,
                  circularStrokeCap: CircularStrokeCap.round,
                  center: new Text("50%"),
                  footer: Text("Temperature"),
                  progressColor: Colors.yellow[600],
                ),
                SizedBox(height: 20),
                CircularPercentIndicator(
                  animation: true,
                  animationDuration: 1200,
                  radius: 80.0,
                  lineWidth: 7.0,
                  percent: 0.3,
                  circularStrokeCap: CircularStrokeCap.round,
                  center: new Text("30%"),
                  footer: Text("Sunlight"),
                  progressColor: Colors.orange,
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
