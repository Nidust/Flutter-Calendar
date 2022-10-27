import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Schdule {
  Schdule({
    required this.id,
    required this.startDay,
    required this.endDay,
    required this.title,
  });

  final int id;
  final DateTime startDay;
  final DateTime endDay;
  final String title;
}

class SchduleDB {
  SchduleDB._();
  static final SchduleDB _db = SchduleDB._();
  factory SchduleDB() => _db;

  final String _tableName = "schdule";
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDB();
    return _database!;
  }

  Future<List<Schdule>> select(DateTime day) async {
    final db = await database;

    var response = await db.rawQuery(
      'SELECT * FROM $_tableName WHERE DATE(?) BETWEEN startDay AND endDay',
      [day.toString()],
    );

    return response
        .map(
          (column) => Schdule(
            id: int.parse(column["id"].toString()),
            startDay: DateTime.parse(column["startDay"].toString()),
            endDay: DateTime.parse(column["endDay"].toString()),
            title: column["title"].toString(),
          ),
        )
        .toList();
  }

  insert(Schdule schdule) async {
    final db = await database;

    var response = db.rawInsert(
      'INSERT INTO $_tableName (startDay, endDay, title) VALUES (DATE(?), DATE(?), ?)',
      [
        schdule.startDay.toString(),
        schdule.endDay.toString(),
        schdule.title,
      ],
    );

    return response;
  }

  delete(Schdule schdule) async {
    final db = await database;

    var response = db.rawDelete(
      'DELETE FROM $_tableName WHERE id = ?',
      [schdule.id],
    );

    return response;
  }

  Future<Database> _initDB() async {
    String dbPath = join(await getDatabasesPath(), "$_tableName.db");

    return await openDatabase(dbPath, version: 1,
        onCreate: (db, version) async {
      await db.execute(
        '''
        CREATE TABLE $_tableName
        (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          startDay TEXT NOT NULL,
          endDay TEXT NOT NULL,
          title TEXT NOT NULL
        )
      ''',
      );
    }, onUpgrade: (db, oldVersion, newVersion) {});
  }
}
