import 'package:flutter/material.dart';
import 'package:tf09p_0025_codigo_taskdb/db/db_admin.dart';
import 'package:tf09p_0025_codigo_taskdb/models/task_model.dart';
import 'package:tf09p_0025_codigo_taskdb/widget/my_form_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<String> getFullName() async {
    return "Juan Manuel";
  }

  showDialogForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MyFormWidget();
      },
    ).then((value) {
      print("El formulario fue cerrado.");
      setState(() {});
    });
  }

  deleteTask(taskId) {
    DBAdmin.db.deleteTask(taskId).then((value) {
      if (value > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.indigo,
            content: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Tarea eliminada"),
              ],
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    DBAdmin.db.getTasks();

    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialogForm();
        },
        child: Icon(
          Icons.add,
        ),
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
                return Dismissible(
                  key: UniqueKey(), //Key(index.toString()),
                  confirmDismiss: (DismissDirection direction) async {
                    //antes de ir al ondismissed
                    print(direction);
                    return true;
                  },
                  //is el direction es startToEnd xaparece el background y si es endToStart aparece el secondaryBackground
                  direction: DismissDirection.startToEnd,
                  background: Container(
                    color: Colors.redAccent,
                  ),
                  onDismissed: (DismissDirection direction) {
                    deleteTask(myTasks[index].id!);
                  },
                  // secondaryBackground: Text("Hola"),
                  child: ListTile(
                    title: Text(
                      myTasks[index].title,
                    ),
                    subtitle: Text(
                      myTasks[index].description,
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        showDialogForm();
                      },
                      icon: Icon(Icons.edit),
                    ),
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
