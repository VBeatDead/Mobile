import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper.internal();

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  Future<Database> initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'your_database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Post (
        id INTEGER PRIMARY KEY,
        imagePath TEXT,
        title TEXT,
        description TEXT,
        minutes INTEGER,
        difficulty TEXT
      )
    ''');
  }

  Future<int> insertImageData(Map<String, dynamic> data) async {
    final dbClient = await db;
    return await dbClient!.insert('Post', data);
  }
}