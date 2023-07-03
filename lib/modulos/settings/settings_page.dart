import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/componentes/to_gain_button.dart';
import 'package:to_do/componentes/to_gain_button_simple.dart';
import 'package:to_do/modulos/cadastro/cadastro_page.dart';
import 'package:to_do/modulos/esqueci_minha_senha/esqueci_minha_senha_controller.dart';
import 'package:to_do/modulos/esqueci_minha_senha/esqueci_minha_senha_page.dart';
import 'package:to_do/modulos/login/login_page.dart';
import 'package:to_do/modulos/notes/notes_page.dart';
import 'package:to_do/modulos/settings/settings_controller.dart';

import '../../componentes/togain_text_field.dart';
import '../../db/globals.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();

  SettingsController settingsController = SettingsController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerName.text = Globals.user!.nome!;
    controllerEmail.text = Globals.user!.email!;
    controllerSenha.text = Globals.user!.senha!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff1E1E1E),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Color(0xff1E1E1E),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Image.asset('imagens/seta_esquerda.png'),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                settingsController.deleteConta(context);
              },
              child: Image.asset('imagens/delet.png'),
            )
          ],
          title: Text(
            'SETTINGS',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
            ),
            Center(
                // Center is a layout widget. It takes a single child and positions it
                // in the middle of the parent.
                child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'imagens/changephoto.png',
                    width: 150,
                    height: 150,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Change Profile Name',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  ToGainTextField(
                    label: '',
                    controller: controllerName,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'USER INFORMATION',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  ToGainTextField(
                    label: 'E-Mail',
                    controller: controllerEmail,
                    textColor: Colors.white,
                    errorText: settingsController.emailError,
                    onChanged: settingsController.setEmail,
                    color: Color(0xff178283),
                  ),
                  ToGainTextField(
                    label: 'PassWord',
                    controller: controllerSenha,
                    textColor: Colors.white,
                    errorText: settingsController.senhaError,
                    onChanged: settingsController.setSenha,
                    obscure: true,
                    color: Color(0xff178283),
                  ),
                  GestureDetector(
                    onTap: () {
                      settingsController.esqueciSenha(context);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(
                            const Radius.circular(20.0),
                          ),
                        ),
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        width: 150,
                        child: Center(
                          child: Text(
                            'Change-Pass',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )),
                  )
                ],
              ),
            )),
            Positioned(
                left: 0,
                bottom: 0,
                child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Color(0xff178283),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(80.0),
                          bottomRight: Radius.circular(40.0)),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Center(
                        child: Image.asset(
                      'imagens/trocar.png',
                      height: 30,
                      width: 30,
                    )))),
            Positioned(
                right: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Color(0xff953E3E),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(80.0),
                            bottomLeft: Radius.circular(40.0)),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Center(
                          child: Image.asset(
                        'imagens/logou.png',
                        height: 30,
                        width: 30,
                      ))),
                )),
          ],
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
