import 'dart:async';

import 'package:flutter/material.dart';
import 'package:here4u/ui/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<Timer> LoadTimer() async {
    return new Timer(Duration(seconds: 2), onDoneLoading);
  }

  Future onDoneLoading() async {
    Navigator.pushNamed(context, HomeScreen.id);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadTimer();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Hello"),
    );
  }
}
