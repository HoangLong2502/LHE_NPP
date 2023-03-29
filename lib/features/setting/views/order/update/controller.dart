import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhe_npp/common/constants/constans.dart';
import 'package:lhe_npp/common/util/api.dart';
import 'package:lhe_npp/features/setting/models/room.dart';
import 'package:lhe_npp/features/setting/models/typeDetail.dart';
import 'package:lhe_npp/features/setting/models/typeRuleRoom.dart';
import 'package:lhe_npp/local%20storage/app_shared_preference.dart';

import '../../../../../common/util/enum/status_noti.dart';
import '../../../../../common/util/notiStatus.dart';
import '../../../../../components/notification/index.dart';
import '../../../apis/index.dart';

class UpdateTypeOrderController extends GetxController with ShowNotiWhenCallApi {
  final _settingService = SettingService();

  var typeId = 0.obs;
  late TypeDetailModel typeDetail;
  var listStep = <TypeRuleRoomModel>[].obs;
  var isLoading = false.obs;
  
  @override
  void showAffterEvent(BuildContext context, bool status) {
    showDialog(
      context: context,
      builder: (context) => PopNotification(
        context,
        status ? 'Cập nhật thông tin luồng thành công!' : 'Cập nhật luồng thất bại!',
        null,
        status ? StatusChat.SUCCESS : StatusChat.ERROR,
      ),
    );
  }
  
  @override
  void showBeforeEvent(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => PopNotification(
        context,
        'Đang tải dữ liệu, vui lòng đợi',
        null,
        StatusChat.LOADING,
      ),
    );
  }
}

// Mark: - pressed button
extension IBAction on UpdateTypeOrderController {

  void selectRoom(value,TypeRuleRoomModel item) {
    item.type_rules_room = value;
    // không sử dụng update vì không cần cập nhật lại giao diện
    // update();
  }

  void updateTypeId(int id) {
    typeId.value = id;
    update();
  }
}

// Mark: - connect service
extension HandleApi on UpdateTypeOrderController {

  Future<Map> typeDetailForUser() async {
    isLoading.value = true;
    update();
    var myAccount = jsonDecode(AppSharedPreference.instance.getValue(PrefKeys.USER));
    var payload = {
      'type_id' : typeId.value,
      'user_id' : myAccount['id']
    };
    try {
      var res = await _settingService.typeDetailForUser(payload);
      typeDetail = TypeDetailModel.fromJson(res['data']);
      listStep.value = typeDetail.type_rules_room;

      listStep.forEach((e) {
        e.type_rules_room = findItemSelect(e);
      });

      // create list select
      await createListSelect();
      isLoading.value = false;
      update();
      return {'isErr': false, 'data': res};
    } catch (e) {
      debugPrint('$e');
      isLoading.value = false;
      update();
      return {'isErr': true, 'message': e};
    }
  }

  Future<Map> createTypeOrder(Map<String, dynamic> payload) async {
    try {
      var res = await _settingService.createTypeOrder(payload);
      if (res['code'] == 200) {
        return {'isErr': false, 'data': res};
      }
      return {'isErr': true, 'message': res['message']};
    } catch (e) {
      debugPrint('$e');
      return {'isErr': true, 'message': e};
    }
  }

  Future<Map> getRoomBySystem(String system) async {
    try {
      var res = await _settingService.getRoomBySystem(system);
      return {'isErr': false, 'data': res};
    } catch (e) {
      debugPrint('$e');
      return {'isErr': true, 'message': e};
    }
  }

  Future<Map> accountsRoomList() async {
    try {
      var myAccount = jsonDecode(AppSharedPreference.instance.getValue(PrefKeys.USER));
      var res = await _settingService.accountsRoomList(myAccount['id']);
      return {'isErr': false, 'data': res};
    } catch (e) {
      debugPrint('$e');
      return {'isErr': true, 'message': e};
    }
  }
}

// Mark - function
extension Event on UpdateTypeOrderController {
  // find item init in select
  Map<String, dynamic>? findItemSelect(TypeRuleRoomModel item) {
    if (item.type_rules_room == null) {
      return null;
    } else if (item.type_rules_room!['category_name'] == null) {
      var typeSelect = item.listSelect!.firstWhere((e) => e.id == item.type_rules_room?['id']);
      return typeSelect.toJsonSelectItem();
    } else {
      return item.type_rules_room;
    }
  }

  // create list data select by step system_key
  Future<void> createListSelect() async {
    for (var item in listStep) {
      if (item.system_key != Api.KEY) {
        var res = await getRoomBySystem(item.system_key);
        if (res['isErr'] == false) {
          item.listSelect = (res['data']['data'] as List).map((e) => RoomModel.fromJson(e)).toList();
          update();
        }
      } else {
        var res = await accountsRoomList();
        item.listSelect = [RoomModel.fromJson(res['data']['data'][0])];
      }
    }
  }
}
