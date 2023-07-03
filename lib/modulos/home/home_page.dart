import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/db/globals.dart';
import 'package:to_do/modulos/body/body_page.dart';
import 'package:to_do/modulos/home/home_controller.dart';
import 'package:to_do/modulos/lists_tasks/lists_task_page.dart';
import 'package:to_do/modulos/notes/notes_page.dart';
import 'package:to_do/modulos/profile/profile_page.dart';
import 'package:to_do/modulos/settings/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();

  bool isChange = false;

  HomeController homeController = Get.put(HomeController());

  List<String> listQtd = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  String selected = '1';

  List<String> listCup = ['imagens/copo.png', 'imagens/garrafacomagua.png'];
  String selectedCup = 'imagens/copo.png';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    homeController.getGarrafa();
    homeController.getTaskList(Globals.user!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff178283),
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                  left: 0,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BodyPage()));
                      },
                      child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Color(0xff2C2C2C),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40.0),
                                bottomRight: Radius.circular(80.0)),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Center(
                              child: Image.asset(
                            'imagens/physical.png',
                            height: 30,
                            width: 30,
                          ))))),
              Positioned(
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProfilePage()));
                    },
                    child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Color(0xff2C2C2C),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              bottomLeft: Radius.circular(80.0)),
                        ),
                        padding: EdgeInsets.all(20),
                        child: Center(
                            child: Image.asset(
                          'imagens/profile.png',
                          height: 30,
                          width: 30,
                        ))),
                  )),
              Positioned(
                  bottom: 0,
                  height: 70,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xff2C2C2C).withOpacity(0.5),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0)),
                      ),
                      padding: EdgeInsets.only(left: 20, right: 20),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => NotesPage()));
                            },
                            child: Container(
                              child: Image.asset(
                                'imagens/notas.png',
                                height: 50,
                                width: 50,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      ListTaskPage(user: Globals.user!)));
                            },
                            child: Container(
                              child: Image.asset(
                                'imagens/listas.png',
                                height: 50,
                                width: 50,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SettingsPage()));
                            },
                            child: Container(
                              child: Image.asset(
                                'imagens/setting.png',
                                height: 50,
                                width: 50,
                              ),
                            ),
                          )
                        ],
                      ))),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              Center(
                // Center is a layout widget. It takes a single child and positions it
                // in the middle of the parent.
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Image.asset(
                        'imagens/stabilit_core_logo.png',
                      ),
                    ),
                    GetBuilder<HomeController>(
                        builder: (_) => Flexible(
                            child: isChange == false
                                ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Color(0xff2C2C2C),
                                      border: Border.all(
                                          color: Colors.white,
                                          width: 1.0,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(40.0)),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 15, right: 15),
                                          height: 100,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  homeController.garrafaVazia,
                                              itemBuilder: (context, index) {
                                                return Image.asset(
                                                  homeController
                                                              .garrafaCheia! <=
                                                          index
                                                      ? homeController.isCup
                                                          ? 'imagens/copo_vazio.png'
                                                          : 'imagens/garrafavazia.png'
                                                      : homeController.isCup
                                                          ? 'imagens/copo.png'
                                                          : 'imagens/garrafacomagua.png',
                                                  width: 60,
                                                  height: 60,
                                                );
                                              }),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                final SharedPreferences prefs =
                                                    await SharedPreferences
                                                        .getInstance();
                                                prefs.setInt(
                                                    'garrafaCheia',
                                                    homeController
                                                            .garrafaCheia! -
                                                        1);
                                                homeController.getGarrafa();
                                              },
                                              child: Image.asset(
                                                'imagens/menos.png',
                                                width: 30,
                                                height: 30,
                                              ),
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    isChange = true;
                                                  });
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.all(10),
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xff2C2C2C),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                40.0)),
                                                    border: Border.all(
                                                        color: Colors.white,
                                                        width: 1.0,
                                                        style:
                                                            BorderStyle.solid),
                                                  ),
                                                  child: Text(
                                                    'CHANGE',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                )),
                                            GestureDetector(
                                              onTap: () async {
                                                final SharedPreferences prefs =
                                                    await SharedPreferences
                                                        .getInstance();
                                                prefs.setInt(
                                                    'garrafaCheia',
                                                    homeController
                                                            .garrafaCheia! +
                                                        1);
                                                homeController.getGarrafa();
                                              },
                                              child: Image.asset(
                                                'imagens/mais.png',
                                                width: 30,
                                                height: 30,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ))
                                : Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Color(0xff2C2C2C),
                                      border: Border.all(
                                          color: Colors.white,
                                          width: 1.0,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(40.0)),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Quantity of containers:',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: 70,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: Color(0xff272526),
                                                borderRadius: BorderRadius.all(
                                                  const Radius.circular(10.0),
                                                ),
                                                border: Border.all(
                                                    color: const Color(
                                                        0xFF3E959080),
                                                    width: 1.0,
                                                    style: BorderStyle
                                                        .solid), //Border.all
                                              ),
                                              child: DropdownButton<String>(
                                                  items: listQtd.map(
                                                      (String dropDownItem) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: dropDownItem
                                                          .toString(),
                                                      child: Text(dropDownItem
                                                          .toString()),
                                                    );
                                                  }).toList(),
                                                  onChanged: (String?
                                                      novoItemSelecionado) {
                                                    setState(() {
                                                      selected =
                                                          novoItemSelecionado!;
                                                    });
                                                  },
                                                  value: selected.toString()),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Container Type:',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: 70,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: Color(0xff272526),
                                                borderRadius: BorderRadius.all(
                                                  const Radius.circular(10.0),
                                                ),
                                                border: Border.all(
                                                    color: const Color(
                                                        0xFF3E959080),
                                                    width: 1.0,
                                                    style: BorderStyle
                                                        .solid), //Border.all
                                              ),
                                              child: DropdownButton<String>(
                                                  items: listCup.map(
                                                      (String dropDownItem) {
                                                    return DropdownMenuItem<
                                                            String>(
                                                        value: dropDownItem
                                                            .toString(),
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.all(2),
                                                          child: Image.asset(
                                                            dropDownItem,
                                                            width: 30,
                                                            height: 30,
                                                          ),
                                                        ));
                                                  }).toList(),
                                                  onChanged: (String?
                                                      novoItemSelecionado) {
                                                    setState(() {
                                                      selectedCup =
                                                          novoItemSelecionado!;
                                                    });
                                                  },
                                                  value:
                                                      selectedCup.toString()),
                                            )
                                          ],
                                        ),
                                        GestureDetector(
                                            onTap: () async {
                                              final SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              prefs.setInt('garrafaVazia',
                                                  int.parse(selected));
                                              homeController.getGarrafa();
                                              prefs.setBool(
                                                  'isCup',
                                                  selectedCup !=
                                                          'imagens/copo.png'
                                                      ? false
                                                      : true);

                                              setState(() {
                                                homeController.isCup =
                                                    selectedCup !=
                                                            'imagens/copo.png'
                                                        ? false
                                                        : true;
                                                homeController.garrafaVazia =
                                                    int.parse(selected);
                                                isChange = false;
                                              });
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(20),
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Color(0xff2C2C2C),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(40.0)),
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 1.0,
                                                    style: BorderStyle.solid),
                                              ),
                                              child: Text(
                                                'ok',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )),
                                      ],
                                    )))),
                    GetBuilder<HomeController>(
                      builder: (_) => Flexible(
                          child: Container(
                        width: MediaQuery.of(context).size.width,
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
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'DAY TASKS',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 100,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: homeController.listTask!.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              homeController
                                                  .listTask![index].nome!,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                            GestureDetector(
                                              onLongPress: () {
                                                setState(() {
                                                  homeController
                                                      .listTask![index]
                                                      .status = 2;
                                                });
                                              },
                                              onTap: () {
                                                if (homeController
                                                        .listTask![index]
                                                        .status ==
                                                    2) {
                                                  homeController.taskDao.delete(
                                                      homeController
                                                          .listTask![index]
                                                          .id!);
                                                  homeController.getTaskList(
                                                      Globals.user!);
                                                } else {
                                                  setState(() {
                                                    homeController
                                                                .listTask![
                                                                    index]
                                                                .status ==
                                                            0
                                                        ? homeController
                                                            .listTask![index]
                                                            .status = 1
                                                        : homeController
                                                            .listTask![index]
                                                            .status = 0;
                                                  });
                                                  homeController.taskDao.update(
                                                      homeController
                                                          .listTask![index]);
                                                }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: homeController
                                                              .listTask![index]
                                                              .status ==
                                                          0
                                                      ? Colors.grey
                                                      : homeController
                                                                  .listTask![
                                                                      index]
                                                                  .status ==
                                                              1
                                                          ? Color(0xff178283)
                                                          : Colors.red,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    const Radius.circular(80.0),
                                                  ),
                                                ),
                                                padding: EdgeInsets.all(15),
                                                margin: EdgeInsets.all(5),
                                              ),
                                            )
                                          ],
                                        ));
                                  }),
                            )
                          ],
                        ),
                      )),
                    ),
                    SizedBox(
                      height: 70,
                    )
                  ],
                ),
              ),
            ],
          ),
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
