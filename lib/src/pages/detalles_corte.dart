import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:parcial1/src/bloc/actividad_controller.dart';
import 'package:parcial1/src/models/activity_model.dart';

class DetalleCorte extends StatefulWidget {
  @required
  final String nroCorte;
  final controllerNewNameActivityText = TextEditingController();
  final controllerNewNotaText = TextEditingController();
  final controllerNewPercentText = TextEditingController();
  final double definitivaCorte;

  DetalleCorte({Key key, this.nroCorte, this.definitivaCorte})
      : super(key: key);

  @override
  _DetalleCorteState createState() => _DetalleCorteState();
}

class _DetalleCorteState extends State<DetalleCorte> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.nroCorte} Corte'),
        backgroundColor: Color.fromARGB(100, 255, 0, 56),
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
                controller: widget.controllerNewNameActivityText,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  hintText: 'Nombre de la actividad',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: widget.controllerNewPercentText,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  hintText: '0-100% ',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: widget.controllerNewNotaText,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  hintText: 'Nota entre 0.0 - 5.0',
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
                if (widget.controllerNewNameActivityText.text == '' ||
                    widget.controllerNewPercentText.text == '' ||
                    widget.controllerNewNotaText.text == '') {
                  _showAlert(context);
                } else {
                  final newActivity = ActivityModel(
                    activityName: widget.controllerNewNameActivityText.text,
                    activityNote:
                        double.parse(widget.controllerNewNotaText.text),
                    percent: int.parse(widget.controllerNewPercentText.text),
                    corte: (widget.nroCorte == 'Primer')
                        ? 1
                        : (widget.nroCorte == 'Segundo') ? 2 : 3,
                  );
                  ActivityController.saveActivity(newActivity);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  String _calculateNote(List<ActivityModel> snapshot) {
    if (snapshot == null) {
      return '0.0';
    }else{

    List<ActivityModel> ejemplo = snapshot;
    double definitiva = 0;
    for (var i = 0; i < ejemplo.length; i++) {
      definitiva += (ejemplo[i].activityNote *
              double.parse(ejemplo[i].percent.toString())) /
          100;
    }
    return definitiva.toString();
    }

  }

  Widget _buildBody() {
    final double _sizeWidth = MediaQuery.of(context).size.width;
    final double _sizeHeight = MediaQuery.of(context).size.height;
    final double _diagonalSize =
        sqrt((_sizeHeight * _sizeHeight) + (_sizeWidth * _sizeWidth));
    int totalPercent;
    return Padding(
      padding: EdgeInsets.all(10),
      child: GetBuilder(
          init: ActivityController(),
          builder: (snapshot) {
            return FutureBuilder<List<ActivityModel>>(
                future: snapshot.allActivities(),
                builder: (context, snapshot) {
                  return Stack(
                    children: [
                      ListView(
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.only(top: _sizeHeight * 0.6),
                                  width: _sizeWidth,
                                  height: _sizeHeight * 0.3,
                                  child: Column(
                                    children: [
                                      Text(
                                        _calculateNote(snapshot.data),
                                        style: TextStyle(
                                          color: Colors.red[200],
                                          fontSize: _diagonalSize * 0.15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '',
                                        style: TextStyle(
                                            fontSize: _diagonalSize * 0.04),
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
                        child: (snapshot.data == null)
                            ? Center(
                                child: Text('No hay datos'),
                              )
                            : ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: Text(
                                        '${snapshot.data[index].activityName}'),
                                    title: Text(
                                        '${snapshot.data[index].activityNote.toString()}'),
                                    trailing: Text(
                                        '${snapshot.data[index].percent.toString()}'),
                                    onTap: () {
                                      List<ActivityModel> lista =
                                          new List<ActivityModel>();
                                      lista = snapshot.data;
                                    },
                                  );
                                },
                              ),
                      ),
                    ],
                  );
                });
          }),
    );
  }

  void _showAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text(';Error;'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Llene todos los campos ´-´'),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Ok',
                style: TextStyle(color: Colors.red[200]),
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      },
    );
  }
}
