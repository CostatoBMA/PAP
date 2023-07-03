import 'package:flutter/material.dart';
import 'package:to_do/componentes/to_gain_button.dart';
import 'package:to_do/componentes/to_gain_button_simple.dart';
import 'package:to_do/modulos/cadastro/cadastro_page.dart';
import 'package:to_do/modulos/esqueci_minha_senha/esqueci_minha_senha_page.dart';

import '../../componentes/togain_text_field.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({
    super.key,
  });

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff178283),
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
                  Image.asset('imagens/stabilit_core_logo.png'),
                ],
              ),
            ),
          ],
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
