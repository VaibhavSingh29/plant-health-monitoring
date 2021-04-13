import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // new CircularPercentIndicator(
          //   radius: 120.0,
          //   lineWidth: 13.0,
          //   animation: true,
          //   percent: 0.6,
          //   center: Icon(Icons.done_sharp),
          //   footer: new Text(
          //     "Moisture",
          //     style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
          //   ),
          //   circularStrokeCap: CircularStrokeCap.round,
          //   progressColor: Colors.green,
          // ),
          SizedBox(
            height: 50,
          ),
          Text('Hello, User',
              style: TextStyle(
                fontSize: 40,
                fontFamily: 'Righteous',
              )),
          SizedBox(
            height: 30,
          ),
          Card(
            child: Column(
              children: [
                Text('Aloe Vera',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Righteous',
                    )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new CircularPercentIndicator(
                      radius: 45.0,
                      animation: true,
                      animationDuration: 1200,
                      lineWidth: 4.0,
                      percent: 0.10,
                      center: new Text("10%"),
                      footer: Text("moisture"),
                      progressColor: Colors.red,
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                    new Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                    ),
                    new CircularPercentIndicator(
                      animation: true,
                      animationDuration: 1200,
                      radius: 45.0,
                      lineWidth: 4.0,
                      percent: 0.30,
                      center: new Text("30%"),
                      footer: Text("sunlight"),
                      progressColor: Colors.orange,
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                    new Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                    ),
                    new CircularPercentIndicator(
                      animation: true,
                      radius: 45.0,
                      animationDuration: 1200,
                      lineWidth: 4.0,
                      percent: 0.60,
                      center: new Text("60%"),
                      footer: Text("temperature"),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.yellow,
                    ),
                    new Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                    ),
                    new CircularPercentIndicator(
                      animation: true,
                      animationDuration: 1200,
                      radius: 45.0,
                      lineWidth: 4.0,
                      percent: 0.90,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: new Text("90%"),
                      footer: Text("health"),
                      progressColor: Colors.green,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
