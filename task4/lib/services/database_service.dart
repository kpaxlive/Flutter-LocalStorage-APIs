


import 'dart:core';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_4/models/user_model.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;

  static Database? _database;

  DatabaseService._internal();

  Future get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future _initDatabase() async {
    String path = join(await getDatabasesPath(), 'example.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, surname TEXT, age INTEGER, mail TEXT, favorite_color TEXT)',
    );
  }

  Future insertItem(UserData user) async {
    final db = await database;
    return await db.insert('users', user.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
Future<List<UserData>> getItems() async {
    final db = await database;
    final List userMaps = await db.query('users');

    return List.generate(userMaps.length, (i) {
      return UserData(
        id: userMaps[i]['id'],
        name: userMaps[i]['name'],
        surname: userMaps[i]['surname'],
        age: userMaps[i]['age'],
        mail: userMaps[i]['mail'],
        favoriteColor: userMaps[i]['favorite_color'],
      );
    });
  }

  Future? getItem(int id) async {
    final db = await database;
    List results =
        await db.query('users', where: 'id = ?', whereArgs: [id]);
    if (results.isNotEmpty) {
      return results.first;
    }
    return null;
  }

   Future updateItem(int id, Map item) async {
    final db = await database;
    return await db.update('users', item, where: 'id = ?', whereArgs: [id]);
  }

  Future deleteItem(int id) async {
    final db = await database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

   Future deleteTable() async {
    final db = await database;
    return await db.delete('users');
  }

  Future getUsersCount() async {
  final db = await database;
  int? count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM users'));
  return count;
}
}