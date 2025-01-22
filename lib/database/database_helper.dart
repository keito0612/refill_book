import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DateBaseHelper {
  DateBaseHelper._();
  static final DateBaseHelper db = DateBaseHelper._();
  static const _databaseName = "refill_book.db";
  static const _databaseVersion = 1;
  static const tableAlbum = 'album';
  static const tableImage = 'images';
  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnConverImage = 'conver_image';
  static const columnColor = 'color';
  static const columnAlbumId = 'album_id';
  static const columnMemo = 'memo';
  static const columnImageData = 'image_data';
  static const columnAlbumColor = 'album_color';
  static const columnDate = 'date';

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await initDB();
      return _database!;
    }
  }

  static Future rawDelete({String? tableName}) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    final datebase = await openDatabase(path);
    await datebase.rawDelete('DELETE FROM $tableName');
  }

  Future<Database> initDB() async {
    //データベースを作成
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    final Future<Database> _database = openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute(
            // テーブルの作成
            "CREATE TABLE $tableAlbum ($columnId INTEGER PRIMARY KEY AUTOINCREMENT,$columnTitle TEXT ,$columnConverImage BLOB, $columnDate TEXT, $columnColor INTEGER)");
        await db.execute(
            "CREATE TABLE $tableImage ($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnMemo TEXT, $columnImageData BLOB, $columnAlbumId INTEGER,$columnDate, FOREIGN KEY (album_id) REFERENCES album(id) ON DELETE CASCADE)");
      },
      version: _databaseVersion,
    );
    return _database;
  }
}
