import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class ShoppingDB{

  static String tableName = 'SHOPPING_TIME';
  static int purchases = 0;
  static List items = [];
  static Future<Database> initDB() async{
    print('Creating a new one ');
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'shopping.db');
    Future<Database> db = openDatabase(
        path,
        onCreate: (Database db,int version) async{
          ///Batch batch = db.batch();
          /// await batch.execute(sql);
          return await db.execute(
            'CREATE TABLE $tableName(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,title TEXT NOT NULL,purchases INTEGER NOT NULL,price INTEGER NOT NULL,date TEXT NOT NULL,category INTEGER NOT NULL)',
          );},
      onUpgrade: (db,oldVersion,newVersion)async{
          print('******************** upgrade version ********************');
          await db.execute('ALTER TABLE $tableName ADD COLUMN color TEXT');
      },
      version: 2,
      // onOpen: (db) async{
      //     await retrieveDataFromDB();
      // }
    );
    /// await batch.commit();
    return db;
  }
  static Future<List> getItemsFromDB() async{
    List shoppingItems = await retrieveDataFromDB();
    return shoppingItems;
  }
  
  
 /* _onCreate(Database db,int version) async{
    return db.execute(
      'CREATE TABLE $tableName(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,title TEXT NOT NULL,purchases INTEGER NOT NULL,price INTEGER NOT NULL,date TEXT NOT NULL)',
    );
  }
  _onUpgrade(Database db,int oldVersion,int newVersion){
    print('******************* onUpgrade *************************');


  }  */

    static Future<void> insertItemsToDB(title,price,color,category) async{
    Database db = await initDB();
    await db.transaction((txn){
      var addedDate = DateTime.now().toString();
      return txn.rawInsert("INSERT INTO $tableName(title,purchases,price,date,category,color) VALUES('$title','$purchases','$price','$addedDate','$category','$color')");

    });
    print('Data Inserted successfully..!');
    purchases++;
  }


  static Future<List> retrieveDataFromDB()async{
    Database db = await initDB();
     return await db.rawQuery("SELECT * FROM $tableName");

  }
  
  static Future<int> deleteDataFromDB(int? id) async{
      Database db = await initDB();
      return await db.rawDelete("DELETE FROM $tableName WHERE id = ?",[id]);
  }
  // temporary usage
  // static Future<int> deleteData(String sql) async{
  static Future<int> deleteData() async{
      Database db = await initDB();
      return await db.rawDelete('DELETE FROM $tableName WHERE price = ?',[13]);
  }

  static deleteOurDatabase()async{
      String databasePath = await getDatabasesPath();
      String path = join(databasePath,'shopping.db');
      await deleteDatabase(path);
  }
}
/**static retrieveDataFromDB()async{
    Database db = await initDB();
     db.rawQuery("SELECT * FROM $tableName").then((value){
      items.add(value);
    }).catchError((error){
      print(error.toString());
    });

  }
}*/
// class DBSql{
//   Database? _database;
//   Future<Database?> get db async{
//     if(_database == null) {
//       _database = await initDB();
//       return _database;
//     }
//     return _database;
//   }
//   static const String table_name  = 'tasks.db';
//   initDB() async{
//     String db_Path = await getDatabasesPath();
//     String path = join(db_Path,table_name);
//     Database _db = await openDatabase(path,
//     onCreate: _onCreate,
//     version: 1,
//       onUpgrade: _onUpgrade,
//     );
//     return _db;
//   }

//   _onCreate(Database db,int version)async{
//       await db.execute('''
//           CREATE TABLE $table_name (
//           id INTEGER AUTOINCREMENT NOT NULL PRIMARY KEY,
//           notes TEXT NOT NULL
//           )
//       ''');
//       print("table ($table_name) created...}");
//   }
//   _onUpgrade(Database db,int oldVer,int newVer){
//
//   }
//   readData(String sql)async{
//     Database? _db = await db;
//     List<Map> response = await _db!.rawQuery(sql);
//     return response;
//   }
//   //insert
//   insertData(String sql)async{
//     Database? _db = await db;
//     int response = await _db!.rawInsert(sql);
//     return response;
//   }
//   //delete
//   deleteData(String sql)async{
//     Database? _db = await db;
//     int response = await _db!.rawDelete(sql);
//     return response;
//   }
//   //update
//   updateData(String sql)async{
//     Database? _db = await db;
//     int response = await _db!.rawUpdate(sql);
//     return response;
//   }
// }
// class DBStudentManager {
//   late Database database;
//    dbCreate()async{
// //    if(database == null) {
//       database = await openDatabase(
//         join(await getDatabasesPath(),"student.db"),
// //      "student.db",
//         version : 1,
//         onCreate:(Database db,int version)async{
//           await db.execute(
//               "CREATE TABLE student (id INTEGER AUTOINCREMENT NOT NULL PRIMARY KEY,name TEXT,course TEXT)");
//           print('Database created...');
//         },
// //    onOpen: (database){
// //      print('Database opend...');
// //    }
//       );
//       return database;
// //    }
// //    openDatabase(path)
// }
// Future<int> insertIntoDB(StudentModel? student)async{
//   await dbCreate();
//   return await database.insert(
//       'student',
//       student!.toMap());
// }
// Future<List<StudentModel>> getDataFromDB()async{
//   await dbCreate();
//   List<Map<String,dynamic>> maps = await database.query('student');
//   return List.generate(maps.length, (index) => StudentModel(
//       id: maps[index]['id'],
//       name: maps[index]['name'],
//       course: maps[index]['course'])
//   );
//   }
//   Future<int> updateData(StudentModel? student)async{
//     await dbCreate();
//     return await database.update(
//         'student', student!.toMap(),
//         where: 'id = ? ',
//         whereArgs: [student.id]);
//   }
//
//   Future<void> deleteData(int? id)async{
//     await dbCreate();
//     await database.delete('student',where: 'id = ?',whereArgs: [id]);
//   }
//
// }
// class StudentModel{
//   int? id;
//   final String? course;
//   final String? name;
//   StudentModel({required this.name,required this.course,id,});
//   Map<String,dynamic> toMap(){
//     Map<String,dynamic> data = <String,dynamic>{};
//     data['course'] = course;
//     data['name'] = name;
//     return data;
//   }
// }