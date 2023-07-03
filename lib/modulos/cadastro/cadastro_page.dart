import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/componentes/to_gain_button.dart';
import 'package:to_do/componentes/to_gain_button_simple.dart';
import 'package:to_do/modulos/cadastro/cadastro_controller.dart';

import '../../componentes/togain_text_field.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({
    super.key,
  });

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  TextEditingController controllerFirstName = TextEditingController();
  TextEditingController controllerLastName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerPasswordConfirm = TextEditingController();

  CadastroController cadastroController = Get.put(CadastroController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff1E1E1E),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'imagens/logo.png',
                width: 200,
                height: 200,
              ),
              ToGainTextField(
                label: 'First Name',
                onChanged: cadastroController.setFirstName,
                errorText: cadastroController.firstNameError,
                controller: controllerFirstName,
              ),
              ToGainTextField(
                errorText: cadastroController.lastNameError,
                onChanged: cadastroController.setLatName,
                label: 'Last Name',
                controller: controllerLastName,
              ),
              GetBuilder<CadastroController>(
                builder: (_) => ToGainTextField(
                  label: 'Email',
                  errorText: cadastroController.emailError,
                  onChanged: cadastroController.setEmail,
                  controller: controllerEmail,
                ),
              ),
              GetBuilder<CadastroController>(
                builder: (_) => ToGainTextField(
                  errorText: cadastroController.senhaError,
                  label: 'Password',
                  controller: controllerPassword,
                  obscure: true,
                  onChanged: cadastroController.setSenha,
                ),
              ),
              ToGainTextField(
                errorText: cadastroController.senhaConfirmError,
                label: 'Confirm Password',
                obscure: true,
                onChanged: cadastroController.setSenhaConfirm,
                controller: controllerPasswordConfirm,
              ),
              GestureDetector(
                onTap: () {
                  cadastroController.userCadastro(context);
                },
                child: ToGainButton(
                  label: 'CREATE ACCOUNT',
                ),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Back to Login',
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
