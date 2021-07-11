import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostPage extends StatelessWidget {
  DateTime now = DateTime.now();
  late String formattedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            thickness: 3.0,
          ),
          Row(
            children: [
              Icon(Icons.account_circle_sharp),
              Text('   تم النشر من قبل الصفحة '),
            ],
          ),
          Row(
            children: [
              Text(DateFormat('yyyy-MM-dd – kk:mm').format(now)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "إعلان تطوعي ",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.15,
            child: Image.asset(
              "assets/logo/logo.png",
              fit: BoxFit.contain,
            ),
          ),
          Divider(
            thickness: 3.0,
          ),
        ],
      ),
    );
  }
}
