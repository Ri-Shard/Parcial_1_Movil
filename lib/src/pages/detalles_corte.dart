import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:parcial1/src/bloc/actividad_controller.dart';
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
                  hintText: 'Id',
                ),
              ),
                   TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(20.0)),
                  hintText: 'Nota',
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
                ActivityController.saveActivity(newActivity);
               // MateriaController.
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
                            '0.0',
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
/*           Container(
            // color: Colors.blue,
            height: _sizeHeight * 0.55,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, index) {
                return Column(
                  children: [
          Expanded(
            child: GetBuilder(
              init: ActivityController(),
              builder: (snapshot) {
                return FutureBuilder<List<ActivityModel>>(
                  future: snapshot.allActivities(),
                  builder: (context, snapshot) {
                    return (snapshot.data == null)
                        ? Center(child: Text('No hay datos'))
                        : ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading:
                                    (snapshot.data[index].activityName == null)
                                        ? Text('${index+1}',
                                            style: TextStyle(
                                                fontSize: _diagonalSize * 0.03))
                                        : Text(
                                            snapshot.data[index].activityNote
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: _diagonalSize * 0.03),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                title: Text(
                                  snapshot.data[index].activityName,
                                  style:
                                      TextStyle(fontSize: _diagonalSize * 0.03),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: Icon(
                                  Icons.chevron_right,
                                  size: _diagonalSize * 0.03,
                                ),
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
                );
              },
            ),
          ), */
        ],
      ),
    );
  }
}
