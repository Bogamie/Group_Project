import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database? _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), 'schedule.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE schedules (
            id INTEGER PRIMARY KEY,
            title TEXT,
            category TEXT,
            alarm TEXT,
            repeat TEXT,
            place TEXT,
            memo TEXT,
            startDate TEXT,
            endDate TEXT
          )
        ''');
      },
    );
  }

  Future<int> saveSchedule(Map<String, dynamic> schedule) async {
    var dbClient = await db;
    return await dbClient.insert('schedules', schedule);
  }
}
