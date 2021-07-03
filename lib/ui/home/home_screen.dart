import 'package:flutter/material.dart';
import 'package:here4u/ui/home/components/categories.dart';
import 'package:here4u/ui/home/components/imageslider.dart';
import 'package:here4u/ui/home/components/offers.dart';

import 'components/volontaries.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Here4U"),
      ),
      body: SingleChildScrollView(child: columnElements()),
    );
  }

  //-------------------------------Widget Tree----------------------------------
  Widget columnElements() {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        ImageSlider(),
        OffersHeader(),
        SizedBox(
          height: 10,
        ),
        Voluntaries(),
        SizedBox(
          height: 10,
        ),
        Categories(),
      ],
    );
  }

//------------------------------------------------------------------------------
}
