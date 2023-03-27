import 'package:flutter/material.dart';
import 'package:flutter_suivis_sante/page/editprofil.dart';
import 'package:flutter_suivis_sante/page/login.dart';
import 'package:flutter_suivis_sante/page/mainpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Login(title: 'Page Principal'),
      routes: <String, WidgetBuilder>{
        '/mainpage': (BuildContext context) =>
            const MainPage(title: 'Main Page'),
        '/login': (BuildContext context) => const Login(title: 'Main Page'),
        '/editprofil': (BuildContext context) => const EditProfil(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
