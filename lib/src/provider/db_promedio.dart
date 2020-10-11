import 'dart:io';

import 'package:parcial1/src/models/activity_model.dart';
import 'package:parcial1/src/models/subject_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'PromedioDB.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('CREATE TABLE Materias ('
            ' idS INTEGER PRIMARY KEY,'
            ' subjectName TEXT,'
            ' idA INTEGER,'
            ' primerCorte NUMERIC(3,2),'
            ' segundoCorte NUMERIC(3,2),'
            ' tecerCorte NUMERIC(3,2),'
            ' definitiva NUMERIC(3,2)'
            ')');
        await db.execute('CREATE TABLE Actividad ('
            ' idA INTEGER PRIMARY KEY,'
            ' activityName TEXT,'
            ' activityNote NUMERIC(3,2),'
            ' percent INTEGER,'
            ' corte INTEGER'
            ')');
      },
    );
  }

  //MATERIAS--------------------------------------------------------

  //Registrar materia
  nuevaMateria(SubjectModel nuevaMateria) async {
    final db = await database;
    final res = await db.insert('Materias', nuevaMateria.toJson());
    return res;
  }

  //Buscar materia  ID
  Future<SubjectModel> getMateriaId(int id) async {
    final db = await database;
    final res =
        await db.query('Materias', where: 'idS = ?', whereArgs: [id]);
    return res.isNotEmpty ? SubjectModel.fromJson(res.first) : null;
  }

  //Consultar todos
  Future<List<SubjectModel>> getTodasMaterias() async {
    final db = await database;
    final res = await db.query('Materias');

    List<SubjectModel> list = res.isNotEmpty
        ? res.map((c) => SubjectModel.fromJson(c)).toList()
        : [];
    return list;
  }

  //Actualizar materia  ID
  Future<int> updateMateria(SubjectModel nuevaMateria) async {
    final db = await database;
    final res = await db.update('Materias', nuevaMateria.toJson(),
        where: 'idS = ?', whereArgs: [nuevaMateria.idS]);
    return res;
  }

  //Eliminar materia  ID
  Future<int> deleteMateria(int id) async {
    final db = await database;
    final res =
        await db.delete('Materias', where: 'idS = ?', whereArgs: [id]);
    return res;
  }

  //Registrar actividad
  nuevaActividad(ActivityModel nuevaActividad) async {
    final db = await database;
    final res = await db.insert('Materias', nuevaActividad.toJson());
    return res;
  }

  //Buscar actividad  ID
  Future<ActivityModel> getActividadId(int id) async {
    final db = await database;
    final res =
        await db.query('Actividad', where: 'idA = ?', whereArgs: [id]);
    return res.isNotEmpty ? ActivityModel.fromJson(res.first) : null;
  }

  //Consultar todos
  Future<List<ActivityModel>> getTodasActividades() async {
    final db = await database;
    final res = await db.query('Actividad');

    List<ActivityModel> list = res.isNotEmpty
        ? res.map((c) => ActivityModel.fromJson(c)).toList()
        : [];
    return list;
  }

  //Actualizar actividad ID
  Future<int> updateActividad(ActivityModel nuevaActividad) async {
    final db = await database;
    final res = await db.update('Actividad', nuevaActividad.toJson(),
        where: 'idA = ?', whereArgs: [nuevaActividad.idA]);
    return res;
  }

  //Eliminar actividad ID
  Future<int> deleteActividad(int id) async {
    final db = await database;
    final res =
        await db.delete('Actividad', where: 'idA = ?', whereArgs: [id]);
    return res;
  }


}
