import 'dart:io';

import 'package:mysql_app/model/user_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? databaseHelper; // Singleton DatabaseHelper
  static Database? database; // Singleton Database

  String tableName = 'user';
  String userIdCol = 'id';
  String userNameCol = 'name';
  String userEmailCol = 'email';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    databaseHelper ??= DatabaseHelper._createInstance();
    return databaseHelper!;
  }

  // Getter for the database instance
  Future<Database> get getDatabase async {
    database ??= await initializeDatabase();
    return database!;
  }

  // Initialize database
  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}user.db';

    // Open/create the database at a given path
    var contactsDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    print('Database created successfully ${contactsDatabase.path}');
    return contactsDatabase;
  }

  // Create database and table
  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableName($userIdCol INTEGER PRIMARY KEY AUTOINCREMENT, $userNameCol TEXT, $userEmailCol TEXT)');
  }

  // Insert operation
  Future<int> insertContact(UserModel user) async {
    Database db = await getDatabase;
    var result = await db.insert(tableName, user.toJson());
    return result;
  }

  // Fetch operation: Get all contacts
  Future<List<Map<String, dynamic>>> getUserMapList() async {
    Database db = await getDatabase;
    var result = await db.query(tableName);
    return result;
  }

  // Update operation
  Future<int> updateUser(UserModel user) async {
    var db = await getDatabase;
    var result = await db.update(tableName, user.toJson(),
        where: '$userIdCol = ?', whereArgs: [user.id]);
    return result;
  }

  // Delete operation
  Future<int> deleteUser(int id) async {
    var db = await getDatabase;
    int result =
        await db.rawDelete('DELETE FROM $tableName WHERE $userIdCol = $id');
    return result;
  }
}