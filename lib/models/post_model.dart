import 'package:flutter/cupertino.dart';

class PostModel with ChangeNotifier {
  final String id;
  final String postText;
  final String imagePath;
  final DateTime postDate;

  PostModel(this.postText, this.imagePath, this.postDate, this.id);
}
