import 'package:get/get.dart';

import '../apis/index.dart';

class GroupController extends GetxController {
  var api = GroupService();
  var listGroup = [].obs;

  Future<void> getListGroup() async {
    try {
      var res = await api.getAll();
      if (res['code'] == 200) {
        listGroup.value = res['data'];
        update();
      }
    } catch (e) {
      throw Exception('err : $e');
    }
  }

  Future<bool> createGroup(Map<String, dynamic> payload) async {
    try {
      var res = await api.create(payload);
      if (res['code'] == 200) {
        listGroup.add(res);
        update();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteGroup(Map<String, dynamic> payload) async {
    try {
      var res = await api.delete(payload);
      if (res['code'] == 200) {
        listGroup.removeWhere((item) => item['id'] == payload['id']);
        update();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  get isEmtyList {
    if (listGroup.isEmpty) return true;
    return false;
  }
}