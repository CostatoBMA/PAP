import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do/db/dao/body_dao.dart';
import 'package:to_do/db/dao/notes_dao.dart';
import 'package:to_do/db/dao/tasks_dao.dart';
import 'package:to_do/db/dao/user_dao.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'todo.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(UserDao.tabelaUser);
      db.execute(TasksDao.tabelaTask);
      db.execute(NotesDao.tabelaNotes);
      db.execute(BodyDao.tabelaBody);
    },
    version: 1,
  );
}
