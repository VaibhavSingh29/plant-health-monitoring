

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:planthealth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'main.dart';
import 'newplant.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var plant_data=null;
  var user_name="";

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    get_user_name();
    get_plants();


  }

  void get_user_name() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var _user_name = prefs.getString('user_name');
    setState(() {
      user_name= "Hello " + _user_name;
    });
  }

  //Fetching users plants
    Future<void> get_plants() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString("user_id");

    var url = Uri.parse('https://zlnhbt4ogh.execute-api.us-east-1.amazonaws.com/get_plants?user_id=$user_id');
    var response= await http.get(url);

    var json_data= json.decode(response.body);

    setState((){
      plant_data= json_data['plants'];

      print("Data set");
      print(response.body);
    });
    }
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
              Text(user_name,
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Righteous',
                  )),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 30,
                child: Row(
                  children: [
                    FlatButton(
                      color: Colors.lightGreenAccent,
                      onPressed: ()
                      {
                        get_plants();
                        print(plant_data);
                      },
                      child: Text(
                        'Refresh'
                      ),
                    ),

                    SizedBox(width: 20,),
                    FlatButton(
                      color: Colors.redAccent,
                      child: Text('Logout'),
                      onPressed: (){
                        logout();
                      },
                    )
                  ],
                )
              ),
              Container(
                height: 400,
                child: getWidget()
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

  //Returns list of plants or progress indicator based on API response
  getWidget()
  {
    if(plant_data!=null)
      {
        return ListView.builder(
          itemCount: plant_data.length,
          itemBuilder: (context, index) {
            //TODO
            //Fetch plant name, temperature, nickname from json DONE
            //Compute percent based on min, max and current values of all data DONE
            //If last_updated==0 return 'Waiting for data' DONE
            //If data.length == 0 return 'Waiting for data' DONE
            //Pass the plant data to details page
            //Add refresh button DONE
            //Add logout button DONE

            String plant_name= plant_data[index]['plant_name'];
            String plant_nick_name = plant_data[index]['nick_name'];
            String last_updated = plant_data[index]['last_updated'];
            String ideal_temp = plant_data[index]['ideal_data']['temperature_range'];
            String plant_temperature=null;
            if(plant_data[index]['data'].length!=0)
              {
                plant_temperature= plant_data[index]['data']['temperature'];
              }
            return get_card(plant_name, plant_nick_name, plant_temperature, ideal_temp, last_updated, index);
          },
        );
      }
    else
      {
        return Container(height:50, width:50,child: CircularProgressIndicator());
      }
  }

  //Returns list elements
  get_card(String plant_name, String plant_nick_name, String plant_temperature, String ideal_temp, String last_updated, int index)
  {
   if(plant_temperature==null)
     {
       return Card(
           color: Colors.grey,
           child: ListTile(
             title: Text(
                 plant_name),
             subtitle: Align(
               alignment: Alignment.centerLeft,
               child: Row(
                 children: [
                   Text(
                       plant_nick_name,
                       style: TextStyle(
                         color: Colors.black54,
                       )
                   ),
                   SizedBox(width: 10,),
                   Text(
                       "Waiting for sensor data!" ,
                       style: TextStyle(
                         color: Colors.lightGreenAccent,
                       )
                   ),


                 ],
               ),
             ),
             leading: CircularPercentIndicator(
               animation: true,
               animationDuration: 1200,
               radius: 40.0,
               lineWidth: 4.0,
               percent: 0.0,
               circularStrokeCap: CircularStrokeCap.round,
               center: new Text("!"),
               footer: Text("Temp"),
               progressColor: Colors.green,
             ),

           )
       );
     }
   else
     {
       var gauge_data= compute_gauge_data(plant_temperature, ideal_temp);
       print(gauge_data);
       return Card(
           color: Colors.grey,
           child: ListTile(
             title: Text(
                 plant_name),
             subtitle: Align(
               alignment: Alignment.centerLeft,
               child: Row(
                 children: [
                   Text(
                       plant_nick_name,
                       style: TextStyle(
                         color: Colors.black54,
                       )
                   ),
                   SizedBox(width: 10,),

                   get_status(last_updated),



                 ],
               ),
             ),
             leading: CircularPercentIndicator(
               animation: true,
               animationDuration: 1200,
               radius: 40.0,
               lineWidth: 4.0,
               percent: gauge_data[0].toDouble(),
               circularStrokeCap: CircularStrokeCap.round,
               center: new Text(gauge_data[1]),
               footer: Text("Temp"),
               progressColor: Colors.green,
             ),
             trailing: FlatButton(
               color: Color(0xffF8DB3B),
               splashColor: Colors.black,
               shape: RoundedRectangleBorder(
                   borderRadius:
                   BorderRadius.all(Radius.circular(50))),
               onPressed: () {
                 Navigator.push(
                     context,
                     MaterialPageRoute(
                         builder: (context) => MyHomePage(plant_data: plant_data[index],)));
               },
               child: Text(
                 'Details',
                 style: TextStyle(
                     color: Colors.black87, fontSize: 15),
               ),
             ),
           )
       );
     }
  }

  compute_gauge_data(String plant_temperature, String ideal_temp)
  {
    int temp= int.parse(plant_temperature);
    var ideal_temp_values = ideal_temp.split("-");
    int temp_low = int.parse(ideal_temp_values[0]);
    int temp_high = int.parse(ideal_temp_values[1]);


    if(temp < temp_low)
      {
        return [0, "🥶"];
      }
    else if(temp > temp_high)
      {
        return [1, "😭"];
      }
    else
      {
        List gauge_valus=[];

        double percent= (temp - temp_low )/ temp_high;
        gauge_valus.add(percent.toDouble());
        gauge_valus.add((percent * 100).toStringAsFixed(1));
        print(gauge_valus.toString());
        return gauge_valus;
      }
  }

  void logout() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage()));

  }

  Widget get_status(String last_updated)
  {
    DateTime last_updated_time = DateTime.parse(last_updated);
    int time_diff =  DateTime.now().difference(last_updated_time).inSeconds;
    print(DateTime.now());
    print(last_updated_time);
    print(time_diff);
    if(last_updated=="0")
       {
         return Text(
             "Inactive" ,
             style: TextStyle(
               color: Colors.redAccent,
             )
         );
       }
     else if(time_diff > 19810)
       {
         return Text(
             "Disconnected",
             style: TextStyle(
               color: Colors.redAccent,
             )
         );
       }
     else
       {
        return Text(
            "Connected",
            style: TextStyle(
              color: Colors.lightGreenAccent,
            )
        );
       }
  }

}
