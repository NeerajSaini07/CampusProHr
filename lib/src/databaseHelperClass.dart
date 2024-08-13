import 'package:campus_pro/src/DATA/MODELS/notificationsModel.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DataBaseHelper {
  //
  // DataBaseHelper._privateConstructor();
  // static final DataBaseHelper instance = DataBaseHelper._privateConstructor();
  //
  // static sql.Database? _database;
  // Future<sql.Database> get database async {
  //   if (_database != null) return _database!;
  //   _database = await db();
  //   return _database!;
  // }
  //

  static Future<void> createTable(sql.Database db) async {
    await db.execute(
        // """CREATE TABLE tbExample(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,title TEXT,description TEXT)""");
        """CREATE TABLE notificationStudent(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,SmsId TEXT,SmsType TEXT,ToNumber TEXT,AlertDate TEXT,AlertMessage TEXT)""");
  }

  static Future<sql.Database> db() async {
    var path = await sql.getDatabasesPath() + "campus_pro.db";
    return sql.openDatabase(path, version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTable(database);
    });
  }

  static Future<int> createItem(
      {String? smsId,
      String? smsType,
      String? toNumber,
      String? alertDate,
      String? alertMessage}) async {
    // sql.Database db = await instance.database;
    final db = await DataBaseHelper.db();
    final data = {
      'SmsId': smsId,
      'SmsType': smsType,
      'ToNumber': toNumber,
      'AlertDate': alertDate,
      'AlertMessage': alertMessage,
    };
    final id = await db.insert("notificationStudent", data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  //static Future<List<Map<String, Object?>>> getItems({int? id}) async {
  static Future<List<NotificationsModel>> getItems({int? id}) async {
    final db = await DataBaseHelper.db();
    print("database ${db}");
    var data = await db.query(
      'notificationStudent',
    );
    // data.forEach((element) {
    //   //print(element);
    // });
    //   'tbExample',
    // );
    if (data.length > 0) {
      final list = data.map((e) => NotificationsModel.fromJson(e)).toList();
      return list;
    } else {
      return [];
    }
  }

  static Future<int> updateItem(
      {int? id, String? title, String? description}) async {
    final db = await DataBaseHelper.db();

    final data = {"title": title, 'description': description};
    final result = db.update('tbExample', data, where: "id=?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await DataBaseHelper.db();
    try {
      await db.delete("tbExample", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print("Something went wrong when deleting an item: $err");
    }
  }

  static Future<void> dropTable() async {
    final db = await DataBaseHelper.db();
    try {
      // await db.delete("notificationStudent");
      await db.execute("DROP TABLE IF EXISTS notificationStudent");
    } catch (e) {
      print("error while removing all data $e");
    }
  }

  static Future<void> deleteDatabase() async {
    sql.databaseFactory
        .deleteDatabase(await sql.getDatabasesPath() + "campus_pro.db");
  }
}
