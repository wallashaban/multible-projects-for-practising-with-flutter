// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlTasks {
  static Database? _db;
  Future<Database?> get db async {
    _db ??= await initialDb();
    return _db;
  }

  initialDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'todo.db');
    Database db = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return db;
  }

  _onCreate(Database database, int version) async {
    //if you want to add mutible table it's better to use "Batch" as it commit mutible in the same time

   /*  Batch batch = database.batch();
    database.execute('''
    CREATE TABLE tasks (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL,
     describtion TEXT, date TEXT,
      isDone INTEGER, isFav INTEGER,
    isDelete INTEGER) ''');
    database.execute('''
    CREATE TABLE tasks (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL,
     describtion TEXT, date TEXT,
      isDone INTEGER, isFav INTEGER,
    isDelete INTEGER) ''');
    await  batch.commit(); */

    await database.execute('''
    CREATE TABLE tasks (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL,
     describtion TEXT, date TEXT,
      isDone INTEGER, isFav INTEGER,
    isDelete INTEGER) ''');
    debugPrint('created');
  }

  _onUpgrade(Database database, int oldVersion, int newVersion) async {
    await database.execute('''
     ALTER TABLE tasks ADD COLUMN bla TEXT
''');
    debugPrint('upgaraded');
  }

  Future retriveData({required String query}) async {
    Database? tasksDb = await db;
    List<Map> response = await tasksDb!.rawQuery(query);
    debugPrint('data retrived ${response.toString()}');
    return response;
  }

  Future insertData({required String query}) async {
    Database? tasksDb = await db;
    int response = await tasksDb!.rawInsert(query);
    debugPrint('data inserted ${response.toString()}');
    return response;
  }

  Future updateData(
      {required String data, required int id, required int type}) async {
    Database? tasksDb = await db;
    int response = await tasksDb!
        .rawUpdate('UPDATE tasks SET $data = ? WHERE id = ?', [type, id]);
    debugPrint('data updated ${response.toString()}');
    return response;
  }

  Future editData(
      {required String title,
      required String describtion,
      required int id}) async {
    Database? tasksDb = await db;
    int response = await tasksDb!.rawUpdate(
        '''UPDATE tasks SET title = ?, describtion = ?, date = ?,
     isDone = 0, isFav = 0, isDelete = 0 WHERE id = ?''',
        [title, describtion, DateTime.now().toString(), id]);
    debugPrint('data edited ${response.toString()}');
    return response;
  }

  Future deleteData({required String query}) async {
    Database? tasksDb = await db;
    int response = await tasksDb!.rawDelete(query);
    debugPrint('data deleted ${response.toString()}');
    return response;
  }

  deleteTodoDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'todo.db');
    await deleteDatabase(path);
  }
  //////////////////////////////////////////////
  // another way to do crud int the database
   Future retrive({required String table}) async {
    Database? tasksDb = await db;
    List<Map> response = await tasksDb!.query(table);
    debugPrint('data retrived ${response.toString()}');
    return response;
  }

  Future insert({required String table,required Map<String,dynamic> values}) async {
    Database? tasksDb = await db;
    int response = await tasksDb!.insert(table,values);
    debugPrint('data inserted ${response.toString()}');
    return response;
  }

  Future update(
      {required String table, required Map<String ,dynamic> values, required String where}) async {
    Database? tasksDb = await db;
    int response = await tasksDb!
        .update(table,values,where: where);
    debugPrint('data updated ${response.toString()}');
    return response;
  }


  Future delete({required String table,String? where}) async {
    Database? tasksDb = await db;
    int response = await tasksDb!.delete(table,where: where);
    debugPrint('data deleted ${response.toString()}');
    return response;
  }

}
