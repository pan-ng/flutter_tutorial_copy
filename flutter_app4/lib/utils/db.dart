import 'dart:io';


import 'package:flutter_app4/model/note.dart';
import 'package:flutter_app4/utils/sql.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _instance;
  static Database _db;

  static const currentVersion = 1;

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    _instance = (_instance == null) ? DatabaseHelper._createInstance() : _instance;
    return _instance;
  }

  Future<Database> get db async {
    return _db = (_db == null) ? await createDb() : _db;
  }

  Future<Database> createDb() async {
    // from path provider
    Directory dir = await getApplicationDocumentsDirectory();
    var path = dir.path + "/app_db.db";
    return await openDatabase(path, version: currentVersion, onCreate: (db, version) {
      _createDbV1(db, version);
    }, onUpgrade: (db, oldVersion, newVersion) {});
  }

  void _createDbV1(Database db, int newVersion) async {
    var args = Map<String, String>()
      ..putIfAbsent(NoteColumns.TITLE, () => SQLKeywords.TEXT)
      ..putIfAbsent(NoteColumns.DESCRIPTION, () => SQLKeywords.TEXT)
      ..putIfAbsent(NoteColumns.PRIORITY, () => SQLKeywords.INTEGER)
      ..putIfAbsent(Columns.CREATED_AT, () => SQLKeywords.INTEGER)
      ..putIfAbsent(Columns.UPDATED_AT, () => SQLKeywords.INTEGER);
    await db.execute(_createTableWithIntIdSQL(NoteColumns.NOTES, args));
  }

  String _createTableWithIntIdSQL(String tableName, Map<String, String> columns) {
    var columnsSQL = columns.entries.map((entry) {
      return "${entry.key} ${entry.value}";
    }).join(", ");
    return "CREATE TABLE $tableName(${Columns.ID} INTEGER PRIMARY KEY AUTOINCREMENT ${columnsSQL.length > 0 ? "," : ""} $columnsSQL)";
  }

  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.db;
    var result = await db.query(NoteColumns.NOTES, orderBy: "${NoteColumns.PRIORITY} ${SQLKeywords.ASC}, ${Columns.CREATED_AT} ${SQLKeywords.DESC}");
    return result;
  }

  Future<List<Note>> getNoteList() async {
    var allNotesAsMap = await getNoteMapList();
    return allNotesAsMap.map((aSingleNoteMap) {
      return Note.fromJson(aSingleNoteMap);
    }).toList();
  }

  Future<int> insert(Note note) async {
    Database db = await this.db;
    db.insert(NoteColumns.NOTES, note.toJson());
  }

  Future<int> update(Note note) async {
    Database db = await this.db;
    return db.update(NoteColumns.NOTES, note.toJson(), where: "${Columns.ID} = ?", whereArgs: [note.id]);
  }

  Future<int> delete(Note note) async {
    Database db = await this.db;
    return db.rawDelete("DELETE FROM ${NoteColumns.NOTES} WHERE ${Columns.ID} = ?", [note.id]);
  }

  Future<int> getNoteCount() async {
    Database db = await this.db;
    List<Map<String, dynamic>> list = await db.rawQuery("SELECT COUNT(id) FROM ${NoteColumns.NOTES}");
    return Sqflite.firstIntValue(list);
  }
}

class SQLKeywords {
  static const INTEGER = 'INTEGER';
  static const TEXT = 'TEXT';
  static const DESC = 'DESC';
  static const ASC = 'ASC';
}
