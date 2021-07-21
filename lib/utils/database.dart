import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:here4u/models/database_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB with ChangeNotifier {
  //-> this will run first
  DB() {
    initDB();
  }

  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'My_db.db'),
      onCreate: (database, version) async {
        await database.execute('''
        CREATE TABLE MYTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        textPost TEXT,
        date TEXT ,
        imagePath TEXT
        )
        ''');
      },
      version: 1,
    );
    notifyListeners();
  }

  //------------------------------INSERT DATA-----------------------------------
  Future<bool> insertData(DataBaseModel data) async {
    final Database db = await initDB();
    db.insert("MYTable", data.toMap());
    print(await db.query("MYTABLE")); // print all data in the table
    return true;
  }

//------------------------------Get Data from SQL-------------------------------
//   Future<List<DataBaseModel>> getData() async {
//     final Database db = await initDB();
//     final List<Map<String, Object?>> datas = await db.query("MYTABLE");
//     return datas.map((e) => DataBaseModel.fromMap(e)).toList();
//   }
  //---------------------------Get Data From SQL--------------------------------
  Future<List<Map<String, dynamic>>> getData() async {
    final Database db = await initDB();
    return await db.query("MYTABLE");
  }

  //--------------------------update Data---------------------------------------
  Future<void> update(DataBaseModel dataModel, int id) async {
    final Database db = await initDB();
    await db
        .update("MYTABLE", dataModel.toMap(), where: "id=?", whereArgs: [id]);
    print(await db.query("MYTABLE")); // print all data in the table
  }

  //-------------------------Delete Data----------------------------------------
  Future<void> delete(int id) async {
    final Database db = await initDB();
    await db.delete("MYTABLE", where: "id=?", whereArgs: [id]);
  }
//------------------------------------------------------------------------------
} // end class
