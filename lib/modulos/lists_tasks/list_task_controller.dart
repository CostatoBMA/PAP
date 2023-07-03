import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:to_do/db/dao/tasks_dao.dart';
import 'package:to_do/model/task.dart';
import 'package:to_do/model/user.dart';

class ListTaskController extends GetxController {
  List<Task>? listTask = [];
  List<TextEditingController> listTextController = [];
  TasksDao taskDao = TasksDao();

  getTaskList(User user, String date) async {
    print('id:${user.id}');
    try {
      listTask = await taskDao.getTask(user.id!, date: date);
      for (int i = 0; i < listTask!.length; i++) {
        listTextController.add(TextEditingController(text: listTask![i].nome));
      }
    } catch (e) {}
    update();
  }

  saveTask(Task task) async {
    int id = await taskDao.save(task);
  }

  updateTask(Task task) {
    taskDao.update(task);
  }

  deleteTask(Task task) {
    taskDao.delete(task.id!);
  }
}
