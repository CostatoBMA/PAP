import 'package:flutter/material.dart';
import 'package:to_do/db/dao/user_dao.dart';
import 'package:to_do/model/user.dart';
import 'package:to_do/modulos/home/home_page.dart';

class EsqueciMinhaSenhaController {
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

  esqueciSenha(BuildContext context) async {
    if (email!.isEmpty) {
      emailError = 'Campo está vazio';
    }
    if (senha!.isEmpty) {
      senhaError = 'Campo está vazio';
    }

    int id = await userDao.esqueciMinhaSenha(email!, senha!);

    if (id != null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
    }
    print('O id do user é:');
  }
}
