import 'package:flutter/material.dart';
import 'package:cat_dog/splash.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          title: "Cat And Dog",
          home: Splash(),
          debugShowCheckedModeBanner: false,
    );
  }
}

