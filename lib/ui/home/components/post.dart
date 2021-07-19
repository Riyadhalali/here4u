import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:here4u/models/post_model.dart';
import 'package:here4u/providers/post_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostPage extends StatelessWidget {
  final DateTime now = DateTime.now();
  late final String formattedDate;
  final String id;

  PostPage({required this.id});

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    final postModel = Provider.of<PostModel>(context);
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
              Text(DateFormat('yyyy-MM-dd – kk:mm').format(postModel.postDate)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              postModel.postText.toString(),
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.15,
            child: Image.file(
              postModel.imagePath,
              fit: BoxFit.contain,
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
