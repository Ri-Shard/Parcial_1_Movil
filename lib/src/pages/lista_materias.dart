import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parcial1/src/bloc/materia_controller.dart';
import 'package:parcial1/src/models/subject_model.dart';
import 'package:parcial1/src/pages/detalles_materia.dart';
import 'package:parcial1/src/provider/db.dart';

class ListaMaterias extends StatefulWidget {
  @override
  _ListaMateriasState createState() => _ListaMateriasState();
}

class _ListaMateriasState extends State<ListaMaterias> {
  final controllerNombreMateriaText = TextEditingController();

  String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de materias'),
        backgroundColor: Color.fromARGB(100, 255, 0, 56),
        actions: [
                    Padding(
            padding: const EdgeInsets.only(right: 15, top: 20),
            child: GestureDetector(
              child: Text(
                'Actualizar',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () async {
                await DBProvider.db.getAllSubject();
                setState(() {});
              },
            ),
          ),
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _addSubject(context);
              })
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final double _sizeWidth = MediaQuery.of(context).size.width;
    final double _sizeHeight = MediaQuery.of(context).size.height;
    final double _diagonalSize =
        sqrt((_sizeHeight * _sizeHeight) + (_sizeWidth * _sizeWidth));
    return Container(
      child: Column(
        children: [
          Expanded(
            child: GetBuilder(
              init: MateriaController(),
              builder: (snapshot) {
                return FutureBuilder<List<SubjectModel>>(
                  future: snapshot.consultarMaterias(),
                  builder: (context, snapshot) {
                    return (snapshot.data == null)
                        ? Center(child: Text('No hay datos'))
                        : ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading:
                                    (snapshot.data[index].definitiva == null)
                                        ? Text('${index+1}',
                                            style: TextStyle(
                                                fontSize: _diagonalSize * 0.03))
                                        : Text(
                                            snapshot.data[index].definitiva
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: _diagonalSize * 0.03),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                title: Text(
                                  snapshot.data[index].subjectName,
                                  style:
                                      TextStyle(fontSize: _diagonalSize * 0.03),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: Icon(
                                  Icons.chevron_right,
                                  size: _diagonalSize * 0.03,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => DetallesMateria(
                                        subjectName:
                                            snapshot.data[index].subjectName,
                                            id: 
                                            snapshot.data[index].idS,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                  },
                );
              },
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  void _addSubject(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('Agregar Materia'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                  // controller: controllerNombreText,
                  //autofocus: true,

                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    hintText: 'Nombre de materia',
                  ),
                  onChanged: (valor) {
                    setState(() {
                      name = valor;
                    });
                  }),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                final newSubject = SubjectModel(
                  subjectName: '${this.name}',
                );
                MateriaController.guardarMateria(newSubject);
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
