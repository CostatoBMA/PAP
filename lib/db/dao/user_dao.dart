import 'package:sqflite/sqflite.dart';
import 'package:to_do/db/open_database.dart';
import 'package:to_do/model/user.dart';

class UserDao {
  static const String tabelaUser = 'CREATE TABLE $_tableName('
      '$_idUser INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_senha TEXT, '
      '$_afterFoto TEXT, '
      '$_beforeFoto TEXT, '
      '$_primeiraData TEXT, '
      '$_segundaData TEXT, '
      '$_pathImage TEXT, '
      '$_email TEXT)';

  static const String _idUser = 'id';
  static const String _name = 'name';
  static const String _senha = 'senha';
  static const String _primeiraData = 'primeiraData';
  static const String _segundaData = 'segundaData';
  static const String _afterFoto = 'afterFoto';
  static const String _beforeFoto = 'beforeFoto';
  static const String _email = 'email';
  static const String _pathImage = 'pathImage';
  static const String _tableName = 'user';

  Future<int> save(User user) async {
    final Database db = await getDatabase();
    Map<String, dynamic> equipesMap = user.toJson();
    return db.insert(_tableName, equipesMap);
  }

  Future<User> findUser(int idEquipe) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(
      _tableName,
      where: '$_idUser = ?',
      whereArgs: [idEquipe],
    );
    final List<User> user = [];
    result.forEach((v) => {user.add(User.fromJson(v))});
    return user.first;
  }

  Future<User> login(String email, String senha) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(
      _tableName,
      where: '$_email = ? AND $_senha = ?',
      whereArgs: [email, senha],
    );
    final List<User> user = [];
    result.forEach((v) => {user.add(User.fromJson(v))});
    return user.first;
  }

  Future<int> esqueciMinhaSenha(String email, String senhaNova) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(
      _tableName,
      where: '$_email = ?',
      whereArgs: [email],
    );
    final List<User> user = [];
    print(result);
    result.forEach((v) => {user.add(User.fromJson(v))});
    user.first.senha = senhaNova;
    final Map<String, dynamic> equipeMap = user.first.toJson();
    return db.update(
      _tableName,
      equipeMap,
      where: '$_email = ?',
      whereArgs: [email],
    );
  }

  Future<int> esqueciMinhaSenhaId(
      String id, String email, String senhaNova) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(
      _tableName,
      where: '$_idUser = ?',
      whereArgs: [id],
    );
    final List<User> user = [];
    print(result);
    result.forEach((v) => {user.add(User.fromJson(v))});
    user.first.senha = senhaNova;
    final Map<String, dynamic> equipeMap = user.first.toJson();
    return db.update(
      _tableName,
      equipeMap,
      where: '$_idUser = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(User user) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> equipeMap = user.toJson();
    return db.update(
      _tableName,
      equipeMap,
      where: '$_idUser = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> delete(int id) async {
    final Database db = await getDatabase();
    return db.delete(
      _tableName,
      where: '$id = ?',
      whereArgs: [id],
    );
  }
}
