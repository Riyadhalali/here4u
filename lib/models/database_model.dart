class DataBaseModel {
  int? id;
  String textPost;
  String date;
  String imagePath;

  DataBaseModel(
      {this.id,
      required this.textPost,
      required this.date,
      required this.imagePath});

  factory DataBaseModel.fromMap(Map<String, dynamic> json) => DataBaseModel(
      id: json["id"],
      textPost: json["textPost"],
      date: json["date"],
      imagePath: json["imagePath"]);

  Map<String, dynamic> toMap() =>
      {"id": id, "textPost": textPost, "date": date, "imagePath": imagePath};
}
