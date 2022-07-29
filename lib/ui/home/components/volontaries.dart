import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:here4u/models/volontaries_model.dart';
import 'package:here4u/navigator.dart';
import 'package:here4u/ui/home/components/drawer.dart';
import 'package:here4u/ui/widgets/mywidgets.dart';
import 'package:here4u/ui/widgets/textinputfield.dart';

class Voluntaries extends StatefulWidget {
  static final id = 'voluntaries';
  @override
  _VoluntariesState createState() => _VoluntariesState();
}

class _VoluntariesState extends State<Voluntaries> {
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _skillsController = TextEditingController();
  final _departmentController = TextEditingController();

  bool nameBook = false;
  bool validatePhoneNumber = false;
  bool validateEmail = false;
  bool validateSkills = false;
  bool validateSection = false;
  @override
  void initState() {
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
                controller_text: _nameController,
                error_msg: nameBook ? "يرجى تعبئة الحقل" : null,
                show_password: false),
            SizedBox(
              height: 30,
            ),
            TextInputField(
                hint_text: 'رقم الهاتف',
                controller_text: _phoneNumberController,
                error_msg: validatePhoneNumber ? "يرجى تعبئة الحقل" : null,
                show_password: false),
            SizedBox(
              height: 30,
            ),
            TextInputField(
                hint_text: 'البريد الإلكتروني',
                controller_text: _emailController,
                error_msg: validateEmail ? "يرجى تعبئة الحقل" : null,
                show_password: false),
            SizedBox(
              height: 30,
            ),
            TextInputField(
                hint_text: 'المهارات',
                controller_text: _skillsController,
                error_msg: validateSkills ? "يرجى تعبئة الحقل" : null,
                show_password: false),
            SizedBox(
              height: 30,
            ),
            TextInputField(
                hint_text: 'القسم المراد التطوع فيه',
                controller_text: _departmentController,
                error_msg: validateSection ? "يرجى تعبئة الحقل" : null,
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
  void regiserFunction() async {
    if (_skillsController.text.isEmpty ||
        _nameController.text.isEmpty ||
        _phoneNumberController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _departmentController.text.isEmpty) {
      setState(() {
        nameBook = true;
        validateEmail = true;
        validatePhoneNumber = true;
        validateSkills = true;
        validateSkills = true;
      });

      return;
    }
    MyWidgets myWidgets = MyWidgets();
    myWidgets.showProcessingDialog("جاري التسجيل", context);

    //-> create user in firebase
    try {
      final volunteers = FirebaseFirestore.instance.collection('volunteers').doc();

      final volunteries = VoluntariesModel(
          name: _nameController.text,
          phoneNumber: _phoneNumberController.text,
          email: _emailController.text,
          skills: _skillsController.text,
          section: _departmentController.text);
      final json = volunteries.toJson();

      await volunteers.set(json);
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
} //------------------------End class-------------------------------------------
