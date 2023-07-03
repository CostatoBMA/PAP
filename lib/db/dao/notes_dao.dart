import 'package:sqflite/sqflite.dart';
import 'package:to_do/db/open_database.dart';
import 'package:to_do/model/notes.dart';
import 'package:to_do/model/task.dart';

class NotesDao {
  static const String tabelaNotes = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_idUser INTEGER, '
      '$_name TEXT, '
      '$_checkList TEXT, '
      '$_pinned INTEGER, '
      '$_inicio TEXT)';

  static const String _id = 'id';
  static const String _idUser = 'iduser';
  static const String _name = 'name';
  static const String _checkList = 'checkList';
  static const String _pinned = 'pinned';
  static const String _tableName = 'notes';
  static const String _inicio = 'inicio';

  Future<int> save(Notes notes) async {
    final Database db = await getDatabase();
    Map<String, dynamic> equipesMap = notes.toJson();
    return db.insert(_tableName, equipesMap);
  }

  Future<List<Notes>> getNotes(int idEquipe,
      {int? pinned, String? date}) async {
    try {
      final Database db = await getDatabase();
      List<Map<String, dynamic>> result;
      if (pinned != null) {
        result = await db.query(
          _tableName,
          where: '$_idUser = ? AND $_pinned = ?',
          whereArgs: [idEquipe, pinned],
        );
      } else if (date != null) {
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
      final List<Notes> notes = [];
      result.forEach((v) => {notes.add(Notes.fromJson(v))});
      return notes;
    } catch (e) {}
    return [];
  }

  Future<int> update(Notes notes) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> equipeMap = notes.toJson();
    return db.update(
      _tableName,
      equipeMap,
      where: '$_id = ?',
      whereArgs: [notes.id],
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
