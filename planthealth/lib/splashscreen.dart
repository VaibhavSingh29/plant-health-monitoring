import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'main.dart';

class splashScreen extends StatefulWidget {
  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    super.initState();

    _mockcheckForSession().then((status) {
      if (status) {
        _navigateToHome();
      } else {
        _navigateToHome();
      }
    });
  }

  Future<bool> _mockcheckForSession() async {
    await Future.delayed(Duration(milliseconds: 5000), () {});
    return false;
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => MyHomePage()));
  }

  Widget build(BuildContext context) {
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
          Shimmer.fromColors(
            baseColor: Color(0xff173D7B),
            highlightColor: Color(0xfffe379f),
            child: Center(
              child: Text(
                'Plant',
                style: TextStyle(fontSize: 40, fontFamily: 'Righteous'),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
