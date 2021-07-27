import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:here4u/providers/post_provider.dart';
import 'package:here4u/services/sharedpreferences.dart';
import 'package:here4u/ui/home/home_screen.dart';
import 'package:here4u/ui/widgets/mywidgets.dart';
import 'package:here4u/utils/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);
  static const id = 'addpost_page';

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final _postBodyController = TextEditingController();
  int numLines = 0;
  final ImagePicker _picker = new ImagePicker();
  File? imageFile; // the question mark means it could be null
  late DB db;
  String? base64image;
  late String phone_data,
      password_data; //variables for holding shared pref data
  bool fetching = true;
  String? imageFilePath;
  bool activatePost = false;
  SharedPref sharedPref = new SharedPref();
  //-> get image from gallery
  Future getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      //-> if the user didn't select any image
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        imageFilePath = pickedFile.path;

        print(imageFile);
        print(imageFilePath);
      }
    });
  }

//------------------------Get the user if admin---------------------------------
  //-> if the user is admin then adtivate the post
  void getUserAdmin() async {
    phone_data = await sharedPref.LoadData("phone");
    password_data = await sharedPref.LoadData('password');
    if (phone_data == 'admin' ||
        phone_data == '0966114002' && password_data == 'admin') {
      setState(() {
        activatePost = true;
      });
    } else {
      activatePost = false;
    }
  }

  //------------------------
  void showProcessingDialog(String text, BuildContext context) async {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            content: Container(
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                CircularProgressIndicator(),
                SizedBox(
                  width: 5.0,
                ),
                Text(text,
                    style: TextStyle(
                        fontFamily: "OpenSans", color: Color(0xFF5B6978)))
              ]),
            ),
          );
        });
  }

  //----------------------------------------------------------------------------
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // db = DB();
    // getData();
    getUserAdmin();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('إضافة منشور'),
        ),
        body: SingleChildScrollView(child: columnElements(context)),
      ),
    );
  }

  //-----------------------------Widget Tree-----------------------------------
  Widget columnElements(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    // final postModel = Provider.of<PostModel>(context);
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.4,
          child: TextField(
            controller: _postBodyController,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            maxLines: numLines < 7 ? 148 : numLines,
            decoration: InputDecoration(
              filled: true,
              hintText: 'يرجى إدخال النص ...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onChanged: (String value) {
              setState(() {
                numLines = '\n'.allMatches(value).length + 1;
              });
            },
          ),
        ),

        //---------------------------------------------------------------------
        Divider(
          thickness: 2.0,
        ),
        ElevatedButton(
            onPressed: getImage, child: Text('اختيار صورة من المعرض')),
        SizedBox(
          height: 10,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.15,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
          child: imageFile != null
              ? Image.file(
                  imageFile!,
                  fit: BoxFit.contain,
                )
              : Text(
                  'لم يتم اختيار أي صورة',
                  textAlign: TextAlign.center,
                ),
        ),
        Divider(
          thickness: 2.0,
        ),

        ElevatedButton(
          onPressed: () async {
            if (_postBodyController.text.isNotEmpty && imageFile != null) {
              postProvider.addPost(
                  postProvider.items.length + 1,
                  _postBodyController.text,
                  imageFilePath.toString(),
                  DateTime.now());
              print(imageFile);

              if (activatePost == false) {
                // showProcessingDialog(
                //     'لا تمتلك الصلاحيات للنشر، عذراًً.', context);
                MyWidgets mywidget = new MyWidgets();
                mywidget.displaySnackMessage(
                    'عذراً، لا تمتلك الصلاحيات للنشر', context);
                return;
              }
              //-> insert data to sql database
              // db.insertData(DataBaseModel(
              //     textPost: _postBodyController.text,
              //     date: DateTime.now().toString(),
              //     imagePath: imageFile.toString()));

              //load timer for 3 seconds when it is done please go to screen
              Timer timer = Timer(Duration(seconds: 3), () {
                Navigator.pushNamed(context, HomeScreen.id);
                //  Navigator.of(context, rootNavigator: true).pop();
              });
              showProcessingDialog('جاري النشر ...', context);
            } else {
              MyWidgets myWidgets = new MyWidgets();
              myWidgets.displaySnackMessage('يرجى تعبئة البيانات', context);
            }
          },
          child: Text('إضافة المنشور'),
        )
      ],
    );
  }
}
