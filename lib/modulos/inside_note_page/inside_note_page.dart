import 'package:flutter/material.dart';
import 'package:to_do/componentes/togain_text_field.dart';
import 'package:to_do/model/notes.dart';
import 'package:to_do/modulos/inside_note_page/inside_note_controller.dart';

class InsideNotesPage extends StatefulWidget {
  Notes? notes;
  InsideNotesPage({super.key, this.notes});

  @override
  State<InsideNotesPage> createState() => _InsideNotesPageState();
}

class _InsideNotesPageState extends State<InsideNotesPage> {
  TextEditingController controllerNotes = TextEditingController();
  InsideNotesController insideNotesController = InsideNotesController();
  TextEditingController check = TextEditingController();
  bool ckeckValue = false;

  List<TextEditingController> checkListEditing = [];
  List<bool> checkListValue = [];

  bool visible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.notes!.nome != null) {
      controllerNotes.text = widget.notes!.nome!;
    }
    if (widget.notes!.checkList != null) {
      insideNotesController.checkList = widget.notes!.checkList!.split(',');
      for (int i = 0; i < insideNotesController.checkList.length - 1; i++) {
        List<String> valorDividido =
            insideNotesController.checkList[i].split('|');
        TextEditingController controller = TextEditingController();
        controller.text = valorDividido[1];
        checkListEditing.add(controller);
        checkListValue.add(valorDividido[0].contains('true') ? true : false);
      }
    }

    checkListEditing.add(check);
    checkListValue.add(ckeckValue);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            backgroundColor: Color(0xff1E1E1E),
            body: SafeArea(
              child: Stack(
                children: [
                  Column(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 150),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          controller: controllerNotes,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          onChanged: insideNotesController.setNotes,
                        ),
                      ),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: insideNotesController.checkList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: Row(
                                children: [
                                  Checkbox(
                                    checkColor: Colors.white,
                                    value: checkListValue[index],
                                    onChanged: (value) {
                                      setState(() {
                                        checkListValue[index] = value!;
                                        insideNotesController.checkList[index] =
                                            '$value|${checkListEditing[index].text}';
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: TextField(
                                        controller: checkListEditing[index],
                                        style: TextStyle(color: Colors.white),
                                        onSubmitted: (value) {
                                          setState(() {
                                            insideNotesController
                                                    .checkList[index] =
                                                '${checkListValue[index]}|${checkListEditing[index].text}';
                                            insideNotesController.checkList
                                                .add('');
                                            checkListEditing
                                                .add(TextEditingController());
                                            checkListValue.add(false);
                                          });
                                        }),
                                  )
                                ],
                              ),
                            );
                          }),
                    ],
                  ),
                  Positioned(
                      top: 0,
                      right: 5,
                      child: Container(
                          width: 70,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xff178283),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0)),
                          ),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (visible == false) {
                                    setState(() {
                                      visible = true;
                                    });
                                  } else {
                                    setState(() {
                                      visible = false;
                                    });
                                  }
                                },
                                child: Text(
                                  '____',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Visibility(
                                  visible: visible,
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xff2C2C2C),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(80.0)),
                                        ),
                                        padding: EdgeInsets.all(10),
                                        height: 40,
                                        width: 40,
                                        child: Image.asset(
                                          'imagens/camera.png',
                                          width: 10,
                                          height: 10,
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xff2C2C2C),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(80.0)),
                                        ),
                                        padding: EdgeInsets.all(10),
                                        height: 40,
                                        width: 40,
                                        child: Image.asset(
                                          'imagens/lupa.png',
                                          width: 10,
                                          height: 10,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            insideNotesController.checkList
                                                .add('');
                                            checkListEditing
                                                .add(TextEditingController());
                                            checkListValue.add(false);
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xff2C2C2C),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(80.0)),
                                          ),
                                          padding: EdgeInsets.all(10),
                                          height: 40,
                                          width: 40,
                                          child: Image.asset(
                                            'imagens/check.png',
                                            width: 10,
                                            height: 10,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xff2C2C2C),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(80.0)),
                                        ),
                                        padding: EdgeInsets.all(10),
                                        height: 40,
                                        width: 40,
                                        child: Image.asset(
                                          'imagens/edit.png',
                                          width: 10,
                                          height: 10,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xffFF0000),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(80.0)),
                                          ),
                                          padding: EdgeInsets.all(10),
                                          height: 40,
                                          width: 40,
                                          child: Image.asset(
                                            'imagens/exit.png',
                                            width: 10,
                                            height: 10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ))),
                ],
              ),
            )
            // This trailing comma makes auto-formatting nicer for build methods.
            ),
        onWillPop: () async {
          for (int i = 0; i < insideNotesController.checkList.length; i++) {
            print(insideNotesController.checkList[i]);
          }

          insideNotesController.updateNotes(widget.notes!);

          return true;
        });
  }
}
