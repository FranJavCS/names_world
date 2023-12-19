import '../helpers/database_helper.dart';
import 'dart:developer' as developer;

import '../models/name.dart';

class NameServices {
  Future<List<Name>> getAllNames() async {
    DatabaseHelper dbHelper =  DatabaseHelper();
    await dbHelper.init();
    developer.log('Consultando nombres', name: 'my.app.main_section');
    Future<List<Name>> names = dbHelper.queryAllNames();
    developer.log('termina consulta de nombres', name: 'my.app.main_section');
    return names;
  }
}
