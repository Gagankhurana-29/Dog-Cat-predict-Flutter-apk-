import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:cat_dog/home.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      title: Text("Cat And Dog",
      style: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
        color: Colors.white
      ),
      ),
      backgroundColor: Colors.black,
      seconds: 5,
      navigateAfterSeconds: Home(),
      image: Image.asset("assets/dc.jpg"),
      photoSize: 70,
      loaderColor: Colors.orange,
    );
  }
}
