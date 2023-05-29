import 'package:flutter/material.dart';
import 'package:tf09p_0025_codigo_taskdb/db/db_admin.dart';
import 'package:tf09p_0025_codigo_taskdb/models/task_model.dart';

class MyFormWidget extends StatefulWidget {
  const MyFormWidget({super.key});

  @override
  State<MyFormWidget> createState() => _MyFormWidgetState();
}

class _MyFormWidgetState extends State<MyFormWidget> {
  bool isFinished = false;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  addTask() {
    // TaskModel taskModel = TaskModel(
    //   title: _titleController.text,
    //   description: _descriptionController.text,
    //   status: isFinished.toString(),
    // );
    // DBAdmin.db.insertTask(taskModel).then((value) {
    //   if (value > 0) {
    //     ScaffoldMessenger.of(context)
    //         .showSnackBar(SnackBar(content: Text("Hola")));
    //   }
    // });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.indigo,
        content: Column(
          children: [
            Icon(Icons.check),
            Text(
              "Tarea registrada con exito",
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Agregar tarea",
          ),
          SizedBox(
            height: 6,
          ),
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              hintText: "Titulo",
            ),
          ),
          SizedBox(
            height: 6,
          ),
          TextField(
            controller: _descriptionController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "Descripcion",
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Row(
            children: [
              Text(
                "Estado: ",
              ),
              SizedBox(
                width: 6,
              ),
              Checkbox(
                value: isFinished,
                onChanged: (value) {
                  isFinished = value!;
                  setState(() {});
                },
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancelar",
                ),
              ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  addTask();
                },
                child: Text(
                  "Aceptar",
                ),
              ),
            ],
          ),
        ],
      ),
    );
    ;
  }
}
