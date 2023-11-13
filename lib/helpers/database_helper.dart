import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:favorite_places_app/models/favorite_place_model.dart';

class DatabaseHelper {
  static const _databaseName = "FavoritePlaces.db";
  static const _databaseVersion = 1;
  static const table = 'favorite_places';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            description TEXT,
            latitude FLOAT,
            longitude FLOAT,
            imageFilePath TEXT
          )
          ''');
  }

  Future<int> addPlace(FavoritePlaceModel place) async {
    Database db = await instance.database;
    return await db.insert(table, await place.toJson());
  }

  Future<List<FavoritePlaceModel>> getPlaces() async {
    Database db = await instance.database;
    List<Map> maps = await db.query(table);

    if (maps.isNotEmpty) {
      return maps.map((map) {
        return FavoritePlaceModel.fromJson(map.cast<String, dynamic>());
      }).toList();
    }
    return [];
  }

  Future<void> deleteFavoritePlace(FavoritePlaceModel place) async {
    await _database!.delete('favorite_places',
        where: 'title = ? AND latitude = ? AND longitude = ?',
        whereArgs: [place.title, place.latitude, place.longitude]);
  }

  Future<void> updateFavoritePlace(
      FavoritePlaceModel oldPlace, FavoritePlaceModel newPlace) async {
    await _database!.update('favorite_places', await newPlace.toJson(),
        where: 'title = ? AND latitude = ? AND longitude = ?',
        whereArgs: [oldPlace.title, oldPlace.latitude, oldPlace.longitude]);
  }

  Future<void> clearAllData() async {
    final db = await database;
    await db.delete('favorite_places');
  }
}
