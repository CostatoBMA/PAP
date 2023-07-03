import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/db/dao/user_dao.dart';
import 'package:to_do/db/globals.dart';
import 'package:to_do/model/user.dart';
import 'package:to_do/modulos/home/home_page.dart';
import 'package:to_do/modulos/login/login_page.dart';

class CadastroController extends GetxController {
  User user = User();
  UserDao userDao = UserDao();

  String? firstName;

  String? firstNameError;

  String? lastName;

  String? lastNameError;

  String? email;

  String? emailError;

  String? senha;

  String? senhaError;

  String? senhaConfirm;

  String? senhaConfirmError;

  setFirstName(String name) {
    firstName = name;
  }

  setLatName(String name) {
    lastName = name;
  }

  setEmail(String email) {
    this.email = email;
  }

  setSenha(String senha) {
    this.senha = senha;
  }

  setSenhaConfirm(String senha) {
    this.senhaConfirm = senha;
  }

  userCadastro(BuildContext context) async {
    if (firstName!.isEmpty) {
      firstNameError = 'Campo está vazio';
      return;
    }
    if (lastName!.isEmpty) {
      lastNameError = 'Campo está vazio';
      return;
    }
    if (email!.isEmpty) {
      emailError = 'Campo está vazio';
      update();
      return;
    }
    if (!isValidEmail(email!)) {
      emailError = 'Você precisa adicionar um email valido';
      update();
      return;
    }
    if (senha!.isEmpty) {
      senhaError = 'Campo está vazio';
      return;
    }
    if (senhaConfirm!.isEmpty) {
      senhaConfirmError = 'Campo está vazio';
      return;
    }

    if (senha != senhaConfirm) {
      senhaError = 'As senhas precisam ser iguais';
      update();
      return;
    }

    user.nome = '$firstName $lastName';
    user.email = email;
    user.senha = senha;
    user.primeiraData = '';
    user.segundaData = '';
    int id = await userDao.save(user);
    print('O id do user é:');
    if (id != null) {
      user.id = id;

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginPage()));
    }
    print(id);
  }

  bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }
}
