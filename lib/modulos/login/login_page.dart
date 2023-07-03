import 'package:flutter/material.dart';
import 'package:to_do/componentes/to_gain_button.dart';
import 'package:to_do/componentes/to_gain_button_simple.dart';
import 'package:to_do/modulos/body/body_page.dart';
import 'package:to_do/modulos/cadastro/cadastro_page.dart';
import 'package:to_do/modulos/esqueci_minha_senha/esqueci_minha_senha_page.dart';
import 'package:to_do/modulos/home/home_page.dart';
import 'package:to_do/modulos/lists_tasks/lists_task_page.dart';
import 'package:to_do/modulos/loading/loading_page.dart';
import 'package:to_do/modulos/login/login_controller.dart';
import 'package:to_do/modulos/notes/notes_page.dart';
import 'package:to_do/modulos/settings/settings_page.dart';

import '../../componentes/togain_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();

  LoginController loginController = LoginController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginController.loginShared(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff1E1E1E),
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
            ),
            Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('imagens/logo.png'),
                  ToGainTextField(
                    onChanged: loginController.setEmail,
                    errorText: loginController.emailError,
                    label: 'email',
                    controller: controllerEmail,
                  ),
                  ToGainTextField(
                    onChanged: loginController.setSenha,
                    errorText: loginController.senhaError,
                    obscure: true,
                    label: 'senha',
                    controller: controllerSenha,
                  ),
                  GestureDetector(
                    onTap: () {
                      loginController.userLogin(context);
                    },
                    child: ToGainButton(
                      label: 'Login',
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ToGainButtonSimple(
                        icon: 'facebook',
                      ),
                      ToGainButtonSimple(
                        icon: 'email',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: 20,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: GestureDetector(
                      onTap: () {
                        modal();
                      },
                      child: Container(
                        child: Image.asset(
                          'imagens/seta.png',
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ))))
          ],
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  modal() {
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Color(0xff178283),
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(80.0),
                    topRight: const Radius.circular(80.0),
                  ),
                ),
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EsqueciMinhaSenhaPage()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'imagens/forgot.png',
                            height: 30,
                            width: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'FORGOT PASSWORD',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CadastroPage()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'imagens/create.png',
                              height: 30,
                              width: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'CREATE AN ACCOUNT',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ))
                  ],
                ));
          });
        });
  }
}
