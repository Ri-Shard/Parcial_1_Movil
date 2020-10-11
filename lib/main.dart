import 'package:flutter/material.dart';

import 'src/pages/lista_materias.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Parcial App',

      home: Scaffold(
        body: Center(
          child: Container(
            child: ListaMaterias(),
          ),
        ),
      ),
    );
  }
}
