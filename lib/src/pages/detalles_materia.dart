import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parcial1/src/widgets/fat_button.dart';

import 'detalles_corte.dart';


class DetallesMateria extends StatelessWidget {
  final String subjectName;
  final double primerCorte;

  const DetallesMateria({this.subjectName, this.primerCorte});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${this.subjectName}'),
                backgroundColor: Color.fromARGB(100,255, 0, 56),

      ),
      body: _buildBody(context),
    );
  }

  Widget _createFatButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        FatButton(
          color1: Color(0xFFEF4005),
          color2: Color(0xFFEF4059),
          icon: FontAwesomeIcons.info,
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
          icon: FontAwesomeIcons.info,
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
          icon: FontAwesomeIcons.info,
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
