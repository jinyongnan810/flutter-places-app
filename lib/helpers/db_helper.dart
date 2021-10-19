import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> getDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE places(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_lng REAL, loc_address TEXT)');
    }, version: 1);
    return db;
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await getDatabase();
    await db.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> fetchAll(String table) async {
    final db = await getDatabase();
    final data = await db.query(table);
    return data;
  }
}
