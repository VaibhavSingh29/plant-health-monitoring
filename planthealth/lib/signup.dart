import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'home.dart';
import 'login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'login.dart';
class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _user_name,_email, _password, _confirm_password;

  void signUp() async {
    var url = Uri.parse('https://zlnhbt4ogh.execute-api.us-east-1.amazonaws.com/create_user');

    if(_password == _confirm_password)
    {
      var response= await http.post(url, body: '{"user_email": "$_email", "user_name": "$_user_name" ,"user_password": "$_password"}');

      if(response.statusCode==200)
      {
        //Save user id and user name in shared prefs
        var body= json.decode(response.body);
        print(body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.body)));
        Navigator.push(
               context, MaterialPageRoute(builder: (context) => LoginPage()));
        //Go to home screen

      }
      else
      {
        //Prompt user
        print("Failed");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.body)));

      }
    }

    //Navigator.push(
    //    context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            child: Stack(
          children: <Widget>[
            Image.asset(
              'assets/images/background.jpg',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                  child: Text('Register',
                      style: TextStyle(
                        fontSize: 60,
                        fontFamily: 'Righteous',
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextField(
                      onChanged: (username) => {
                        _user_name = username
                      },
                      style: TextStyle(
                        color: Color(0xff020061),
                      ),
                      decoration: InputDecoration(
                          // filled: true,
                          // fillColor: Colors.blueAccent,
                          labelText: 'name',
                          labelStyle: TextStyle(
                            color: Colors.green,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff020061)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff020061)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      textAlign: TextAlign.left,
                    )),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextField(
                    onChanged: (email) => {
                      _email = email
                    },
                    style: TextStyle(
                      color: Color(0xff020061),
                    ),
                    decoration: InputDecoration(
                      // filled: true,
                      // fillColor: Colors.blueAccent,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff020061)),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff020061)),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: 'email',
                      labelStyle: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextField(
                    onChanged: (pass) => {
                      _password = pass
                    },
                    style: TextStyle(
                      color: Color(0xff020061),
                    ),
                    obscureText: true,
                    decoration: InputDecoration(
                      // filled: true,
                      // fillColor: Colors.blueAccent,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff020061)),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff020061)),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: 'password',
                      labelStyle: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextField(
                    onChanged: (comfirm_password) => {
                      _confirm_password = comfirm_password
                    },
                    style: TextStyle(
                      color: Color(0xff020061),
                    ),
                    obscureText: true,
                    decoration: InputDecoration(
                      // filled: true,
                      // fillColor: Colors.blueAccent,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff020061)),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff020061)),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: 'Comfirm Password',
                      labelStyle: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: FlatButton(
                    color: Color(0xffF8DB3B),
                    splashColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    onPressed: () {
                      signUp();
                      },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(60, 10, 60, 10),
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.black87, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute<Null>(
                          builder: (BuildContext context) {
                        return LoginPage();
                      }));
                    },
                    child: Text(
                      'Already have an account? Sign in',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        )));
  }
}
