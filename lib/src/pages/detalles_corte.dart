import 'dart:math';

import 'package:flutter/material.dart';
import 'package:parcial1/src/models/activity_model.dart';

class DetalleCorte extends StatefulWidget {
  @override
  _DetalleCorteState createState() => _DetalleCorteState();
}

class _DetalleCorteState extends State<DetalleCorte> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Numero Corte'),
                backgroundColor: Color.fromARGB(100,255, 0, 56),

        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _addActivity(context);
              })
        ],
      ),
      body: _buildBody(),
    );
  }

  void _addActivity(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('Agregar actividad'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  hintText: 'Nombre de la actividad',
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  hintText: '%',
                ),
              ),
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
                final newActivity = ActivityModel(
                  activityName: 'parcial1',
                );
                //ActividadController.nuevaActividad(nuevaMateria);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

    Widget _buildBody() {
    final double _sizeWidth = MediaQuery.of(context).size.width;
    final double _sizeHeight = MediaQuery.of(context).size.height;
    final double _diagonalSize =
        sqrt((_sizeHeight * _sizeHeight) + (_sizeWidth * _sizeWidth));
    return Padding(
      padding: EdgeInsets.all(10),
      child: Stack(
        children: [
          ListView(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: _sizeHeight * 0.6),
                      width: _sizeWidth,
                      height: _sizeHeight * 0.3,
                      child: Column(
                        children: [
                          Text(
                            '4.0',
                            style: TextStyle(
                              color: Colors.red[200],
                              fontSize: _diagonalSize * 0.15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'prueba',
                            style: TextStyle(fontSize: _diagonalSize * 0.04),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            // color: Colors.blue,
            height: _sizeHeight * 0.55,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            // controller: controllerNombreText,
                            //autofocus: true,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              hintText: 'Nombre de la actividad',
                              // labelText: 'Nombre de materia',
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        SizedBox(
                          width: 50,
                          child: TextField(
                            // controller: controllerNombreText,
                            //autofocus: true,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              hintText: '%',
                              // labelText: 'Nombre de materia',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
