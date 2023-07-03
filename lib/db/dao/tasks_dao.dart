import 'package:sqflite/sqflite.dart';
import 'package:to_do/db/open_database.dart';
import 'package:to_do/model/task.dart';

class TasksDao {
  static const String tabelaTask = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_idUser INTEGER, '
      '$_name TEXT, '
      '$_status INTEGER, '
      '$_inicio TEXT)';

  static const String _id = 'id';
  static const String _idUser = 'iduser';
  static const String _name = 'name';
  static const String _status = 'status';
  static const String _inicio = 'inicio';
  static const String _tableName = 'tasks';

  Future<int> save(Task task) async {
    final Database db = await getDatabase();
    Map<String, dynamic> equipesMap = task.toJson();
    return db.insert(_tableName, equipesMap);
  }

  Future<List<Task>> getTask(int idEquipe, {String? date}) async {
    try {
      final Database db = await getDatabase();
      List<Map<String, dynamic>> result;
      if (date != null) {
        result = await db.query(
          _tableName,
          where: '$_idUser = ? AND $_inicio = ?',
          whereArgs: [idEquipe, date],
        );
      } else {
        result = await db.query(
          _tableName,
          where: '$_idUser = ?',
          whereArgs: [idEquipe],
        );
      }

      print(result);
      final List<Task> task = [];
      result.forEach((v) => {task.add(Task.fromJson(v))});
      return task;
    } catch (e) {}
    return [];
  }

  Future<int> update(Task task) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> equipeMap = task.toJson();
    return db.update(
      _tableName,
      equipeMap,
      where: '$_id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> delete(int id) async {
    final Database db = await getDatabase();
    return db.delete(
      _tableName,
      where: '$_id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAllUser(int id) async {
    final Database db = await getDatabase();
    return db.delete(
      _tableName,
      where: '$_idUser = ?',
      whereArgs: [id],
    );
  }
}
