import 'package:flutter/material.dart';

class DrawePage extends StatelessWidget {
  const DrawePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.white),
            child: Container(
              width: 100.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/logo/logo.png"),
                    fit: BoxFit.contain),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text(
              'قسم الإسعاف',
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
