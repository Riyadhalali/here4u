import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:here4u/ui/provider/permission_provider.dart';
import 'package:here4u/ui/signin/signin.dart';
import 'package:here4u/ui/widgets/imagebackground.dart';
import 'package:here4u/ui/widgets/imagebackgroundwothfilter.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var collection = FirebaseFirestore.instance.collection("users"); // to get the state of users
  FirebaseAuth firebaseAuth = FirebaseAuth.instance; // add firebase auth
  Future<Timer> LoadTimer() async {
    return new Timer(Duration(seconds: 3), onDoneLoading);
  }

  Future onDoneLoading() async {
    Navigator.pushNamed(context, SignIn.id);
  }

  fetchUser() async {
    PermissionsProvider permissionsProvider =
        Provider.of<PermissionsProvider>(context, listen: false);

    var docSnapshot = await collection.doc("admin").get();
    print("the docSnapshot${docSnapshot.data()}");
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      if (data!['userType'] == "admin") {
        permissionsProvider.showInDrawerDoctorAddPost(true);
        print("the provider value is ${permissionsProvider.adminSigned}");
      }
      if (data!['userType'] == "موظف") {
        permissionsProvider.showInDrawerEmployeeAddPost(true);
        print("the provider value is ${permissionsProvider.EmployeeSigned}");
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadTimer();
    fetchUser();
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
              ImageBackgroundWithFilter(imageAsset: 'assets/ui/splash/people.jpg'),
            ],
          ),
        ),
      ],
    );
  }
//
}
