import 'package:registrationapp/domain/user_domain.dart';
import 'package:sqflite/sqflite.dart';

class SqliteHelper {
  /*
      Get db path with you db for each platform
   */
  Future<String> createDb() async {
    try {
      var databasesPath = await getDatabasesPath();
      String path = databasesPath + '/testDemo.db';
      return path;
    } catch (e) {
      throw "Db not created";
    }
  }

/*
      Get table with provided path with table column  values
   */
  Future<Database> getDatabase() async {
    try {
      String path = await createDb();
      Database database = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
            'CREATE TABLE User (id INTEGER PRIMARY KEY AUTOINCREMENT, imei TEXT, udid TEXT, fname TEXT, lname TEXT,dob TEXT,passport TEXT,email TEXT, image TEXT, device TEXT, lat TEXT, long TEXT)');
      });
      return database;
    } catch (e) {
      throw "Table not created";
    }
  }

  /* 
  
  Insert data using transaction for table database
  
  
   */

  Future<bool> insertData(UserDomain model) async {
    try {
      Database database = await getDatabase();
      bool isInsert = false;
      await database.transaction((txn) async {
        int id1 = await txn.rawInsert(
            'INSERT INTO User(imei, udid, fname, lname, dob, passport, email, image,device,lat,long) VALUES(?,?,?,?,?,?,?,?,?,?,?)',
            [
              model.imeiNumber ?? "",
              model.udid ?? "",
              model.firstName ?? "",
              model.lastName ?? "",
              model.dob ?? "",
              model.passport ?? "",
              model.email ?? "",
              model.imagePath ?? "",
              model.device ?? "",
              model.lat ?? "",
              model.long ?? ""
            ]);
        print('inserted1: $id1');
        isInsert = true;
      });
      return isInsert;
    } catch (e) {
      throw "Insertion failed";
    }
  }

  readTableValue() async {
    try {
      Database _database = await getDatabase();
      List<Map> list = await _database.rawQuery('SELECT * FROM User');
      print(list);
    } catch (e) {
      throw "Fetching failed";
    }
  }
}
