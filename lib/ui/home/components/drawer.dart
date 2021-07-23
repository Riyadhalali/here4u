import 'package:flutter/material.dart';
import 'package:here4u/emergency/emergency.dart';
import 'package:here4u/ui/addpost/addpost.dart';

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
            onTap: () {
              Navigator.pushNamed(context, EmergencyPage.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('إضافة منشور'),
            onTap: () {
              Navigator.pushNamed(context, AddPost.id);
            },
          )
        ],
      ),
    );
  }
}
