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
                DBAdmin.db.initDatabase();
              },
              child: Text(
                "Mostrar data",
              ),
            )
          ],
        ),
      ),
    );
  }
}
