import 'dart:convert';

import 'package:get/get.dart';
import 'package:lhe_npp/common/constants/constans.dart';
import 'package:lhe_npp/local%20storage/app_shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/features/setting/models/type.dart';

import '../../apis/index.dart';

class SettingOrderController extends GetxController {

  final _settingService = SettingService();

  var listType = <TypeModel>[].obs;

  Future<void> getTypeList() async {
    var myAccount = jsonDecode(AppSharedPreference.instance.getValue(PrefKeys.USER));
    var res = await _settingService.getTypeList(myAccount['id']);
    if (!res['isErr']) {
      listType.value = (res['data']['data'] as List).map((e) => TypeModel.fromJson(e)).toList();
    }
  }
}