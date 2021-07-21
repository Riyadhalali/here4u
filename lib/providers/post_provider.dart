import 'package:flutter/material.dart';
import 'package:here4u/models/database_model.dart';
import 'package:here4u/utils/database.dart';

class PostProvider with ChangeNotifier {
  // static Map<String, PostModel> _postItems = {};

  final DB db = DB();

  List<DataBaseModel> _items = [];
  List<DataBaseModel> get items => [..._items];

  PostProvider() {
    getData();
  }

  //--------------------------------Add post------------------------------------
  void addPost(int id, String postText, String imagePath, DateTime postDate) {
    final newPost = DataBaseModel(
        textPost: postText,
        date: postDate.toString(),
        imagePath: imagePath.toString());
    _items.add(newPost);
    notifyListeners();
    db.insertData(DataBaseModel(
        textPost: postText,
        date: postDate.toString(),
        imagePath: imagePath.toString()));
  }

  Future<void> getData() async {
    final dataList = await db.getData();
    _items = dataList
        .map((item) => DataBaseModel(
            textPost: item['textPost'],
            date: item['date'],
            imagePath: item['imagePath']))
        .toList();
    notifyListeners();
  }
} //  end class
