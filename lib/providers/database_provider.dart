import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/constants/colors.dart';
import 'package:flutter_expense_tracker_app/models/transaction.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = 'transactions';
  static final String _path = 'transactions.db';

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String path = await getDatabasesPath() + _path;
      _db = await openDatabase(path,
          version: _version, onCreate: (db, version) => db.execute('''
         CREATE TABLE $_tableName(
          id STRING PRIMARY KEY,
          type TEXT, image TEXT, name TEXT, amount TEXT, 
          date TEXT, time TEXT, category TEXT, mode TEXT)
        '''));
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error initializing database',
        backgroundColor: Color(0xFF212121),
        colorText: pinkClr,
      );
    }
  }

  static Future<int> insertTransaction(TransactionModel transaction) async {
    return await _db!.insert(_tableName, transaction.toMap());
  }

  static Future<int> deleteTransaction(String id) async {
    return await _db!.delete(_tableName, where: 'id=?', whereArgs: [id]);
  }

  static Future<int> updateTransaction(TransactionModel tm) async {
    return await _db!.rawUpdate('''
      UPDATE $_tableName 
      SET type = ?,
      image = ?,
      name = ?,
      amount = ?,
      date = ?,
      time = ?,
      category = ?,
      mode = ?
      WHERE id = ? 
''', [
      tm.type,
      tm.image,
      tm.name,
      tm.amount,
      tm.date,
      tm.time,
      tm.category,
      tm.mode,
      tm.id,
    ]);
  }

  static Future<List<Map<String, dynamic>>> queryTransaction() async {
    return await _db!.query(_tableName);
  }
}
