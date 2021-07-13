import 'package:flutter/material.dart';
import 'package:here4u/providers/post_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('إضافة منشور'),
        ),
        body: columnElements(),
      ),
    );
  }

  //-----------------------------Widget Tree-----------------------------------
  Widget columnElements() {
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

            onPressed: (){
              final postProvider = Provider.of<PostProvider>(context);
              postProvider.addPost('1', "hello riyad", 'imahe path', DateTime.now());
        },
        child: Text('add post'),)
      ],
    );
  }
}
