import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

class DbHelper {
  final String path;
  DbHelper(this.path);
  Database _db;
  final _lock = new Lock();

  Future<Database> getDb() async {


    if (_db == null) {
      await _lock.synchronized(() async {
        // Check again once entering the synchronized block
        if (_db == null) {
          _db = await openDatabase(path);
        }
      });
    }
    return _db;
  }
}