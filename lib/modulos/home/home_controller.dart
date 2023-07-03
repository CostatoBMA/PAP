import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/db/dao/tasks_dao.dart';
import 'package:to_do/model/task.dart';
import 'package:to_do/model/user.dart';

class HomeController extends GetxController {
  List<Task>? listTask = [];
  TasksDao taskDao = TasksDao();
  int? garrafaVazia = 10;
  int? garrafaCheia = 0;

  bool isCup = false;

  getGarrafa() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isCup = prefs.getBool('isCup') ?? false;
    garrafaVazia = prefs.getInt('garrafaVazia') ?? 10;
    garrafaCheia = prefs.getInt('garrafaCheia') ?? 0;
    update();
  }

  getTaskList(User user) async {
    print('id:${user.id}');
    try {
      listTask = await taskDao.getTask(user.id!);
    } catch (e) {}
    update();
  }
}
