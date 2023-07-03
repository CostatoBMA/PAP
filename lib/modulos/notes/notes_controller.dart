import 'package:get/get.dart';
import 'package:to_do/db/dao/notes_dao.dart';
import 'package:to_do/model/notes.dart';
import 'package:to_do/model/user.dart';

class NotesController extends GetxController {
  NotesDao notesDao = NotesDao();
  List<Notes> listNotesPinned = [];
  List<Notes> listNotes = [];
  List<Notes> notesListSearch = [];

  List<Notes> notesDelete = [];

  getNotesPinned(User user) async {
    print('id:${user.id}');
    try {
      listNotesPinned = await notesDao.getNotes(user.id!, pinned: 1);
    } catch (e) {}
    update();
  }

  getNotesListDate(User user, String date) async {
    print('id:${user.id}');
    try {
      listNotes = await notesDao.getNotes(user.id!, date: date);
    } catch (e) {}
    update();
  }

  getNotes(User user) async {
    notesListSearch = [];

    print('id:${user.id}');
    try {
      listNotes = await notesDao.getNotes(user.id!, pinned: 0);
    } catch (e) {}
    update();
  }

  saveNotes(Notes notes) async {
    int id = await notesDao.save(notes);
  }

  updateNotes(Notes notes) async {
    print(notes.id);
    int id = await notesDao.update(notes);
    print(id);
  }

  deleteNotes(Notes notes) {
    notesDao.delete(notes.id!);
  }

  deleteNotesMultiplos() {
    for (int i = 0; i < notesDelete.length; i++) {
      notesDao.delete(notesDelete[i].id!);
    }
  }

  setSearch(String search) {
    notesListSearch = [];
    if (search.isNotEmpty) {
      for (int i = 0; i < listNotes.length; i++) {
        var item = listNotes[i];

        if (item.nome!.toLowerCase().contains(search.toLowerCase())) {
          print(search);
          print(item.nome);
          notesListSearch.add(item);
        }
        print('aasa');
        print(notesListSearch.length);
        print(notesListSearch.length);
      }
    }

    update();
  }
}
