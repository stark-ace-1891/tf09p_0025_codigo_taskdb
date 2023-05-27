import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tf09p_0025_codigo_taskdb/models/task_model.dart';

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

  insertRawTask(TaskModel model) async {
    Database? db = await checkDatabase();
    int res = await db!.rawInsert(
        "INSERT INTO TASK(title, description, status) VALUES ('${model.title}','${model.description}','${model.status.toString()}')");
    return res;
  }

  insertTask(TaskModel model) async {
    Database? db = await checkDatabase();
    int res = await db!.insert("TASK", {
      "title": model.title,
      "description": model.description,
      "status": model.status,
    });
    return res;
  }

  getRawTasks() async {
    Database? db = await checkDatabase();
    List tasks = await db!.rawQuery("select * from Task");
    print(tasks);
  }

  Future<List<TaskModel>> getTasks() async {
    Database? db = await checkDatabase();
    List<Map<String,dynamic>> tasks = await db!.query("TASK");
    List<TaskModel> taskModeList = tasks.map((e) => TaskModel.deMapAModel(e)).toList();

    // tasks.forEach((element) {
    //   TaskModel task = TaskModel.deMapAModel(element);
    //   taskModeList.add(task);
    //   // taskModeList.add(TaskModel.deMapAModel(element));
    // });

    return taskModeList;
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
