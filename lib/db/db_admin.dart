import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBAdmin {
  Database? myDatabase;

  //Singleton
  static final DBAdmin db = DBAdmin._();

  DBAdmin._();

  Future<Database?> checkDatabase() async {
    if (myDatabase != null) {
      return myDatabase;
    }
    myDatabase = await initDatabase(); //Crear base de datos
    return myDatabase;
  }

  Future<Database> initDatabase() async {
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

  insertRawTask() async {
    Database? db = await checkDatabase();
    int res = await db!.rawInsert(
        "INSERT INTO TASK(title, description, status) VALUES ('Ir de compras','Tenemos que ir a Tottus','false')");
    print(res);
  }

  insertTask() async {
    Database? db = await checkDatabase();
    int res = await db!.insert("TASK", {
      "title": "Comprar el nuevo disco",
      "description": "Nuevo disco de Epica",
      "status": "false",
    });
    print(res);
  }

  getRawTasks() async {
    Database? db = await checkDatabase();
    List tasks = await db!.rawQuery("select * from Task");
    print(tasks);
  }

  getTasks() async {
    Database? db = await checkDatabase();
    List tasks = await db!.query("TASK");
    print(tasks);
  }

  updateRawTask() async {
    Database? db = await checkDatabase();
    int res = await db!.rawUpdate(
        "UPDATE TASK SET title='Ir de compras',description='Comprar comida',status='true' WHERE ID=2");
    print(res);
  }

  updateTask() async {
    Database? db = await checkDatabase();
    int res = await db!.update("TASK", {
      "title": "Ir al cine",
      "description": "Es el viernes en la tarde",
      "status": "false",
    },
    where: "id = 2");
    print(res);
  }

  deleteRawTask() async {
    Database? db = await checkDatabase();
    int res = await db!.rawDelete(
        "delete from TASK  WHERE ID=2");
    print(res);
  }

  deleteTask() async {
    Database? db = await checkDatabase();
    int res = await db!.delete("TASK",
    where: "id = 3");
    print(res);
  }
}
