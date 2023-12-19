import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/name.dart';
import 'dart:developer' as developer;

class DatabaseHelper {
  static const _databaseName = "names.db";
  
  static const table = "Names";

  static const columnId = "id";
  static const columnName = "name";
  static const columnMean = "mean";
  static const columnGender = "gender";
  static const columnOrigin = "origin";

  late Database _db;

  Future<void> init() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    final exist = await databaseExists(path);

    if(exist){
      developer.log('Ya existe la BD', name: 'my.app.database_helper');
    }else{
      developer.log('Inicia copiado de BD', name: 'my.app.database_helper');
      try{
        await Directory(dirname(path)).create(recursive: true);
      }catch(_){}
      ByteData data = await rootBundle.load(join("assets", _databaseName));
      List<int> bytes = data.buffer.asInt8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
      developer.log('Finaliza copiado de BD', name: 'my.app.database_helper');
    }
    _db = await openDatabase(path);
    final dbVersion = await _db.getVersion();
    developer.log('Version BD: $dbVersion ', name: 'my.app.database_helper');

  }


  Future<int> insert(Map<String, dynamic> row) async {
    return await _db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    return await _db.query(table);
  }


  Future<List<Name>> queryAllNames() async {
    developer.log('Inicia query all Names', name: 'my.app.database_helper');
    final result = await _db.query(table);
    developer.log('termina query all Names', name: 'my.app.database_helper');
    return result.map((name) => Name.fromMap(name)).toList();
  }
// All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    final results = await _db.rawQuery('SELECT COUNT(*) FROM $table');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    int id = row[columnId];
    return await _db.update(
      table,
      row,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    return await _db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
