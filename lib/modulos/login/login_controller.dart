import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/db/dao/user_dao.dart';
import 'package:to_do/db/globals.dart';
import 'package:to_do/model/user.dart';
import 'package:to_do/modulos/home/home_page.dart';

class LoginController {
  UserDao userDao = UserDao();

  String? email;

  String? emailError;

  String? senha;

  String? senhaError;

  setEmail(String email) {
    this.email = email;
  }

  setSenha(String senha) {
    this.senha = senha;
  }

  loginShared(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('login');
    senha = prefs.getString('senha');
    userLogin(context);
  }

  userLogin(BuildContext context) async {
    if (email!.isEmpty) {
      emailError = 'Campo está vazio';
    }
    if (senha!.isEmpty) {
      senhaError = 'Campo está vazio';
    }

    User user = await userDao.login(email!, senha!);

    if (user.id != null) {
      Globals.user = user;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('login', user.email!);
      await prefs.setString('senha', user.senha!);

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
    }
    print('O id do user é:');
  }
}
