import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:here4u/models/volontaries_model.dart';
import 'package:here4u/ui/widgets/textinputfield.dart';
import 'package:provider/provider.dart';

import '../provider/permission_provider.dart';
import '../widgets/mywidgets.dart';

class AdminControlVolunteersScreen extends StatefulWidget {
  static const id = 'adminControlVolunteer_screen';
  @override
  State<AdminControlVolunteersScreen> createState() => _AdminControlVolunteersScreenState();
}

class _AdminControlVolunteersScreenState extends State<AdminControlVolunteersScreen> {
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

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var collection = FirebaseFirestore.instance.collection("volunteers");

  MyWidgets myWidgets = new MyWidgets();

  //for using model class
  Stream<List<VoluntariesModel>> getHelperKits() =>
      FirebaseFirestore.instance.collection('volunteers').snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => VoluntariesModel.fromJson(doc.data())).toList());

  Stream<QuerySnapshot> getData() async* {
    // FirebaseUser user = await FirebaseAuth.instance.currentUser();
    FirebaseFirestore.instance.collection('volunteers').snapshots();
  }

  @override
  void initState() {
    //  getHelperKits();
    super.initState();
    // getHelperKits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('طلبات التطوع'),
      ),
      body: StreamBuilder<List<VoluntariesModel>>(
        stream: getHelperKits(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData) {
            final posts = snapshot.data!;

            if (posts.isEmpty) {
              return Center(
                  child: Text(
                "لا يوجد نتائج",
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20.0),
              ));
            } else {
              return ListView(
                children: posts.map(buildPosts).toList(),
              );
            }
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        },
      ),
    );
  }

  //------------------------------------------------

  Widget buildPosts(VoluntariesModel volunteer) {
    PermissionsProvider permissionsProvider =
        Provider.of<PermissionsProvider>(context, listen: false);
    return Card(
        child: ListTile(
      leading: CircleAvatar(child: Text(volunteer.name)),
      title: Text(
        volunteer.name,
        style: TextStyle(
            fontFamily: "OoohBaby", fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.red),
      ),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.phone),
              Text(volunteer.phoneNumber),
            ],
          ),
          Row(
            children: [
              Icon(Icons.category_sharp),
              Text(volunteer.email),
            ],
          ),
          Row(
            children: [
              Icon(Icons.access_time_rounded),
              Expanded(child: Text(volunteer.skills)),
            ],
          ),
          Row(
            children: [
              Icon(Icons.access_time_rounded),
              Expanded(child: Text(volunteer.section)),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  collection
                      .doc(volunteer.name) // <-- Doc ID where data should be updated.

                      .delete() // <-- Updated data

                      .then((_) => myWidgets.showToast("تم حذف الطلب بنجاح"))
                      .catchError((error) => print('Delete failed: $error'));
                },
              ),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: SingleChildScrollView(
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  TextInputField(
                                      hint_text: volunteer.name,
                                      controller_text: _nameController,
                                      error_msg: nameBook ? "يرجى تعبئة الحقل" : null,
                                      show_password: false),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  TextInputField(
                                      hint_text: volunteer.phoneNumber,
                                      controller_text: _phoneNumberController,
                                      error_msg: validatePhoneNumber ? "يرجى تعبئة الحقل" : null,
                                      show_password: false),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  TextInputField(
                                      hint_text: volunteer.email,
                                      controller_text: _emailController,
                                      error_msg: validateEmail ? "يرجى تعبئة الحقل" : null,
                                      show_password: false),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  TextInputField(
                                      hint_text: volunteer.skills,
                                      controller_text: _skillsController,
                                      error_msg: validateSkills ? "يرجى تعبئة الحقل" : null,
                                      show_password: false),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  TextInputField(
                                      hint_text: volunteer.section,
                                      controller_text: _departmentController,
                                      error_msg: validateSection ? "يرجى تعبئة الحقل" : null,
                                      show_password: false),
                                  IconButton(
                                      onPressed: () {
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
                                        // update data in firebase
                                        collection
                                            .doc(volunteer
                                                .name) // <-- Doc ID where data should be updated.
                                            .update({
                                              'name': _nameController.text,
                                              'email': _emailController.text,
                                              'phoneNumber': _phoneNumberController.text,
                                              'section': _departmentController.text,
                                              'skills': _skillsController.text
                                            }) // <-- Updated data
                                            .then((_) =>
                                                myWidgets.showToast("تم التحديث الموعد بنجاح"))
                                            .catchError((error) => print('Update failed: $error'));
                                        Navigator.of(context).pop();
                                      },
                                      icon: Icon(Icons.save))
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
            ],
          )
        ],
      ),
    ));
  }

//------
} // end class
