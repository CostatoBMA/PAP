import 'package:sqflite/sqflite.dart';
import 'package:to_do/db/open_database.dart';
import 'package:to_do/model/user.dart';

import '../../model/body.dart';

class BodyDao {
  static const String tabelaBody = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_idUser INTEGER, '
      '$_kilogramas TEX, '
      '$_age TEXT, '
      '$_muscleMass TEXT, '
      '$_body TEXT, '
      '$_bone TEXT, '
      '$_bmi TEXT, '
      '$_kcal TEXT, '
      '$_water TEXT, '
      '$_visceral TEXT, '
      '$_coxa TEXT, '
      '$_biceps TEXT, '
      '$_triceps TEXT, '
      '$_peito TEXT, '
      '$_panturrilha TEXT, '
      '$_cintura TEXT )';

  static const String _tableName = 'BODY';

  static const String _id = 'id';
  static const String _idUser = 'iduser';
  static const String _muscleMass = 'muscle';
  static const String _body = 'body';
  static const String _kilogramas = 'kilogramas';
  static const String _age = 'age';
  static const String _bone = 'bone';
  static const String _bmi = 'bmi';
  static const String _kcal = 'kcal';
  static const String _water = 'water';
  static const String _visceral = 'visceral';
  static const String _coxa = 'coxa';
  static const String _biceps = 'biceps';
  static const String _triceps = 'triceps';
  static const String _peito = 'peito';
  static const String _panturrilha = 'panturrilha';
  static const String _cintura = 'cintura';

  Future<int> save(Body task) async {
    final Database db = await getDatabase();
    Map<String, dynamic> equipesMap = task.toJson();
    return db.insert(_tableName, equipesMap);
  }

  Future<Body> getBody(User user) async {
    Body? body = Body();
    try {
      final Database db = await getDatabase();
      List<Map<String, dynamic>> result;

      result = await db.query(
        _tableName,
        where: '$_idUser = ?',
        whereArgs: [user.id],
      );

      print(result.first['kilogramas']);

      Body body = Body();
      body.bmi = result.first['bmi'];
      body.kilogramas = result.first['kilogramas'].toString();
      body.muscle = result.first['muscle'].toString();
      body.visceral = result.first['visceral'].toString();
      body.bone = result.first['bone'].toString();
      body.water = result.first['water'].toString();
      body.kcal = result.first['kcal'].toString();
      body.bodyFat = result.first['body'].toString();
      body.age = result.first['age'].toString();
      body.cintura = result.first['cintura'].toString();
      body.panturrilha = result.first['panturrilha'].toString();
      body.biceps = result.first['biceps'].toString();
      body.coxa = result.first['coxa'].toString();
      body.peito = result.first['peito'].toString();
      body.triceps = result.first['triceps'].toString();
      body.userid = result.first['iduser'];
      body.id = result.first['id'];
      print(body.kilogramas);
      return body;
    } catch (e) {}
    return Body();
  }

  Future<int> update(Body body) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> equipeMap = body.toJson();
    print(equipeMap);
    return db.update(
      _tableName,
      equipeMap,
      where: '$_id = ?',
      whereArgs: [body.id],
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
