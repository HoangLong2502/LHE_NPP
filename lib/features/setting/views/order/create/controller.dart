import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhe_npp/common/constants/constans.dart';
import 'package:lhe_npp/common/util/enum/status_type_order.dart';
import 'package:lhe_npp/local%20storage/app_shared_preference.dart';

import '../../../../../common/util/enum/status_noti.dart';
import '../../../../../common/util/notiStatus.dart';
import '../../../../../components/notification/index.dart';
import '../../../apis/index.dart';
import '../../../models/type.dart';

class CreateTypeOrderController extends GetxController
    with ShowNotiWhenCallApi {
  final _settingService = SettingService();

  var listType = <TypeModel>[].obs;
  var isLoading = false.obs;

  @override
  void showAffterEvent(BuildContext context, bool status) {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Card(
          child: PopNotification(
            context,
            'Đang tải dữ liệu, vui lòng đợi',
            null,
            StatusChat.LOADING,
          ),
        ),
      ),
    );
  }

  @override
  void showBeforeEvent(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Card(
          child: PopNotification(
            context,
            'Đang tải dữ liệu, vui lòng đợi',
            null,
            StatusChat.LOADING,
          ),
        ),
      ),
    );
  }

  StatusTypeUse checkTypeIsUse(List usersUse) {
    var myAccount = jsonDecode(AppSharedPreference.instance.getValue(PrefKeys.USER));
    var index = usersUse.indexWhere((e) => e == myAccount['id']);
    if (index != -1) {
      return StatusTypeUse.USE;
    }
    return StatusTypeUse.NONE;
  }
}

// Mark: - pressed button
extension IBAction on CreateTypeOrderController {
  useTypePressed(TypeModel type) {
    type.isUse = StatusTypeUse.PENDING;
    update();
    var myAccount = jsonDecode(AppSharedPreference.instance.getValue(PrefKeys.USER));
    var payload = {
      "type_code": type.type_code,
      "system_key": "NPP",
      "user_id": myAccount['id'],
    };
    usingTypeForUser(payload).then((value) {
      if (!value['isErr']) {
        type.isUse = StatusTypeUse.USE;
      } else {
        type.isUse = StatusTypeUse.NONE;
      }
      update();
    });
  }
}

// Mark: - connect service
extension HandleApi on CreateTypeOrderController {
  Future<void> getTypeList() async {
    isLoading.value = true;
    update();
    var res = await _settingService.getTypeList(null);
    if (!res['isErr']) {
      listType.value = (res['data']['data'] as List)
          .map((e) {
            e['isUse'] = checkTypeIsUse(e['user_using']);
            return TypeModel.fromJson(e);
          })
          .toList();
    }
    isLoading.value = false;
    update();
  }

  Future<Map> createTypeOrder(Map<String, dynamic> payload) async {
    try {
      var res = await _settingService.createTypeOrder(payload);
      return {'isErr': false, 'data': res};
    } catch (e) {
      debugPrint('$e');
      return {'isErr': true, 'message': e};
    }
  }

  Future<Map> usingTypeForUser(Map<String, dynamic> payload) async {
    try {
      var res = await _settingService.usingTypeForUser(payload);
      return {'isErr': false, 'data': res};
    } catch (e) {
      debugPrint('$e');
      return {'isErr': true, 'message': e};
    }
  }
}
