import 'package:get/get.dart';
import 'package:parcial1/src/models/activity_model.dart';
import 'package:parcial1/src/provider/db.dart';


class ActivityController extends GetxController {
  static void saveActivity(ActivityModel newActivity) async {
    await DBProvider.db.nuevaActividad(newActivity);
  }

  Future<List<ActivityModel>> allActivities() async {
    return await DBProvider.db.getTodasActividades();
  }
    static void deleteActivity(int id) async {
    await DBProvider.db.deleteActividad(id);
  }
    static void updateActivity(ActivityModel newActivity) async {
    await DBProvider.db.updateActividad(newActivity);
  }
}