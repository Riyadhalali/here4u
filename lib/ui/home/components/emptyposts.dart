import 'package:flutter/material.dart';

class EmptyPosts extends StatelessWidget {
  const EmptyPosts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.4,
        child: Text(
          'لا يوجد نتائج .... ',
          style: TextStyle(fontSize: 25.0),
        ),
      ),
    );
  }
}
