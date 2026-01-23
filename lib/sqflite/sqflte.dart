import 'package:sqflite/sqflite.dart';

class sqldb{
  static Database? _db;


  Future<Database?> get db async {
    if (_db == null){
      _db =await intialdb();
      return _db;
    }
    else {
      return _db;
    }
  }


  intialdb()async{

    String databasepath= await getDatabasesPath();
    String path ="$databasepath/not.db";
    Database mydb =await openDatabase(path, onCreate: _onCreate,version: 1,onUpgrade: _onUpgrade);
    return mydb;
  }
  _onUpgrade(Database db,int oldversion,int newversion){
    print("onupgrade");
  }
  _onCreate(Database db,int version)async{
    await db.execute('''
     CREATE TABLE "notes"(
       id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
       'name' TEXT NOT NULL,
       'desc' TEXT NOT NULL
     )
     ''');
    print("cteate data base and table");
  }

  readData(String sql)async{
    Database? mydb=await db;
    List<Map> responese=await mydb!.rawQuery(sql);
    return responese;
  }
  insertData(String sql)async{
    Database? mydb=await db;
    int responese=await mydb!.rawInsert(sql);
    return responese;
  }
  updateData(String sql)async{
    Database? mydb=await db;
    int responese=await mydb!.rawUpdate(sql);
    return responese;
  }
  deleteData(String sql)async{
    Database? mydb=await db;
    int responese=await mydb!.rawDelete(sql);
    return responese;
  }
}