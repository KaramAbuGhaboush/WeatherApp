import 'package:sqflite/sqflite.dart';

class LocationSqldb {
  static final LocationSqldb instance = LocationSqldb._init();

  static Database? _database;

  LocationSqldb._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = (await _initDB('location.db'));
    return _database!;
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE location(
        String locationName primary key not null,
        String ltdlng,
      )
    ''');
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> insert(Map<String, dynamic> row) async {
    final db = await instance.database;
    await db.insert('location', row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    final db = await instance.database;
    return await db.query('location');
  }

  Future deleteBLocationName(String locationName) async {
    final db = await instance.database;
    await db.delete(
      'location',
      where: 'locationName = ?',
      whereArgs: [locationName],
    );
  }

  Future updateLocationName(String locationName, String ltdlng) async {
    final db = await instance.database;
    await db.update(
      'location',
      {'ltdlng': ltdlng},
      where: 'locationName = ?',
      whereArgs: [locationName],
    );
  }
}
