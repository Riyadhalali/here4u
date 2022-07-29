import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:here4u/navigator.dart';
import 'package:here4u/ui/home/components/drawer.dart';
import 'package:here4u/ui/widgets/mywidgets.dart';
import 'package:here4u/ui/widgets/textinputfield.dart';

class HelperKits extends StatefulWidget {
  const HelperKits({Key? key}) : super(key: key);
  static const id = 'helper_kit';
  @override
  _HelperKitsState createState() => _HelperKitsState();
}

class _HelperKitsState extends State<HelperKits> {
  final _familyControllerID = TextEditingController();
  final _familyLocationController = TextEditingController();
  final _familyMembersNumbersController = TextEditingController();
  final _phoneController = TextEditingController();
  bool validateFamilyControllerID = false;
  bool validateFamilyLocation = false;
  bool validatefamilyMembersNumbers = false;
  bool validatephoneController = false;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
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
                controller_text: _familyControllerID,
                error_msg: validateFamilyControllerID ? "يرجى تعبئة الحقل" : null,
                show_password: false),
            SizedBox(
              height: 30,
            ),
            TextInputField(
                hint_text: 'مكان الإقامة',
                controller_text: _familyLocationController,
                error_msg: validateFamilyLocation ? "يرجى تعبئة الحقل" : null,
                show_password: false),
            SizedBox(
              height: 30,
            ),
            TextInputField(
                hint_text: 'عدد أفرادالعائلة',
                controller_text: _familyMembersNumbersController,
                error_msg: validatefamilyMembersNumbers ? "يرجى تعبئة الحقل" : null,
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
  void regiserFunction() async {
    if (_phoneController.text.isEmpty ||
        _familyControllerID.text.isEmpty ||
        _familyLocationController.text.isEmpty ||
        _familyMembersNumbersController.text.isEmpty) {
      setState(() {
        validateFamilyControllerID = true;
        validatefamilyMembersNumbers = true;
        validateFamilyLocation = true;
        validatephoneController = true;
      });

      return;
    } else {
      MyWidgets myWidgets = MyWidgets();
      myWidgets.showProcessingDialog("جاري التسجيل", context);

      //-> create user in firebase
      try {
        //-> first method
        FirebaseFirestore.instance.collection('helperKits').doc(_familyControllerID.text).set({
          'familyID': _familyControllerID.text,
          'familyMembersNumber': _familyMembersNumbersController.text,
          'familyLocation': _familyLocationController.text,
          'phone_number': _phoneController.text,
        });

        //-> Display snackbar message
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("تم التسجيل بنجاح"),
            duration: Duration(seconds: 3),
          ),
        );
        Navigator.pushNamed(context, Navigations.id);
      } on FirebaseException catch (e) {
        //-> Display snackbar message with error
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message.toString()),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  } // end function

  //----------------------------------------------------------------------------
}
