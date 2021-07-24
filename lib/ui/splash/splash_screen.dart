import 'dart:async';

import 'package:flutter/material.dart';
import 'package:here4u/ui/signin/signin.dart';
import 'package:here4u/ui/widgets/imagebackground.dart';
import 'package:here4u/ui/widgets/imagebackgroundwothfilter.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<Timer> LoadTimer() async {
    return new Timer(Duration(seconds: 3), onDoneLoading);
  }

  Future onDoneLoading() async {
    Navigator.pushNamed(context, SignIn.id);
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
      body: logoScreen(),
    );
  }

  //----------------------------Widget Tree--------------------------------
  Widget logoScreen() {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.1,
        ),
        Expanded(
          child: Stack(
            children: [
              ImageBackground(imageAsset: 'assets/logo/logo.jpeg'),
              ImageBackgroundWithFilter(
                  imageAsset: 'assets/ui/splash/people.jpg'),
            ],
          ),
        ),
      ],
    );
  }
//
}
