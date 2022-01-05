import 'package:control_c/helpers/const.dart';
import 'package:control_c/model/app_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static String tableName = appDatabaseName;
  static String querySql = queryCreateSql;
  static String dbName = controlDbName;

  Future<Database> _getDatabase() async {
    final path = join(await getDatabasesPath(), dbName);
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(querySql);
      },
      version: 1,
    );
  }

  Future insert(AppModel appModel) async {
    Database db;
    db = await _getDatabase();
    db.insert(
      tableName,
      appModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future delete(AppModel appModel) async {
    Database db;
    db = await _getDatabase();
    db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [appModel.id],
    );
  }

  Future update(AppModel appModel) async {
    Database db;
    db = await _getDatabase();
    db.update(
      tableName,
      appModel.toMap(),
      where: 'id = ?',
      whereArgs: [appModel.id],
    );
  }

  Future<AppModel> readById(int id) async {
    Database db;
    db = await _getDatabase();
    final data = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    return AppModel.fromMap(data[0]);
  }

  Future<List<AppModel>> readAll() async {
    Database db;
    db = await _getDatabase();
    final data = await db.query(tableName);
    return List.generate(
      data.length,
      (index) => AppModel.fromMap(data[index]),
    );
  }
}
