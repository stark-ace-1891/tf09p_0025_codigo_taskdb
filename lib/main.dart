import 'package:flutter/material.dart';
import 'package:tf09p_0025_codigo_taskdb/pages/home_page.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TaskDBApp",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}