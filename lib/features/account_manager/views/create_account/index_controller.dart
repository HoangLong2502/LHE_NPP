import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../apis/user.dart';

class CreateUserController extends GetxController {
  var api = UserService();

  var profile = [].obs;

  Future<bool> get_profile(String key) async {
    try {
      var res = await api.getProfile(key);
      profile.value = res['data'];
      update();
      return true;
    } catch (e) {
      debugPrint('$e');
      return false;
    }
  }

  Future<bool> registerAccount(Map<String, dynamic> payload) async {
    try {
      var res = await api.registerAccount(payload);
      if (res['isErr'])
        return false;
      else
        return true;
    } catch (e) {
      debugPrint('$e');
      return false;
    }
  }
}
