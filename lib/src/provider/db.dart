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

    final path = join(documentsDirectory.path, 'DB.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('CREATE TABLE Subject ('
            ' idS INTEGER PRIMARY KEY,'
            ' subjectName TEXT,'
            ' idA INTEGER,'
            ' primerCorte NUMERIC(3,2),'
            ' segundoCorte NUMERIC(3,2),'
            ' tecerCorte NUMERIC(3,2),'
            ' definitiva NUMERIC(3,2)'
            ')');
        await db.execute('CREATE TABLE Activity ('
            ' idA INTEGER PRIMARY KEY,'
            ' activityName TEXT,'
            ' activityNote NUMERIC(3,2),'
            ' percent INTEGER,'
            ' corte INTEGER'
            ')');
      },
    );
  }

//Materia
  nuevaMateria(SubjectModel nuevaMateria) async {
    final db = await database;
    final res = await db.insert('Subject', nuevaMateria.toJson());
    return res;
  }

  Future<SubjectModel> getSubjectId(int id) async {
    final db = await database;
    final res = await db.query('Subject', where: 'idS = ?', whereArgs: [id]);
    return res.isNotEmpty ? SubjectModel.fromJson(res.first) : null;
  }

  Future<List<SubjectModel>> getAllSubject() async {
    final db = await database;
    final res = await db.query('Subject');

    List<SubjectModel> list =
        res.isNotEmpty ? res.map((c) => SubjectModel.fromJson(c)).toList() : [];
    return list;
  }

  Future<int> updateSubject(SubjectModel nuevaMateria) async {
    final db = await database;
    final res = await db.update('Subject', nuevaMateria.toJson(),
        where: 'idS = ?', whereArgs: [nuevaMateria.idS]);
    return res;
  }

  Future<int> deleteSubject(int id) async {
    final db = await database;
    final res = await db.delete('Subject', where: 'idS = ?', whereArgs: [id]);
    return res;
  }
//Actividad
  nuevaActividad(ActivityModel nuevaActividad) async {
    final db = await database;
    final res = await db.insert('Activity', nuevaActividad.toJson());
    return res;
  }

  Future<ActivityModel> getActividadId(int id) async {
    final db = await database;
    final res = await db.query('Activity', where: 'idA = ?', whereArgs: [id]);
    return res.isNotEmpty ? ActivityModel.fromJson(res.first) : null;
  }

  Future<List<ActivityModel>> getTodasActividades() async {
    final db = await database;
    final res = await db.query('Activity');

    List<ActivityModel> list = res.isNotEmpty
        ? res.map((c) => ActivityModel.fromJson(c)).toList()
        : [];
    return list;
  }

  Future<int> updateActividad(ActivityModel nuevaActividad) async {
    final db = await database;
    final res = await db.update('Activity', nuevaActividad.toJson(),
        where: 'idA = ?', whereArgs: [nuevaActividad.idA]);
    return res;
  }

  Future<int> deleteActividad(int id) async {
    final db = await database;
    final res = await db.delete('Activity', where: 'idA = ?', whereArgs: [id]);
    return res;
  }
}
