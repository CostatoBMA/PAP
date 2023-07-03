import 'package:to_do/db/dao/user_dao.dart';
import 'package:to_do/db/globals.dart';

class ProfileController {
  UserDao userDao = UserDao();
  editarImagePerfil(String path) {
    Globals.user!.pathImage = path;
    userDao.update(Globals.user!);
  }

  editarPrimeiraData(String primeira) {

   // Globals.user!.beforeFoto = primeira;
    Globals.user!.primeiraData = primeira;
    userDao.update(Globals.user!);
  }

  editarSegundaData(String segunda) {
   // Globals.user!.afterFoto = segunda;
    Globals.user!.segundaData =segunda;

    userDao.update(Globals.user!);
  }


  editarAfterFoto(String primeira) {

    Globals.user!.afterFoto = primeira;
   // Globals.user!.primeiraData = DateTime.now().toString().split(' ')[0];
    userDao.update(Globals.user!);
  }

  editarBeforeFoto(String segunda) {
    Globals.user!.beforeFoto = segunda;
    //Globals.user!.primeiraData = DateTime.now().toString().split(' ')[0];

    userDao.update(Globals.user!);
  }
}
