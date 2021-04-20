import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewPlant extends StatefulWidget {
  @override
  _NewPlantState createState() => _NewPlantState();
}

class _NewPlantState extends State<NewPlant> {
  String _botanical_name = 'Select Plant';
  String _nickName = '', _pot_id = '', _plant_name = '';

  void add_plant() async {
    if (_botanical_name == 'Select Plant' &&
        _pot_id == '' &&
        _plant_name == '') {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please select all fields!")));
    } else {
      var url = Uri.parse(
          'https://zlnhbt4ogh.execute-api.us-east-1.amazonaws.com/create_plant');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String _user_id = prefs.getString('user_id');
      var response = await http.post(url,
          body:
              '{"pot_id": "$_pot_id", "user_id": "$_user_id", "botanical_name": "$_botanical_name","nick_name": "$_nickName", "plant_name": "$_plant_name"}');

      print(response.body);
      Navigator.pop(context);
    }
  }

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
              Text('Add a new plant',
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
                  value: _botanical_name,
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
                      _botanical_name = newValue;
                    });
                  },
                  items: <String>[
                    'Select Plant',
                    'Aloe V',
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
              //Plant name
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextField(
                    onChanged: (plant_name) => {_plant_name = plant_name},
                    decoration: InputDecoration(
                      hintText: 'Plant name',
                      filled: true,
                      fillColor: Colors.grey[200],
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87),
                      ),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              //Pot id
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextField(
                    onChanged: (pot_id) => {_pot_id = pot_id},
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: 'Pot ID',
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              //Nickname
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextField(
                    onChanged: (nickname) => {_nickName = nickname},
                    decoration: InputDecoration(
                      filled: true,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87),
                      ),
                      fillColor: Colors.grey[200],
                      hintText: 'Nickname',
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
                      //Create plant
                      add_plant();
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Text(
                        'Add',
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
