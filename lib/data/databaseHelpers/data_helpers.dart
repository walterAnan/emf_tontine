import 'package:emf_tontine/data/models/adherent.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataHelper {
  static const int _version = 1;
  static Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'emf_database'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE emf_database(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
        );
      },

      version: _version,
    );

  }

  static Future<void> insertAdherent(Adherent adherent) async {
    // Get a reference to the database.
    final db = await initDatabase();
    await db.insert(
      'emf_database',
      adherent.toJason(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  static Future<List<Adherent>> adherent() async {
    final db = await initDatabase();

    // Query the table for all The Adherents.
    final List<Map<String, dynamic>> maps = await db.query('emf_database');

    // Convert the List<Map<String, dynamic> into a List<Adherent>.
    return List.generate(maps.length, (i) {
      return Adherent(
        id: maps[i]['id'],
        name: maps[i]['name'],
        age: maps[i]['age'],
      );
    });
  }

}