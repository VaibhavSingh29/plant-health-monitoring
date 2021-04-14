import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'newplant.dart';
import 'plant.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(children: [
          Image.asset(
            'assets/images/background.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Text('Your Plants',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Righteous',
                  )),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 400,
                child: ListView.builder(
                  itemCount: PlantList.getList().length,
                  itemBuilder: (context, index) {
                    return Card(
                        color: Colors.grey,
                        child: ListTile(
                          title: Text(
                              PlantList.getInfo(index)['nick-name'].toString()),
                          subtitle: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                PlantList.getInfo(index)["plant-name"]
                                    .toString(),
                                style: TextStyle(
                                  color: Colors.black54,
                                )),
                          ),
                          leading: CircularPercentIndicator(
                            animation: true,
                            animationDuration: 1200,
                            radius: 40.0,
                            lineWidth: 4.0,
                            percent: 0.90,
                            circularStrokeCap: CircularStrokeCap.round,
                            center: new Text("90%"),
                            footer: Text("health"),
                            progressColor: Colors.green,
                          ),
                          trailing: FlatButton(
                            color: Color(0xffF8DB3B),
                            splashColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
                            },
                            child: Text(
                              'Details',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 15),
                            ),
                          ),
                        ));
                  },
                ),
              ),
            ],
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
        splashColor: Colors.black87,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewPlant()));
        },
      ),
    );
  }
}
