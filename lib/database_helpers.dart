import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// database table and column names
final String tableKeys = 'Keys';
final String columnURL = 'url';
final String columnEmail = 'email';
final String columnPrivKey = 'privkey';
final String columnPubKey = 'pubkey';

// data model class
class Keys {

  String url;
  String email;
  String privkey;
  String pubkey;

  Keys();

  // convenience constructor to create a Keys object
  Keys.fromMap(Map<String, dynamic> map) {
    url = map[columnURL];
    email = map[columnEmail];
    privkey = map[columnPrivKey];
    pubkey = map[columnPubKey];
  }

  // convenience method to create a Map from this Keys object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnURL: url,
      columnEmail: email,
      columnPrivKey: privkey,
      columnPubKey: pubkey
    };
    if (url != null) {
      map[columnURL] = url;
    }
    return map;
  }
}

// singleton class to manage the database
class DatabaseHelper {

  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "TBLIDKeys.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableKeys (
                $columnURL TEXT PRIMARY KEY,
                $columnEmail TEXT NOT NULL,
                $columnPrivKey TEXT NOT NULL,
                $columnPubKey TEXT NOT NULL
              )
              ''');
  }

  // Database helper methods:

  Future<int> insert(Keys key) async {
    Database db = await database;
    int id = await db.insert(tableKeys, key.toMap());
    return id;
  }

  Future<Keys> queryKey(String url) async {
    Database db = await database;
    List<Map> maps = await db.query(tableKeys,
        columns: [columnURL, columnEmail, columnPrivKey,columnPubKey],
        where: '$columnURL = ?',
        whereArgs: [url]);
    if (maps.length > 0) {
      return Keys.fromMap(maps.first);
    }
    return null;
  }

// TODO: queryAllWords()
// TODO: delete(int id)
// TODO: update(Word word)
}