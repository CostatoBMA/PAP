import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/db/globals.dart';
import 'package:to_do/model/body_parties.dart';
import 'package:to_do/modulos/body/body_controller.dart';
import '../../model/body.dart';

class BodyPage extends StatefulWidget {
  const BodyPage({
    super.key,
  });

  @override
  State<BodyPage> createState() => _BodyPageState();
}

class _BodyPageState extends State<BodyPage> {
  BodyController bodyController = Get.put(BodyController());

  TextEditingController controllerKm = TextEditingController();
  TextEditingController controllerAge = TextEditingController();
  TextEditingController controlerWater = TextEditingController();
  TextEditingController controlerMuscle = TextEditingController();
  TextEditingController controlerBone = TextEditingController();
  TextEditingController controlerBmi = TextEditingController();
  TextEditingController controlerKcal = TextEditingController();
  TextEditingController controlerVIsceral = TextEditingController();
  TextEditingController controlerBody = TextEditingController();

  TextEditingController controlerCoxa = TextEditingController();
  TextEditingController controlerPeito = TextEditingController();
  TextEditingController controlerTriceps = TextEditingController();
  TextEditingController controlerPanturrilha = TextEditingController();
  TextEditingController controlerCintura = TextEditingController();
  TextEditingController controlerBiceps = TextEditingController();

  Body body = Body();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBody();

    controllerKm.text = '0';
    controlerBody.text = '0';
    controllerAge.text = '0';
    controlerWater.text = '0';
    controlerBone.text = '0';
    controlerBmi.text = '0';
    controlerVIsceral.text = '0';
    controlerKcal.text = '0';
    controlerMuscle.text = '0';

