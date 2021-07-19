import 'dart:io';

import 'package:flutter/material.dart';
import 'package:here4u/models/database_model.dart';
import 'package:here4u/models/post_model.dart';
import 'package:here4u/utils/database.dart';

class PostProvider with ChangeNotifier {
  static Map<String, PostModel> _postItems = {};
  late DB db = DB();

  late List<DataBaseModel> datas;
  //-----------------------Get Posts--------------------------------------------
  Map<String, PostModel> get getPosts {
    return {..._postItems};
  }

  Future<List<DataBaseModel>> getData1() async {
    datas = await db.getData();
    notifyListeners();
    return datas;
  }

  //-----------------------------Add Post---------------------------------------
  void addPost(String id, String postText, File imagePath, DateTime postDate) {
    if (_postItems.containsKey(id)) {
      _postItems.update(
          id,
          (existingPost) => PostModel(existingPost.postText,
              existingPost.imagePath, existingPost.postDate, existingPost.id));
    } else {
      _postItems.putIfAbsent(
          id, () => PostModel(postText, imagePath, postDate, id));
    }
    notifyListeners();
  }
//------------------------------------------------------------------------------
//   void addPost(String id, String postText, File imagePath, DateTime postDate) {
//     // if (_postItems.containsKey(id)) {
//     //   _postItems.update(
//     //       id,
//     //       (existingPost) => PostModel(existingPost.postText,
//     //           existingPost.imagePath, existingPost.postDate, existingPost.id));
//     // } else {
//     //   _postItems.putIfAbsent(
//     //       id, () => PostModel(postText, imagePath, postDate, id));
//     // }
//     datas.add(DataBaseModel(
//         textPost: postText,
//         date: postDate.toString(),
//         imagePath: imagePath.toString()));
//     notifyListeners();
//   }
//-----------------------------------------------------------
} //  end class
