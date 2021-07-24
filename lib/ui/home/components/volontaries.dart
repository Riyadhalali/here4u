import 'dart:async';

import 'package:flutter/material.dart';
import 'package:here4u/ui/home/components/drawer.dart';
import 'package:here4u/ui/home/home_screen.dart';
import 'package:here4u/ui/widgets/mywidgets.dart';
import 'package:here4u/ui/widgets/textinputfield.dart';

class Voluntaries extends StatefulWidget {
  static final id = 'voluntaries';
  @override
  _VoluntariesState createState() => _VoluntariesState();
}

class _VoluntariesState extends State<Voluntaries> {
  final _bookController = TextEditingController();
  final _familyMembersController = TextEditingController();
  final _familyMembersNumbersController = TextEditingController();
  final _phoneController = TextEditingController();
  final _departmentController = TextEditingController();

  bool validateBook = false;
  bool validatefamilyMembers = false;
  bool validatefamilyMembersNumbers = false;
  bool validatephoneController = false;
  bool validatedepartmentController = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //   getOffers();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('باب التطوع'),
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
                hint_text: 'الاسم',
                controller_text: _bookController,
                error_msg: validateBook ? "يرجى تعبئة الحقل" : null,
                show_password: false),
            SizedBox(
              height: 30,
            ),
            TextInputField(
                hint_text: 'رقم الهاتف',
                controller_text: _familyMembersController,
                error_msg: validatefamilyMembers ? "يرجى تعبئة الحقل" : null,
                show_password: false),
            SizedBox(
              height: 30,
            ),
            TextInputField(
                hint_text: 'البريد الإلكتروني',
                controller_text: _familyMembersNumbersController,
                error_msg:
                    validatefamilyMembersNumbers ? "يرجى تعبئة الحقل" : null,
                show_password: false),
            SizedBox(
              height: 30,
            ),
            TextInputField(
                hint_text: 'المهارات',
                controller_text: _phoneController,
                error_msg: validatephoneController ? "يرجى تعبئة الحقل" : null,
                show_password: false),
            SizedBox(
              height: 30,
            ),
            TextInputField(
                hint_text: 'القسم المراد التطوع فيه',
                controller_text: _departmentController,
                error_msg:
                    validatedepartmentController ? "يرجى تعبئة الحقل" : null,
                show_password: false),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  regiserFunction();
                },
                child: Text("تطوع"))
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
        _familyMembersNumbersController.text.isEmpty ||
        _departmentController.text.isEmpty) {
      setState(() {
        validateBook = true;
        validatefamilyMembersNumbers = true;
        validatefamilyMembers = true;
        validatephoneController = true;
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
} //------------------------End class-------------------------------------------
