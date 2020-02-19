import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  _SplashScreen createState() => _SplashScreen();
}
class _SplashScreen extends State<SplashScreen> {

  void initState(){
    super.initState();
    Future.delayed(
        Duration(seconds: 3),
            (){

          Navigator.push(context, MaterialPageRoute(
            builder: (context) => MyHomePage(),

          ),);
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Image(
          image: AssetImage('images/ss.png'),
          height: 200.0,
          width: 180.0,
        ),
      ),

    );
  }
}

