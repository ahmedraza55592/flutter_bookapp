
import 'package:book_app/splashscreen.dart';
import 'package:flutter/material.dart';



void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

    title: "books",
      theme: ThemeData(
        primaryColor: Color(0xff28006e),
        accentColor: Color(0xffffffff),
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


