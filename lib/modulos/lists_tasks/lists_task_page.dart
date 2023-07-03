import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_do/componentes/togain_text_field.dart';
import 'package:to_do/componentes/utils.dart';
import 'package:to_do/model/task.dart';
import 'package:to_do/model/user.dart';
import 'package:to_do/modulos/lists_tasks/list_task_controller.dart';

class ListTaskPage extends StatefulWidget {
  User user;
  ListTaskPage({super.key, required this.user});

  @override
  State<ListTaskPage> createState() => _ListTaskPageState();
}

class _ListTaskPageState extends State<ListTaskPage> {
  bool add = false;
  bool edit = false;
  TextEditingController controllerTask = TextEditingController();

  ListTaskController listTaskController = Get.put(ListTaskController());
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listTaskController.getTaskList(
        widget.user, _focusedDay.toString().split(' ')[0]);
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
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (add != false) {
              Task task = Task();
              task.nome = controllerTask.text;
              task.userid = widget.user.id;
              task.status = 0;
              task.date = _focusedDay.toString().split(' ')[0];
              listTaskController.saveTask(task);
              listTaskController.getTaskList(
                  widget.user, _focusedDay.toString().split(' ')[0]);
              setState(() {
                add = false;
              });
            } else {
              setState(() {
                add = true;
              });
            }
          },
          backgroundColor: Color(0xff178283),
          child: Icon(
            Icons.add_circle_outline_sharp,
            size: 50,
          ),
        ),
        body: Container(
            margin: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
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
                          listTaskController.getTaskList(widget.user,
                              _focusedDay.toString().split(' ')[0]);
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
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'TASK:',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (edit == false) {
                            setState(() {
                              edit = true;
                            });
                          } else {
                            for (int i = 0;
                                i < listTaskController.listTask!.length;
                                i++) {
                              listTaskController.listTask![i].nome =
                                  listTaskController
                                      .listTextController![i].text;
                              listTaskController
                                  .updateTask(listTaskController.listTask![i]);
                            }
                            listTaskController.getTaskList(widget.user,
                                _focusedDay.toString().split(' ')[0]);

                            setState(() {
                              edit = false;
                            });
                          }
                        },
                        child: Image.asset(
                          'imagens/edit.png',
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ],
                  ),
                  add != false
                      ? Container(
                          decoration: BoxDecoration(
                            color: Color(0xff272526),
                            borderRadius: BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                            border: Border.all(
                                color: const Color(0xFF3E959080),
                                width: 1.0,
                                style: BorderStyle.solid), //Border.all
                          ),
                          margin: EdgeInsets.only(top: 20),
                          padding: EdgeInsets.all(5),
                          height: 70,
                          child: ToGainTextField(
                            onSubmited: (value) {
                              Task task = Task();
                              task.nome = controllerTask.text;
                              task.userid = widget.user.id;
                              task.status = 0;
                              task.date = _focusedDay.toString().split(' ')[0];
                              listTaskController.saveTask(task);
                              listTaskController.getTaskList(widget.user,
                                  _focusedDay.toString().split(' ')[0]);
                              setState(() {
                                add = false;
                              });
                            },
                            size: 300,
                            color: Color(0xff272526),
                            textColor: Colors.white,
                            label: 'task',
                            controller: controllerTask,
                          ),
                        )
                      : Container(),
                  GetBuilder<ListTaskController>(
                    builder: (_) => listTaskController.listTask!.length > 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: listTaskController.listTask!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onLongPress: () {
                                  setState(() {
                                    listTaskController.listTask![index].status =
                                        2;
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xff272526),
                                      borderRadius: BorderRadius.all(
                                        const Radius.circular(10.0),
                                      ),
                                      border: Border.all(
                                          color: const Color(0xFF3E959080),
                                          width: 1.0,
                                          style:
                                              BorderStyle.solid), //Border.all
                                    ),
                                    margin: EdgeInsets.only(top: 20),
                                    padding: EdgeInsets.all(15),
                                    height: 70,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        edit == true
                                            ? SizedBox(
                                                width: 200,
                                                child: TextField(
                                                  controller: listTaskController
                                                          .listTextController![
                                                      index],
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )
                                            : Text(
                                                listTaskController
                                                    .listTask![index].nome!,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 30),
                                              ),
                                        GestureDetector(
                                          onTap: () {
                                            if (listTaskController
                                                    .listTask![index].status ==
                                                2) {
                                              listTaskController.taskDao.delete(
                                                  listTaskController
                                                      .listTask![index].id!);
                                              listTaskController.getTaskList(
                                                  widget.user,
                                                  _focusedDay
                                                      .toString()
                                                      .split(' ')[0]);
                                            } else {
                                              setState(() {
                                                listTaskController
                                                            .listTask![index]
                                                            .status ==
                                                        0
                                                    ? listTaskController
                                                        .listTask![index]
                                                        .status = 1
                                                    : listTaskController
                                                        .listTask![index]
                                                        .status = 0;
                                              });
                                              listTaskController.taskDao.update(
                                                  listTaskController
                                                      .listTask![index]);
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: listTaskController
                                                          .listTask![index]
                                                          .status ==
                                                      0
                                                  ? Colors.grey
                                                  : listTaskController
                                                              .listTask![index]
                                                              .status ==
                                                          1
                                                      ? Color(0xff178283)
                                                      : Colors.red,
                                              borderRadius: BorderRadius.all(
                                                const Radius.circular(80.0),
                                              ),
                                            ),
                                            padding: EdgeInsets.all(15),
                                            margin: EdgeInsets.all(5),
                                          ),
                                        )
                                      ],
                                    )),
                              );
                            })
                        : Container(),
                  ),
                ],
              ),
            ))
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
