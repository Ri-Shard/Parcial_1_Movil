import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parcial1/src/bloc/materia_controller.dart';
import 'package:parcial1/src/models/subject_model.dart';
import 'package:parcial1/src/widgets/fat_button.dart';

import 'detalles_corte.dart';


class DetallesMateria extends StatelessWidget {
  final String subjectName;
  final int id;
  const DetallesMateria({this.subjectName, this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${this.subjectName}'),
                backgroundColor: Color.fromARGB(100,255, 8, 100),
        actions: [
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteSubject(context);
              })
        ],
      ),
      body: _buildBody(context),
    );
  }
void _deleteSubject(BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('Borrar Materia'),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                MateriaController.deleteSubject(this.id);
                Navigator.of(context).pop();
                Navigator.of(context).pop();

              },
            ),
          ],
        );
      },
    );

}
  Widget _createFatButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        FatButton(
          color1: Color(0xFFEF4005),
          color2: Color(0xFFEF4059),
          icon: FontAwesomeIcons.brain,
          texto: 'Corte 1',
          onPress: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => DetalleCorte(),
                ));
          },
        ),
        SizedBox(height: 20),
        FatButton(
          color1: Color(0xFFEF4005),
          color2: Color(0xFFEF4059),
          icon: FontAwesomeIcons.brain,
          texto: 'Corte 2',
          onPress: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => DetalleCorte(),
                ));
          },
        ),
        SizedBox(height: 20),
        FatButton(
          color1: Color(0xFFEF4005),
          color2: Color(0xFFEF4059),
          icon: FontAwesomeIcons.brain,
          texto: 'Corte 3',
          onPress: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => DetalleCorte(),
                ));
          },
        ),
      ],
    );
  }

    Widget _buildBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: [
          Column(
            children: <Widget>[
              _createFatButtons(context),
            ],
          ),
        ],
      ),
    );
  }
}
