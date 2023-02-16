import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../account_manager/apis/user.dart';

class NppController extends GetxController {
  var api = UserService();
  var listNpp = [].obs;

  Future<bool> getAllNpp (int page, String systemKey) async {
    try {
      var res = await api.getUserByKey(page, systemKey);
      listNpp.value = res;
      update();
      return true;
    } catch (e) {
      debugPrint('err : $e');
      return false;
    }
  }
}