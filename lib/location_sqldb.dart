import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class LocationSqldb {
  LocationSqldb._();
  static final LocationSqldb db = LocationSqldb._();
  static int version = 1;
  final String tableName = 'location';
  final String tableName2 = 'currentLocation';
  static Database? _database;

  Future<Database> get database async {
    return _database ??= await _initDB();
  }

  Future _createDB(db, version) async {
    await db.execute('''
      CREATE TABLE $tableName(
        int id primary key autoincrement,
        String locationName not null,
        String ltdlng,
      )
      CREATE TABLE $tableName2(
        int id primary key autoincrement,
        String locationName not null,
        String ltdlng,
      )
    ''');
    insertCurrentLocation('Jerusalem', '31.768319,35.213710');
  }

  Future<Database> _initDB() async {
    String filePath = 'location.db';
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;
    return await openDatabase(path, version: version, onCreate: _createDB);
  }

  Future insertLocation(String locationName, String ltdlng) async {
    final db = await database;
    await db
        .insert(tableName, {'locationName': locationName, 'ltdlng': ltdlng});
  }

  Future insertCurrentLocation(String locationName, String ltdlng) async {
    final db = await database;
    await db
        .insert(tableName2, {'locationName': locationName, 'ltdlng': ltdlng});
  }

  Future<String> getCurrentLocation() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName2);
    return maps[0]['ltdlng'];
  }

  Future<List<String>> getAllLocations() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return maps[i]['locationName'];
    });
  }

  Future<List<String>> getAllLtdLng() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return maps[i]['ltdlng'];
    });
  }

  Future deleteLocation(String locationName) async {
    final db = await database;
    await db.delete(tableName,
        where: 'locationName = ?', whereArgs: [locationName]);
  }

  Future updateLocation(String locationName, String ltdlng) async {
    final db = await database;
    await db.update(tableName, {'ltdlng': ltdlng},
        where: 'locationName = ?', whereArgs: [locationName]);
  }

  Future upfateCurrentLocation(String locationName, String ltdlng) async {
    final db = await database;
    await db.update(tableName2, {'ltdlng': ltdlng},
        where: 'locationName = ?', whereArgs: [locationName]);
  }
}
