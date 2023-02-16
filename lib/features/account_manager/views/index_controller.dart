import 'package:get/get.dart';

class UserControlelr extends GetxController {
  var listUser = [];

  void updateListUser(value) {
    listUser = value;
    update();
  }
}