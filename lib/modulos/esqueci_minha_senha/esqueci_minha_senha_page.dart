import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/componentes/to_gain_button.dart';
import 'package:to_do/componentes/to_gain_button_simple.dart';
import 'package:to_do/modulos/esqueci_minha_senha/esqueci_minha_senha_controller.dart';
import 'package:to_do/modulos/login/login_page.dart';

import '../../componentes/togain_text_field.dart';

class EsqueciMinhaSenhaPage extends StatefulWidget {
  const EsqueciMinhaSenhaPage({
    super.key,
  });

  @override
  State<EsqueciMinhaSenhaPage> createState() => _EsqueciMinhaSenhaPageState();
}

class _EsqueciMinhaSenhaPageState extends State<EsqueciMinhaSenhaPage> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();

  EsqueciMinhaSenhaController esqueciMinhaSenhaController =
      EsqueciMinhaSenhaController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff1E1E1E),
        body: SafeArea(
            child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      'imagens/avatar.png',
                      width: 150,
                      fit: BoxFit.fill,
                      height: 250,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Row(
                          children: [
                            Text(
                              'FORGOT',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 40),
                            ),
                            Text(
                              ' your',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 30),
                            )
                          ],
                        ),
                        Text(
                          'PASSWORD',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 40),
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                    padding: EdgeInsets.all(30),
                    child: Text(
                      'Enter the email address you wish to reset your password.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
                ToGainTextField(
                  errorText: esqueciMinhaSenhaController.emailError,
                  onChanged: esqueciMinhaSenhaController.setEmail,
                  label: 'E-mail',
                  controller: controllerEmail,
                ),
                ToGainTextField(
                  obscure: true,
                  onChanged: esqueciMinhaSenhaController.setSenha,
                  label: 'Escreva a nova senha',
                  errorText: esqueciMinhaSenhaController.senhaError,
                  controller: controllerSenha,
                ),
                GestureDetector(
                  onTap: () {
                    esqueciMinhaSenhaController.esqueciSenha(context);
                  },
                  child: ToGainButton(
                    label: 'REDEFINE PASSWORD',
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text(
                    'Back to Login',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
            Positioned(
                bottom: 20,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: Container(
                      child: Image.asset(
                        'imagens/logo.png',
                        height: 50,
                        width: 50,
                      ),
                    ))))
          ],
        ))
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
