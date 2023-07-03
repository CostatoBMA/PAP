import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/db/dao/body_dao.dart';
import 'package:to_do/db/dao/notes_dao.dart';
import 'package:to_do/db/dao/tasks_dao.dart';
import 'package:to_do/db/globals.dart';
import 'package:to_do/modulos/home/home_page.dart';
import 'package:to_do/modulos/login/login_page.dart';

import '../../db/dao/user_dao.dart';

class SettingsController extends GetxController {
  UserDao userDao = UserDao();
  TasksDao task = TasksDao();
  BodyDao body = BodyDao();
  NotesDao notes = NotesDao();

  String? email = '';

  String? emailError;

  String? senha;

  String? senhaError;

  setEmail(String email) {
    this.email = email;
  }

  setSenha(String senha) {
    this.senha = senha;
  }

  deleteConta(BuildContext context) async {
    userDao.delete(Globals.user!.id!);
    task.deleteAllUser(Globals.user!.id!);
    body.deleteAllUser(Globals.user!.id!);
    notes.deleteAllUser(Globals.user!.id!);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  esqueciSenha(BuildContext context) async {
    if (email == '') {
      email = Globals.user!.nome;
    }
    if (senha!.isEmpty) {
      senhaError = 'Campo está vazio';
    }

    int id = await userDao.esqueciMinhaSenhaId(
        Globals.user!.id.toString(), Globals.user!.nome!, senha!);

    if (id != null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
    }
    print('O id do user é:');
  }
}
