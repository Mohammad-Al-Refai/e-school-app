import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
// ignore: non_constant_identifier_names

class DataBaseConnection {
  // ignore: non_constant_identifier_names
  Future<Database> CreateDataBase() async {
    print("db Created");
    var dirctory = await getDatabasesPath();
    var path = join(dirctory, "db");
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int v) async {
    await db.execute("""
       CREATE TABLE questions(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,mark TEXT ,text TEXT,o1 TEXT,o2 TEXT,o3 TEXT,currect TEXT )
        """);
    await db.execute("""
       CREATE TABLE details(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,title TEXT ,endMark TEXT)
        """);
  }

  insertDetails(
    String title,
    String endMark,
  ) async {
    var db = await CreateDataBase();
    return db.rawInsert(
        "insert into details (title,endMark) values ('$title','$endMark');");
  }

  /// For Update exam just exam name & exam finaly mark
  ///
  updateDetails(int id, String title, String endMark) async {
    var db = await CreateDataBase();
    return db.rawUpdate(
        "update details set title='$title',endMark='$endMark' where id=$id");
  }

  getOnefromDetails(int id) async {
    var db = await CreateDataBase();
    return await db.rawQuery("select * from details where details.id=$id");
  }

  insertQuestion(String mark, String text, String o1, String o2, String o3,
      String currect) async {
    var db = await CreateDataBase();
    return db.rawInsert(
        "insert into questions (mark,text,o1,o2,o3,currect) values ('$mark','$text','$o1','$o2','$o3','$currect');");
  }

  getAll() async {
    var db = await CreateDataBase();
    return await db.query("questions");
  }

  getOne(int id) async {
    var db = await CreateDataBase();
    return await db.rawQuery("select * from questions where questions.id=$id");
  }

  removeQuestion(int id) async {
    var db = await CreateDataBase();
    return db.rawDelete("delete from questions where questions.id=$id;");
  }

  updateQuestion(int id, String mark, String text, String o1, String o2,
      String o3, String currect) async {
    var db = await CreateDataBase();
    return db.rawUpdate(
        "update questions set mark='$mark',text='$text',o1='$o1',o2='$o2',o3='$o3',currect='$currect' where id=$id");
  }
}
