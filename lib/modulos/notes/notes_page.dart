import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_do/componentes/togain_text_field.dart';
import 'package:to_do/db/globals.dart';
import 'package:to_do/model/notes.dart';
import 'package:to_do/modulos/inside_note_page/inside_note_page.dart';
import 'package:to_do/modulos/notes/notes_controller.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({
    super.key,
  });

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  NotesController notesController = Get.put(NotesController());

  bool press = false;
  bool selected = false;
  bool calendar = false;

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notesController.getNotesPinned(Globals.user!);
    notesController.getNotes(Globals.user!);
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
              Navigator.of(context).pop();
            },
            child: Image.asset('imagens/seta_esquerda.png'),
          ),
          centerTitle: true,
          title: Text(
            'NOTES',
            style: TextStyle(
                color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
            ),
            Container(
                margin: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pinned',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      GetBuilder<NotesController>(
                        builder: (_) => GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemCount: notesController.listNotesPinned.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => InsideNotesPage(
                                            notes: notesController
                                                .listNotesPinned[index],
                                          )));
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          const Radius.circular(10.0),
                                        ),
                                      ),
                                      margin: EdgeInsets.all(10),
                                      padding: EdgeInsets.all(15),
                                      height: 150,
                                      width: 150,
                                    ),
                                    Visibility(
                                        visible: !press,
                                        child: Positioned(
                                            right: 15,
                                            top: 15,
                                            child: GestureDetector(
                                                onTap: () {
                                                  notesController
                                                      .listNotesPinned[index]
                                                      .pinned = 0;
                                                  notesController.updateNotes(
                                                      notesController
                                                              .listNotesPinned[
                                                          index]);
                                                  notesController
                                                      .getNotes(Globals.user!);
                                                  notesController
                                                      .getNotesPinned(
                                                          Globals.user!);
                                                },
                                                child: Container(
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xff178283),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        const Radius.circular(
                                                            10.0),
                                                      ),
                                                    ),
                                                    padding: EdgeInsets.all(5),
                                                    child: Image.asset(
                                                        'imagens/alfinete.png')))))
                                  ],
                                ),
                              );
                            }),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      Text(
                        'All',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      GetBuilder<NotesController>(
                        builder: (_) => notesController
                                .notesListSearch.isNotEmpty
                            ? GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                ),
                                itemCount:
                                    notesController.notesListSearch.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  InsideNotesPage(
                                                    notes: notesController
                                                        .notesListSearch[index],
                                                  )));
                                    },
                                    onLongPress: () {
                                      setState(() {
                                        notesController.notesListSearch[index]
                                            .click = true;
                                      });
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              const Radius.circular(10.0),
                                            ),
                                          ),
                                          margin: EdgeInsets.all(10),
                                          padding: EdgeInsets.all(15),
                                          height: 150,
                                          width: 150,
                                        ),
                                        notesController.notesListSearch[index]
                                                    .click ==
                                                true
                                            ? Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    const Radius.circular(10.0),
                                                  ),
                                                ),
                                                margin: EdgeInsets.all(10),
                                                height: 150,
                                                width: 150,
                                                child: cancel(
                                                    notesController
                                                        .notesListSearch[index],
                                                    index),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  );
                                })
                            : GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                ),
                                itemCount: notesController.listNotes.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  InsideNotesPage(
                                                    notes: notesController
                                                        .listNotes[index],
                                                  )));
                                    },
                                    onLongPress: () {
                                      setState(() {
                                        notesController.listNotes[index].click =
                                            true;
                                      });
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              const Radius.circular(10.0),
                                            ),
                                          ),
                                          margin: EdgeInsets.all(10),
                                          padding: EdgeInsets.all(15),
                                          height: 150,
                                          width: 150,
                                        ),
                                        notesController
                                                    .listNotes[index].click ==
                                                true
                                            ? Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    const Radius.circular(10.0),
                                                  ),
                                                ),
                                                margin: EdgeInsets.all(10),
                                                height: 150,
                                                width: 150,
                                                child: cancel(
                                                    notesController
                                                        .listNotes[index],
                                                    index),
                                              )
                                            : Container(),
                                        selected == true
                                            ? Positioned(
                                                top: 15,
                                                left: 15,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    if (notesController
                                                            .listNotes[index]
                                                            .click ==
                                                        false) {
                                                      notesController
                                                          .notesDelete
                                                          .add(notesController
                                                                  .listNotes[
                                                              index]);
                                                      setState(() {
                                                        notesController
                                                            .listNotes[index]
                                                            .click = true;
                                                      });
                                                    } else {
                                                      notesController
                                                          .notesDelete
                                                          .add(notesController
                                                                  .listNotes[
                                                              index]);
                                                      notesController
                                                          .notesDelete
                                                          .removeWhere(
                                                              (element) =>
                                                                  element
                                                                      .id ==
                                                                  notesController
                                                                      .listNotes[
                                                                          index]
                                                                      .id);
                                                      setState(() {
                                                        notesController
                                                            .listNotes[index]
                                                            .click = false;
                                                      });
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: notesController
                                                                  .listNotes[
                                                                      index]
                                                                  .click ==
                                                              true
                                                          ? Colors.red
                                                          : Color(0xff178283),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        const Radius.circular(
                                                            10.0),
                                                      ),
                                                    ),
                                                    width: 20,
                                                    height: 20,
                                                  ),
                                                ))
                                            : Container()
                                      ],
                                    ),
                                  );
                                }),
                      )
                    ],
                  ),
                )),
            Positioned(
                bottom: 20,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xff178283),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (press != true) {
                              setState(() {
                                press = true;
                              });
                            } else {
                              setState(() {
                                press = false;
                              });
                            }
                          },
                          child: Image.asset(
                            'imagens/menu.png',
                            height: 40,
                          ),
                        ),
                        ToGainTextField(
                          onChanged: notesController.setSearch,
                          size: 250,
                          label: 'search',
                        ),
                        GestureDetector(
                          onTap: () {
                            Notes notes = Notes();
                            notes.pinned = 0;
                            notes.userid = Globals.user!.id;
                            notes.date = _focusedDay.toString().split(' ')[0];
                            notesController.notesDao.save(notes);
                            notesController.getNotes(Globals.user!);
                          },
                          child: Image.asset(
                            'imagens/add.png',
                            height: 40,
                          ),
                        )
                      ],
                    ))),
            Positioned(bottom: 60, child: selecNotes()),
            calendarWidget()
          ],
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Widget calendarWidget() {
    return Visibility(
        visible: calendar,
        child: Container(
          height: 400,
          margin: EdgeInsets.only(top: 90),
          decoration: BoxDecoration(
            color: Color(0xff178283),
            borderRadius: BorderRadius.all(
              const Radius.circular(10.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              // Use `selectedDayPredicate` to determine which day is currently selected.
              // If this returns true, then `day` will be marked as selected.

              // Using `isSameDay` is recommended to disregard
              // the time-part of compared DateTime objects.
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                // Call `setState()` when updating the selected day
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                notesController.getNotesListDate(
                    Globals.user!, _focusedDay.toString().split(' ')[0]);
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                // Call `setState()` when updating calendar format
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
          ),
        ));
  }

  Widget cancel(Notes notes, index) {
    return Container(
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              notesController.deleteNotesMultiplos();
              notesController.getNotes(Globals.user!);
              notesController.getNotesPinned(Globals.user!);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  const Radius.circular(5.0),
                ),
                border: Border.all(
                    color: Colors.red,
                    width: 1.0,
                    style: BorderStyle.solid), //Border.all
              ),
              padding: EdgeInsets.all(10),
              height: 100,
              width: 45,
              child: Image.asset(
                'imagens/x.png',
                height: 20,
                width: 20,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              notes.pinned = 1;
              notesController.updateNotes(notes);
              notesController.getNotes(Globals.user!);
              notesController.getNotesPinned(Globals.user!);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff178283),
                borderRadius: BorderRadius.all(
                  const Radius.circular(10.0),
                ),
                border: Border.all(
                    color: Colors.white,
                    width: 1.0,
                    style: BorderStyle.solid), //Border.all
              ),
              padding: EdgeInsets.all(10),
              height: 100,
              width: 50,
              child: Image.asset(
                'imagens/alfinete.png',
                height: 20,
                width: 20,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget selecNotes() {
    return Visibility(
      visible: press,
      child: Container(
          width: 250,
          height: 120,
          decoration: BoxDecoration(
            color: Color(0xff178283),
            borderRadius: BorderRadius.all(
              const Radius.circular(10.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (selected == false) {
                    for (int i = 0; i < notesController.listNotes.length; i++) {
                      setState(() {
                        selected = true;
                      });
                    }
                  } else {
                    for (int i = 0; i < notesController.listNotes.length; i++) {
                      setState(() {
                        notesController.listNotes[i].click = false;
                        selected = false;
                      });
                    }
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  color: Colors.black.withOpacity(0.5),
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select Notes',
                        style: TextStyle(color: Colors.white),
                      ),
                      Image.asset(
                        'imagens/check.png',
                        height: 20,
                        width: 20,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                  onTap: () {
                    if (calendar == false) {
                      setState(() {
                        calendar = true;
                      });
                    } else {
                      setState(() {
                        calendar = false;
                      });
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    color: Colors.black.withOpacity(0.5),
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Group By Date',
                          style: TextStyle(color: Colors.white),
                        ),
                        Image.asset(
                          'imagens/calendario.png',
                          height: 20,
                          width: 20,
                        )
                      ],
                    ),
                  ))
            ],
          )),
    );
  }
}
