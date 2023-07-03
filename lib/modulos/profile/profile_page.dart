import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:to_do/modulos/profile/profile_controller.dart';
import 'package:to_do/modulos/settings/settings_controller.dart';

import '../../componentes/togain_text_field.dart';
import '../../db/globals.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileController profileController = ProfileController();
  TextEditingController controller = TextEditingController();
  TextEditingController controllerDate1 = TextEditingController();
  TextEditingController controllerDate2 = TextEditingController();

  bool delete = false;
  bool deleteAFter = false;
  bool deleteBefore = false;
  bool edit = false;

  File? imageFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = Globals.user!.nome!;

    if (Globals.user!.pathImage != null) {
      imageFile = File(Globals.user!.pathImage!);
    }
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
                  if (edit == false) {
                    setState(() {
                      edit = true;
                    });
                  } else {
                    setState(() {
                      edit = false;
                    });
                  }
                },
                child: Image.asset('imagens/edit.png'),
              )
            ],
            title: Text(
              Globals.user!.nome!,
              style: TextStyle(color: Colors.white, fontSize: 18),
            )),
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: 130,
                      height: 130,
                      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                      decoration: BoxDecoration(
                        color: Color(0xff2C2C2C),
                        borderRadius: BorderRadius.all(Radius.circular(90.0)),
                        border: Border.all(
                            color: Color(0xff178283),
                            width: 5.0,
                            style: BorderStyle.solid),
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          final ImagePicker picker = ImagePicker();
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery);
                          setState(() {
                            imageFile = File(image!.path);
                          });
                          profileController.editarImagePerfil(image!.path);
                        },
                        onLongPress: () {
                          setState(() {
                            delete = true;
                          });
                        },
                        child: delete == false
                            ? imageFile != null
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.grey.shade200,
                                    backgroundImage: FileImage(
                                      imageFile!,
                                    ),
                                  )
                                : Image.asset(
                                    'imagens/profile.png',
                                    width: 100,
                                    height: 100,
                                  )
                            : Image.asset(
                                'imagens/lixovermelho.png',
                              ),
                      )),
                  Container(
                      width: 200,
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                      decoration: BoxDecoration(
                        color: Color(0xff2C2C2C),
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        border: Border.all(
                            color: Colors.white,
                            width: 1.0,
                            style: BorderStyle.solid),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'TASK DONE',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '0',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      )),
                  Divider(
                    color: Colors.white,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          GestureDetector(

                            onTap: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? image = await picker.pickImage(
                                  source: ImageSource.gallery);
                              // setState(() {
                              //   imageFile = File(image!.path);
                              // });
                              profileController.editarBeforeFoto(image!.path);
                            },
                            onLongPress: (){


                                setState(() {
                                  deleteBefore = true;
                                });

                            },
                            child:deleteBefore == true ?
                           GestureDetector(
    onTap: (){
      if(deleteBefore == true){
        profileController.editarBeforeFoto('');
        setState(() {
          deleteBefore = false;
        });
      }
    },
    child:Image.asset(
      'imagens/lixovermelho.png', width: 150,height: 150,
    ) ,
    ) : Container(
                                width: 155,
                                height: 130,
                                margin: EdgeInsets.all(10),

                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                child: Globals.user!.beforeFoto != null
                                    ? Container(

                                  decoration: BoxDecoration(

                                      image: DecorationImage(
                                        image: FileImage(
                                          File(Globals.user!.beforeFoto!),
                                        ),
                                      )
                                  ),
                                )
                                    : Center(
                                        child: Image.asset(
                                          'imagens/plus.png',
                                          width: 100,
                                          height: 100,
                                        ),
                                      )),
                          ),
                          edit == false
                              ? Text(
                                  'BEFORE\n${Globals.user!.primeiraData!}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                )
                              : SizedBox(
                                  width: 100,
                                  height: 20,
                                  child: TextField(
                                    controller: controllerDate1,
                                    onSubmitted: (value) {
                                      profileController
                                          .editarPrimeiraData(value);
                                    },
                                  ),
                                )
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? image = await picker.pickImage(
                                  source: ImageSource.gallery);
                              // setState(() {
                              //   imageFile = File(image!.path);
                              // });
                              profileController.editarAfterFoto(image!.path);
                            },
                            onLongPress: (){

                                setState(() {
                                  deleteAFter = true;
                                });

                            },
                            child:deleteAFter == true ?
                                GestureDetector(
                                  onTap: (){
                                    profileController.editarAfterFoto('');
                                    setState(() {
                                      deleteAFter = false;
                                    });
                                  },
                                  child:  Image.asset(
                                    'imagens/lixovermelho.png',width: 150,height: 150,
                                  ),
                                )
                           :Container(
                                width: 155,
                                height: 130,
                                margin: EdgeInsets.all(10),

                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                child: Globals.user!.afterFoto != null
                                    ? Container(

                                       decoration: BoxDecoration(

                                          image: DecorationImage(
                                            image: FileImage(
                                              File(Globals.user!.afterFoto!),
                                            ),
                                          )
                                       ),
                                      )
                                    : Center(
                                        child: Image.asset(
                                          'imagens/plus.png',
                                          width: 100,
                                          height: 100,
                                        ),
                                      )),
                          ),
                          edit == false
                              ? Text(
                                  'AFTER\n${Globals.user!.segundaData!}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                )
                              : SizedBox(
                                  width: 80,
                                  height: 20,
                                  child: TextField(
                                    controller: controllerDate2,
                                    onSubmitted: (value) {
                                      profileController
                                          .editarSegundaData(value);
                                    },
                                  ),
                                ),
                        ],
                      )
                    ],
                  ),
                  Image.asset(
                    'imagens/logo_extensa.png',
                    height: 200,
                  ),
                ],
              ),
            )
          ],
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
