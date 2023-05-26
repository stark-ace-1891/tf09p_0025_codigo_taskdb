import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBAdmin {
  Database? myDatabase;

  //Singleton
  static final DBAdmin db = DBAdmin._();

  DBAdmin._();

  checkDatabase() async {
    if (myDatabase != null) {
      return myDatabase;
    }
    myDatabase = initDatabase(); //Crear base de datos
    return myDatabase;
  }

  initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "TaskBD.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database dbx, int version) async {
        //Crea la tabla correspondiente
        await dbx.execute(
            "CREATE TABLE TASK(ID INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, status TEXT )");
      },
    );
  }
}
