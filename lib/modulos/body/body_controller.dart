import 'package:get/get.dart';
import 'package:to_do/db/dao/body_dao.dart';
import 'package:to_do/model/body.dart';
import 'package:to_do/model/body_parties.dart';
import 'package:to_do/model/user.dart';

class BodyController extends GetxController {
  BodyDao bodyDao = BodyDao();
  Body? body = Body();

  List<BodyParties> listBodyParties = [];

  saveBody(Body body) async {
    int id = await bodyDao.save(body);
  }

  Future<Body> getBody(User user) async {
    print('id:${user.id}');
    try {
      body = await bodyDao.getBody(user);
    } catch (e) {}
    return body!;
  }

  updateTask(Body body) {
    bodyDao.update(body);
  }
}
