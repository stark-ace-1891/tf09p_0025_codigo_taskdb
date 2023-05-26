import 'package:flutter/material.dart';
import 'package:tf09p_0025_codigo_taskdb/db/db_admin.dart';
import 'package:tf09p_0025_codigo_taskdb/models/task_model.dart';

class HomePage extends StatelessWidget {
  Future<String> getFullName() async {
    return "Juan Manuel";
  }

  @override
  Widget build(BuildContext context) {

    DBAdmin.db.getTasks();

    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
      ),
      body: FutureBuilder(
        future: DBAdmin.db.getTasks(),
        builder: (BuildContext context, AsyncSnapshot snap) {
          print(snap.data);
          if (snap.hasData) {
            List<TaskModel> myTasks = snap.data;
            return ListView.builder(
              itemCount: myTasks.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    myTasks[index].title,
                  ),
                  subtitle: Text(
                    myTasks[index].description,
                  ),
                  trailing: Text(
                    myTasks[index].id.toString(),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
