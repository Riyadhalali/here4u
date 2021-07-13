import 'package:flutter/material.dart';
import 'package:here4u/models/post_model.dart';

class PostProvider with ChangeNotifier {
  Map<String, PostModel> _postItems = {};
  //-----------------------Get Posts--------------------------------------------
  Map<String, PostModel> get getPosts {
    return {..._postItems};
  }

  //-----------------------------Add Post---------------------------------------
  void addPost(
      String id, String postText, String imagePath, DateTime postDate) {
    if (_postItems.containsKey(id)) {
      _postItems.update(
          id,
          (existingPost) => PostModel(existingPost.postText,
              existingPost.imagePath, existingPost.postDate, existingPost.id));
    } else {
      _postItems.putIfAbsent(
          id, () => PostModel("hello", "/imagepath", DateTime.now(), "1"));
    }
    notifyListeners();
  }
//-----------------------------------------------------------
} //  end class
