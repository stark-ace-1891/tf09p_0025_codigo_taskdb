import 'package:flutter/material.dart';
import 'package:tf09p_0025_codigo_taskdb/db/db_admin.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                DBAdmin.db.getTasks();
              },
              child: Text(
                "Mostrar data",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                DBAdmin.db.insertTask();
                // DBAdmin.db.insertRawTask();
              },
              child: Text(
                "Insertar Tarea",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                DBAdmin.db.updateTask();
                // DBAdmin.db.updateRawTask();
              },
              child: Text(
                "Actualizar Tarea",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                DBAdmin.db.deleteTask();
                // DBAdmin.db.deleteRawTask();
              },
              child: Text(
                "Eliminar Tarea",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
