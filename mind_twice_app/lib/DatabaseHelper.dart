import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';

final String table = 'items';
final colId = 'id';
final colTitle = 'title';
final colDate = 'date';
final colImage = 'image';
final colFirstNote = 'first_note';
final colDate4back = 'date_for_back';
final colSecondNote = 'second_note';

class DatabaseHelper {
  static final _dbName = 'MindTwice.db';
  static final _dbVersion = 1;
  static Database _database;

  //Singleton
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  //getter for database
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $colId INTEGER PRIMARY KEY,
        $colTitle TEXT,
        $colDate TEXT,
        $colImage TEXT,
        $colFirstNote TEXT,
        $colDate4back TEXT,
        $colSecondNote TEXT
      )
    ''');
  }

  //Queries
  String str(value, {isDateTime = false}) {
    if (value == null) {
      return null;
    }

    if (isDateTime) {
      value = value.toString();
    }

    if (value.trim() == '') {
      return null;
    }

    return '"' + value + '"';
  }

  Future<int> insert(item) async {
    Database db = await database;

    String query = '''
      INSERT INTO $table ($colTitle, $colDate, $colImage, $colFirstNote, $colDate4back, $colSecondNote)
      VALUES(
        ${str(item.title)},
        ${str(item.date, isDateTime: true)},
        ${str(item.image)},
        ${str(item.firstNote)},
        ${str(item.date4back, isDateTime: true)},
        ${str(item.secondNote)}
      )
    ''';

    int id = await db.rawInsert(query);
    return id;
  }

  Future<void> update(item) async {
    Database db = await database;

    String query = '''
      UPDATE $table
      SET
        $colTitle = ${str(item.title)},
        $colDate = ${str(item.date, isDateTime: true)},
        $colImage = ${str(item.image)},
        $colFirstNote = ${str(item.firstNote)},
        $colDate4back = ${str(item.date4back, isDateTime: true)},
        $colSecondNote = ${str(item.secondNote)}
      WHERE
        $colId = ${int.parse(item.id)} 
    ''';

    await db.rawUpdate(query);
  }

  Future<List> getAll() async {
    Database db = await database;
    String query = 'SELECT * FROM $table';
    List<Map> result = await db.rawQuery(query);
    return result;
  }
}
