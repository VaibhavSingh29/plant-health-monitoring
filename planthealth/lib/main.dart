import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:planthealth/home.dart';
import 'package:planthealth/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
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

        primarySwatch: Colors.blue,
      ),
      home: splashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.plant_data}) : super(key: key);

  final String title;
  final Map plant_data;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    var plant_data=widget.plant_data;
    var sensor_data = plant_data['data'];
    var ideal_data = plant_data['ideal_data'];
    String plant_name = plant_data['plant_name'];
    String pot_id = plant_data['pot_id'];
    String last_updated = plant_data['last_updated'];
    List temperature_gauge = get_gauge_data(sensor_data['temperature'], ideal_data['temperature_range'], 0);
    List light_gauge = get_gauge_data(sensor_data['light'], ideal_data['light_range'], 1);
    List humidity_gauge = get_gauge_data(sensor_data['humidity'], ideal_data['humidity_range'], 2);
    var suggesstions = plant_data['suggesstions'];

    print(plant_data['suggesstions']);
    
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
                Text(plant_name,
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Righteous',
                    )),
                Text('Status:' + get_status(last_updated),
                    style: TextStyle(
                      fontSize: 15,
                      // fontFamily: 'Righteous',
                    )),
                FlatButton(
                  color: Color(0xffF8DB3B),
                  splashColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  onPressed: ()
                  {
                    remove_plant(pot_id);
                  },
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
                Text(suggesstions[3],
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                //Temperature gauge
                Row(
                  children: [
                    SizedBox(width: 20,),
                    CircularPercentIndicator(

                      animation: true,
                      animationDuration: 1200,
                      radius: 80.0,
                      lineWidth: 7.0,
                      percent: temperature_gauge[0].toDouble(),
                      circularStrokeCap: CircularStrokeCap.round,
                      center: new Text(temperature_gauge[1], style:
                        TextStyle(
                          fontSize: 20
                        ),
                      ),
                      footer: Text("Temperature"),
                      progressColor: Colors.redAccent,
                    ),
                    SizedBox(width: 20,),
                    Text(suggesstions[0],
                    style: TextStyle(
                      fontSize: 20
                    ),
                    )
                  ],
                ),

                SizedBox(height: 20),

                //Humidity gauge
                Row(
                  children: [
                    SizedBox(width: 20,),
                    CircularPercentIndicator(
                      animation: true,
                      animationDuration: 1200,
                      radius: 80.0,
                      lineWidth: 7.0,
                      percent: humidity_gauge[0].toDouble(),
                      circularStrokeCap: CircularStrokeCap.round,
                      center: new Text(humidity_gauge[1]),
                      footer: Text("Humidity"),
                      progressColor: Colors.blue[600],
                    ),
                    SizedBox(width: 20,),
                    Text(suggesstions[1],
                      style: TextStyle(
                          fontSize: 20
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),

                //Light gauge
                Row(
                  children: [
                    SizedBox(width: 20,),
                    CircularPercentIndicator(
                      animation: true,
                      animationDuration: 1200,
                      radius: 80.0,
                      lineWidth: 7.0,
                      percent: light_gauge[0].toDouble(),
                      circularStrokeCap: CircularStrokeCap.round,
                      center: new Text(light_gauge[1]),
                      footer: Text("Sunlight"),
                      progressColor: Colors.yellowAccent,
                    ),
                    SizedBox(width: 20,),
                    Text(suggesstions[2],
                      style: TextStyle(
                          fontSize: 20
                      ),
                    )
                  ],
                ),

              ],
            ),
          ),
        ],
      ),
    ));
  }

  String get_status(String last_updated)
  {
    if(last_updated=="0")
      {
        return "Inactive";
      }
    else
      {
        return "Active";
      }

  }

  void remove_plant(String pot_id) async
  {
    SharedPreferences prefs= await SharedPreferences.getInstance();
    String user_id = prefs.getString('user_id');
    var url = Uri.parse('https://zlnhbt4ogh.execute-api.us-east-1.amazonaws.com/delete_plant');
    var response= await http.post(url, body: '{"user_id": "$user_id", "pot_id": "$pot_id"}');
    if(response.statusCode==200)
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Plant deleted!")));
      Navigator.pop(context);
    }
    else
      {
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong, Plz try again!")));
      }
  }

  List get_gauge_data(value, ideal_values, int i)
  {
    int val = int.parse(value);
    print(value);
    print(ideal_values);
    var ideal_values_list = ideal_values.split("-");
    int low = int.parse(ideal_values_list[0]);
    int high = int.parse(ideal_values_list[1]);


    if(val < low)
    {
      return [0, "❌"];
    }
    else if(val > high)
    {
      return [1, "❌"];
    }
    else
    {
      List gauge_valus=[];
      double percent= (val - low )/ high;
      gauge_valus.add(percent);
      gauge_valus.add((percent * 100).toStringAsFixed(2));
      return gauge_valus;
    }
  }
}
