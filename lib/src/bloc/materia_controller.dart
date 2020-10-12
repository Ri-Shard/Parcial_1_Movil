import 'package:get/get.dart';
import 'package:parcial1/src/models/subject_model.dart';
import 'package:parcial1/src/provider/db.dart';


class MateriaController extends GetxController {
  static void guardarMateria(SubjectModel nuevaMateria) async {
    await DBProvider.db.nuevaMateria(nuevaMateria);
  }

  Future<List<SubjectModel>> consultarMaterias() async {
    return await DBProvider.db.getAllSubject();
  }
    static void deleteSubject(int id) async {
    await DBProvider.db.deleteSubject(id);
  }
}
