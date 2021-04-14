import 'package:flutter/material.dart';

import 'home.dart';
import 'plant.dart';

class NewPlant extends StatefulWidget {
  @override
  _NewPlantState createState() => _NewPlantState();
}

class _NewPlantState extends State<NewPlant> {
  String plantName = 'Select Plant';
  String nickName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(children: [
          Image.asset(
            'assets/images/background.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 200,
                child: Image.asset(
                  'assets/images/background1.jpg',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              Text('Add new plant',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Righteous',
                  )),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: DropdownButton<String>(
                  value: plantName,
                  // isDense: true,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down_rounded),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.grey, fontSize: 15),
                  underline: Container(
                    height: 2,
                    color: Colors.black87,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      plantName = newValue;
                    });
                  },
                  items: <String>[
                    'Select Plant',
                    'Aloe vera',
                    'cactus',
                    'Money plant',
                    'Rose',
                    'Tulsi',
                    'Mint',
                    'Tomato',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextField(
                    onChanged: (nickname) => {nickName = nickname},
                    decoration: InputDecoration(
                      hintText: 'Name',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87),
                      ),
                    )),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    color: Color(0xffF8DB3B),
                    splashColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    onPressed: () {
                      Plant plant = Plant(plantName, nickName);
                      PlantList.addPlant(plant);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Text(
                        'Next',
                        style: TextStyle(color: Colors.black87, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
