import 'package:get/get.dart';
import 'package:to_do/db/dao/notes_dao.dart';
import 'package:to_do/model/notes.dart';
import 'package:to_do/model/user.dart';

class InsideNotesController extends GetxController {
  NotesDao notesDao = NotesDao();
  List<Notes> listNotesPinned = [];
  List<Notes> listNotes = [];
  List<String> checkList = [];
  String? notesString;

  updateNotes(Notes notes) {
    print('check');
    if (notesString != null) {
      notes.nome = notesString!;
    }

    notes.checkList = checkList.toString();

    print(checkList.toString());
    notesDao.update(notes);
  }

  setNotes(String notes) {
    this.notesString = notes;
  }
}