    bodyController.listBodyParties
        .add(BodyParties(img: 'coxa.png', name: 'Coxa'));
    bodyController.listBodyParties
        .add(BodyParties(img: 'peito.png', name: 'Peito'));
    bodyController.listBodyParties
        .add(BodyParties(img: 'triceps.png', name: 'Triceps'));
    bodyController.listBodyParties
        .add(BodyParties(img: 'panturilha.png', name: 'Panturilha'));
    bodyController.listBodyParties
        .add(BodyParties(img: 'cintura.png', name: 'Cintura'));
    bodyController.listBodyParties
        .add(BodyParties(img: 'biceps.png', name: 'Biceps'));
  }

  getBody() async {
    body = await bodyController.getBody(Globals.user!);
    //print(body.kilogramas);
    setState(() {
      controllerKm.text = body.kilogramas!;
      controllerAge.text = body.age!;
      controlerWater.text = body.water!;
      controlerBody.text = body.bodyFat!;
      controlerBone.text = body.bone!;
      controlerBmi.text = body.bmi!;
      controlerVIsceral.text = body.visceral!;
      controlerKcal.text = body.kcal!;
      controlerMuscle.text = body.muscle!;

      controlerCoxa.text = body.coxa!;
      controlerCintura.text = body.cintura!;
      controlerPanturrilha.text = body.panturrilha!;
      controlerBiceps.text = body.biceps!;
      controlerTriceps.text = body.triceps!;
      controlerPeito.text = body.peito!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff1E1E1E),
        appBar: AppBar(
          backgroundColor: Color(0xff1E1E1E),
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              if (body.kilogramas != null) {
                print('atualiza');
                Body body = Body();
                body.id = this.body.id;
                body.userid = Globals.user!.id;
                body.water = controlerWater.text;
                body.visceral = controlerVIsceral.text;
                body.kilogramas = controllerKm.text;
                body.muscle = controlerMuscle.text;

                body.age = controllerAge.text;
                body.bmi = controlerBmi.text;
                body.bone = controlerBone.text;
                body.bmi = controlerBmi.text;
                body.kcal = controlerKcal.text;
                body.bodyFat = controlerBody.text;

                body.panturrilha = controlerPanturrilha.text;
                body.peito = controlerPeito.text;
                body.triceps = controlerTriceps.text;
                body.biceps = controlerBiceps.text;
                body.coxa = controlerCoxa.text;
                body.cintura = controlerCintura.text;
                bodyController.updateTask(body!);

                Navigator.of(context).pop();
              } else {
                Body body = Body();
                body.userid = Globals.user!.id;
                body.water = controlerWater.text;
                body.visceral = controlerVIsceral.text;
                body.kilogramas = controllerKm.text;
                body.muscle = controlerMuscle.text;

                body.age = controllerAge.text;
                body.bmi = controlerBmi.text;
                body.bone = controlerBone.text;
                body.bmi = controlerBmi.text;
                body.kcal = controlerKcal.text;
                body.bodyFat = controlerBody.text;

                body.panturrilha = controlerPanturrilha.text;
                body.peito = controlerPeito.text;
                body.triceps = controlerTriceps.text;
                body.biceps = controlerBiceps.text;
                body.coxa = controlerCoxa.text;
                body.cintura = controlerCintura.text;
                bodyController.saveBody(body);

                Navigator.of(context).pop();
              }
            },
            child: Image.asset('imagens/seta_esquerda.png'),
          ),
          actions: [
            GestureDetector(
              onTap: () async {},
              child: Image.asset('imagens/print.png'),
            )
          ],
        ),
        body: Container(
            margin: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Color(0xff272526),
                            borderRadius: BorderRadius.all(
                              const Radius.circular(30.0),
                            ),
                            border: Border.all(
                                color: Colors.black,
                                width: 2.0,
                                style: BorderStyle.solid), //Border.all
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20, right: 20),
                                child: TextField(
                                  controller: controllerKm,
                                  style: TextStyle(
                                      fontSize: 35,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              Text(
                                'Kilogramas',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          )),
                      Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xff272526),
                            borderRadius: BorderRadius.all(
                              const Radius.circular(30.0),
                            ),
                            border: Border.all(
                                color: Colors.black,
                                width: 2.0,
                                style: BorderStyle.solid),  //Border.all
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: TextField(
                                  controller: controllerAge,
                                  style: TextStyle(
                                      fontSize: 35,
                                      color: Colors.white, fontWeight: FontWeight.normal),
                                ),
                                margin: EdgeInsets.only(left: 30, right: 30),
                              ),
                              Text(
                                'Age',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 200,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color(0xff272526),
                            borderRadius: BorderRadius.all(
                              const Radius.circular(20.0),
                            ),
                            border: Border.all(
                                color: const Color(0xFF178283),
                                width: 1.0,
                                style: BorderStyle.solid), //Border.all
                          ),
                          child: TextField(
                            controller: controlerMuscle, style: TextStyle(color: Colors.white)
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Muscle mass',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white, fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 200,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color(0xff272526),
                            borderRadius: BorderRadius.all(
                              const Radius.circular(20.0),
                            ),
                            border: Border.all(
                                color: const Color(0xFF178283),
                                width: 1.0, style: BorderStyle.solid, ), //Border.all
                          ),
                          child: TextField(
                            controller: controlerBody,  style: TextStyle(color: Colors.white)
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Body fat',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white, fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 200,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color(0xff272526),
                            borderRadius: BorderRadius.all(
                              const Radius.circular(20.0),
                            ),
                            border: Border.all(
                                color: const Color(0xFF178283),
                                width: 1.0,
                                style: BorderStyle.solid), //Border.all
                          ),
                          child: TextField(
                            controller: controlerBone, style: TextStyle(color: Colors.white)
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Bone mass',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 200,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color(0xff272526),
                            borderRadius: BorderRadius.all(
                              const Radius.circular(20.0),
                            ),
                            border: Border.all(
                                color: const Color(0xFF178283),
                                width: 1.0,
                                style: BorderStyle.solid), //Border.all
                          ),
                          child: TextField(
                            controller: controlerBmi, style: TextStyle(color: Colors.white)
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'BMI',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 200,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color(0xff272526),
                            borderRadius: BorderRadius.all(
                              const Radius.circular(20.0),
                            ),
                            border: Border.all(
                                color: const Color(0xFF178283),
                                width: 1.0,
                                style: BorderStyle.solid), //Border.all
                          ),
                          child: TextField(
                            controller: controlerKcal, style: TextStyle(color: Colors.white)
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Kcal',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 200,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Color(0xff272526),
                              borderRadius: BorderRadius.all(
                                const Radius.circular(20.0),
                              ),
                              border: Border.all(
                                  color: const Color(0xFF178283),
                                  width: 1.0,
                                  style: BorderStyle.solid), //Border.all
                            ),
                            child: TextField(
                              controller: controlerWater, style: TextStyle(color: Colors.white)
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Water',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 200,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color(0xff272526),
                            borderRadius: BorderRadius.all(
                              const Radius.circular(20.0),
                            ),
                            border: Border.all(
                                color: const Color(0xFF178283),
                                width: 1.0,
                                style: BorderStyle.solid), //Border.all
                          ),
                          child: TextField(
                            controller: controlerVIsceral, style: TextStyle(color: Colors.white)
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Visceral fat',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: bodyController.listBodyParties.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            decoration: BoxDecoration(
                              color: const Color(0xFF178283).withOpacity(0.5),
                              borderRadius: BorderRadius.all(
                                const Radius.circular(20.0),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF178283),
                                    borderRadius: BorderRadius.all(
                                      const Radius.circular(20.0),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'imagens/${bodyController.listBodyParties[index].img}',
                                        width: 120,
                                        height: 100,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        bodyController
                                            .listBodyParties[index].name!,
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: 100,
                                  child: TextField(
                                    controller: bodyController
                                                .listBodyParties[index].name! ==
                                            'Coxa'
                                        ? controlerCoxa
                                        : bodyController.listBodyParties[index]
                                                    .name! ==
                                                'Peito'
                                            ? controlerPeito
                                            : bodyController
                                                        .listBodyParties[index]
                                                        .name! ==
                                                    'Triceps'
                                                ? controlerTriceps
                                                : bodyController
                                                            .listBodyParties[
                                                                index]
                                                            .name! ==
                                                        'Biceps'
                                                    ? controlerBiceps
                                                    : bodyController
                                                                .listBodyParties[
                                                                    index]
                                                                .name! ==
                                                            'Cintura'
                                                        ? controlerCintura
                                                        : controlerPanturrilha,
                                    style: TextStyle(
                                        fontSize: 50,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal),
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                ],
              ),
            ))
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
