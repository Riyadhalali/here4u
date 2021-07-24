import 'dart:async';

import 'package:flutter/material.dart';
import 'package:here4u/ui/home/components/drawer.dart';
import 'package:here4u/ui/home/home_screen.dart';
import 'package:here4u/ui/widgets/mywidgets.dart';
import 'package:here4u/ui/widgets/textinputfield.dart';

class HelperKits extends StatefulWidget {
  const HelperKits({Key? key}) : super(key: key);
  static const id = 'helper_kit';
  @override
  _HelperKitsState createState() => _HelperKitsState();
}

class _HelperKitsState extends State<HelperKits> {
  final _bookController = TextEditingController();
  final _familyMembersController = TextEditingController();
  final _familyMembersNumbersController = TextEditingController();
  final _phoneController = TextEditingController();
  bool validateBook = false;
  bool validatefamilyMembers = false;
  bool validatefamilyMembersNumbers = false;
  bool validatephoneController = false;
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
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TextInputField(
                hint_text: 'رقم دفتر العائلة',
                controller_text: _bookController,
                error_msg: validateBook ? "يرجى تعبئة الحقل" : null,
                show_password: false),
            SizedBox(
              height: 30,
            ),
            TextInputField(
                hint_text: 'عدد أفراد العائلة',
                controller_text: _familyMembersController,
                error_msg: validatefamilyMembers ? "يرجى تعبئة الحقل" : null,
                show_password: false),
            SizedBox(
              height: 30,
            ),
            TextInputField(
                hint_text: 'مكان الإقامة',
                controller_text: _familyMembersNumbersController,
                error_msg:
                    validatefamilyMembersNumbers ? "يرجى تعبئة الحقل" : null,
                show_password: false),
            SizedBox(
              height: 30,
            ),
            TextInputField(
                hint_text: 'رقم الهاتف',
                controller_text: _phoneController,
                error_msg: validatephoneController ? "يرجى تعبئة الحقل" : null,
                show_password: false),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  regiserFunction();
                },
                child: Text("التسجيل على المعونات"))
          ],
        ),
      ),
    );
  }

  //-----------------------------------Register Function------------------------
  void regiserFunction() {
    if (_phoneController.text.isEmpty ||
        _bookController.text.isEmpty ||
        _familyMembersController.text.isEmpty ||
        _familyMembersNumbersController.text.isEmpty) {
      setState(() {
        validateBook = true;
        validatefamilyMembersNumbers = true;
        validatefamilyMembers = true;
        validatephoneController = true;
      });

      return;
    } else {
      MyWidgets myWidgets = MyWidgets();
      myWidgets.showProcessingDialog("جاري التسجيل", context);
      Future.delayed(Duration(milliseconds: 2000), () {
        myWidgets.showProcessingDialog("تم التسجيل بنجاح...", context);
      });
      Timer timer = Timer(Duration(seconds: 4), onDoneLoading);
    }
  }

  //-----------------------------OnDoneLoading----------------------------------
  void onDoneLoading() {
    Navigator.pushNamed(context, HomeScreen.id);
  }

//------------------------------------------------------------------------------
  //----------------------------------------------------------------------------
}
