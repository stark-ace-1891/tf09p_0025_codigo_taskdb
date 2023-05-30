import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tf09p_0025_codigo_taskdb/db/db_admin.dart';
import 'package:tf09p_0025_codigo_taskdb/models/task_model.dart';

class MyFormWidget extends StatefulWidget {
  TaskModel? modelo;

  MyFormWidget({this.modelo});

  @override
  State<MyFormWidget> createState() => _MyFormWidgetState();
}

class _MyFormWidgetState extends State<MyFormWidget> {
  final _formKey = GlobalKey<FormState>();
  bool isFinished = false;
  final TextEditingController? _titleController = TextEditingController();
  final TextEditingController? _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.modelo == null) {
      _titleController!.text = "";
      _descriptionController!.text = "";
      isFinished = false;
    } else {
      _titleController!.text = widget.modelo!.title ?? "";
      _descriptionController!.text = widget.modelo!.description ?? "";
      isFinished = widget.modelo!.status == "true" ? true : false;
    }
  }

  addTask() {
    if (_formKey.currentState!.validate()) {
      TaskModel taskModel = TaskModel(
        title: _titleController!.text,
        description: _descriptionController!.text,
        status: isFinished.toString(),
      );
      DBAdmin.db.insertTask(taskModel).then((value) {
        if (value > 0) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.indigo,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              duration: const Duration(
                milliseconds: 1400,
              ),
              content: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Tarea registrada con exito",
                  )
                ],
              ),
            ),
          );
        }
        ;
      });
    }
  }
  updateTask() {
    if (_formKey.currentState!.validate()) {
      TaskModel taskModel = TaskModel(
        title: _titleController!.text,
        description: _descriptionController!.text,
        status: isFinished.toString(),
        id: widget.modelo!.id,
      );
      DBAdmin.db.updateTask(taskModel).then((value) {
        print(value);
        if (value > 0) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.indigo,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              duration: const Duration(
                milliseconds: 1400,
              ),
              content: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Tarea actualizada con exito",
                  )
                ],
              ),
            ),
          );
        }
        ;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${widget.modelo == null ? "Agregar" : "Modificar"} tarea",
            ),
            SizedBox(
              height: 6,
            ),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: "Titulo",
              ),
              validator: (String? value) {
                if (value!.isEmpty) {
                  return "El campo es obligatorio.";
                }
                if (value.length < 6) {
                  return "El campo debe de tener minimo 6 caracteres.";
                }
                return null;
              },
            ),
            SizedBox(
              height: 6,
            ),
            TextFormField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Descripcion",
              ),
              validator: (String? value) {
                if (value!.isEmpty) {
                  return "El campo es obligatorio.";
                }
                return null;
              },
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
                    if (widget.modelo == null) {
                      addTask();
                    } else {
                      updateTask();
                    }
                  },
                  child: Text(
                    "Aceptar",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    ;
  }
}
