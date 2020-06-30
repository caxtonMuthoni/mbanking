import 'dart:async';
import 'dart:io' as io;
import 'package:mbanking/SQL/user.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DBHelper {
  static Database _db;
  static const String  ID = 'id';
  static const String PHONE = 'phone';
  static const String TABLE = 'user';
  static const String DATABASE_NAME ='app.db';
  static const delaySeconds =  Duration(seconds: 1);

  DBHelper(){
    initDb();
  }


//   await Future.delayed(delaySeconds, () => {
//
//
//    });


  Future<Database> get db async{

    if(_db != null){
      return _db;
    }
      _db = await initDb();

  }

  initDb()  async{
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path,DATABASE_NAME);
    var db = await openDatabase(path,version: 1,onCreate: _oncreate);

    return db;
  }

   _oncreate(Database db, int version) async {

    await db.execute("CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $PHONE TEXT)");
  }

//  saving user to sql lite
  Future<User> save(User user) async{
    var dbClient = await db;
    user.id = await dbClient.insert(TABLE,user.toMap());
    return user;
  }

//  Retrieving user from local db
 Future<List<User>> getUserLength() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE,columns: [ID,PHONE]);

    List<User> users = [];
    if(maps.length > 0) {
      for (var i = 0; i < maps.length; i++) {
        users.add(User.fromMap(maps[i]));
      }
    }

    return users;
 }

}