import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class PostPage extends StatefulWidget {
  final int? id;
  final String textPost;
  final String datePost;
  final String imagePath;

  PostPage(
      {this.id,
      required this.textPost,
      required this.datePost,
      required this.imagePath});

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final DateTime now = DateTime.now();
  final ImagePicker _picker = ImagePicker();
  File? imageFile;
  String? appDocPath;
  //
  // Future getimage() async {
  //   Directory appDocDir = await getApplicationDocumentsDirectory();
  //   setState(() {
  //     appDocPath = appDocDir.path;
  //     String newPath = '{$appDocPath}' + widget.imagePath;
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getimage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            thickness: 3.0,
          ),
          Row(
            children: [
              Icon(Icons.account_circle_sharp),
              Text('   تم النشر من قبل الصفحة '),
            ],
          ),
          Row(
            children: [
              Text(DateFormat('yyyy-MM-dd – kk:mm')
                  .format(DateTime.parse(widget.datePost))),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.textPost,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.amber,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.15,
              child: Image.file(
                File(widget.imagePath),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Divider(
            thickness: 3.0,
          ),
        ],
      ),
    );
  }
}
