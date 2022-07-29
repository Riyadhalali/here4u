import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:here4u/models/helperkits_model.dart';
import 'package:provider/provider.dart';

import '../provider/permission_provider.dart';
import '../widgets/mywidgets.dart';
import '../widgets/textinputfield.dart';

class AdminControlHelperKitsScreen extends StatefulWidget {
  static const id = 'adminControl_screen';
  @override
  State<AdminControlHelperKitsScreen> createState() => _AdminControlHelperKitsScreenState();
}

class _AdminControlHelperKitsScreenState extends State<AdminControlHelperKitsScreen> {
  final _familyControllerID = TextEditingController();
  final _familyLocationController = TextEditingController();
  final _familyMembersNumbersController = TextEditingController();
  final _phoneController = TextEditingController();
  bool validateFamilyControllerID = false;
  bool validateFamilyLocation = false;
  bool validatefamilyMembersNumbers = false;
  bool validatephoneController = false;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var collection = FirebaseFirestore.instance.collection("helperKits");

  MyWidgets myWidgets = new MyWidgets();

  //for using model class
  Stream<List<HelperKitsModel>> getHelperKits() => FirebaseFirestore.instance
      .collection('helperKits')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => HelperKitsModel.fromJson(doc.data())).toList());

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
        title: Text('طلبات المعونات'),
      ),
      body: StreamBuilder<List<HelperKitsModel>>(
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

  Widget buildPosts(HelperKitsModel helperKits) {
    PermissionsProvider permissionsProvider =
        Provider.of<PermissionsProvider>(context, listen: false);
    return Card(
        child: ListTile(
      leading: CircleAvatar(child: Text(helperKits.familyId)),
      title: Text(
        helperKits.familyId,
        style: TextStyle(
            fontFamily: "OoohBaby", fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.red),
      ),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.phone),
              Text(helperKits.phoneNumber),
            ],
          ),
          Row(
            children: [
              Icon(Icons.category_sharp),
              Text(helperKits.familyMembersNumber),
            ],
          ),
          Row(
            children: [
              Icon(Icons.access_time_rounded),
              Expanded(child: Text(helperKits.familyLocation)),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  collection
                      .doc(helperKits.familyId) // <-- Doc ID where data should be updated.

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
                                  TextInputField(
                                      hint_text: helperKits.familyId,
                                      controller_text: _familyControllerID,
                                      error_msg:
                                          validateFamilyControllerID ? "يرجى تعبئة الحقل" : null,
                                      show_password: false),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  TextInputField(
                                      hint_text: helperKits.familyLocation,
                                      controller_text: _familyLocationController,
                                      error_msg: validateFamilyLocation ? "يرجى تعبئة الحقل" : null,
                                      show_password: false),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  TextInputField(
                                      hint_text: helperKits.familyMembersNumber,
                                      controller_text: _familyMembersNumbersController,
                                      error_msg:
                                          validatefamilyMembersNumbers ? "يرجى تعبئة الحقل" : null,
                                      show_password: false),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  TextInputField(
                                      hint_text: helperKits.phoneNumber,
                                      controller_text: _phoneController,
                                      error_msg:
                                          validatephoneController ? "يرجى تعبئة الحقل" : null,
                                      show_password: false),
                                  IconButton(
                                      onPressed: () {
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
                                        }
                                        // update data in firebase
                                        collection
                                            .doc(helperKits
                                                .familyId) // <-- Doc ID where data should be updated.
                                            .update({
                                              'familyID': _familyControllerID.text,
                                              'familyMembersNumber':
                                                  _familyMembersNumbersController.text,
                                              'familyLocation': _familyLocationController.text,
                                              'phone_number': _phoneController.text,
                                            }) // <-- Updated data
                                            .then((_) =>
                                                myWidgets.showToast("تم التحديث الطلب  بنجاح"))
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
