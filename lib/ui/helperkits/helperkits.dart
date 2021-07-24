import 'package:flutter/material.dart';
import 'package:here4u/ui/home/components/drawer.dart';

class HelperKits extends StatefulWidget {
  const HelperKits({Key? key}) : super(key: key);
  static const id = 'helper_kit';
  @override
  _HelperKitsState createState() => _HelperKitsState();
}

class _HelperKitsState extends State<HelperKits> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('التسجيل على المعونات'),
      ),
      drawer: DrawePage(),
      body: columnElements(),
    );
  }

  //----------------------------------Widget Tree-------------------------------
  Widget columnElements() {
    return Column();
  }
}
