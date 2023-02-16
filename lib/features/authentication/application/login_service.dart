import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:lhe_npp/features/warehouse/apis/index.dart';

import '../../../common/routes/app_routes.dart';
import '../../../common/services/auth_service.dart';
import '../../../local storage/app_shared_preference.dart';
import '/constants/constans.dart';
import '../../../common/util/api.dart';

class LoginService {
  final _warehouseService = WarehouseService();

  Future<void> handleLogin(String username, String password) async {
    try {
      var dio = Dio();
      dio.options.headers['content-Type'] = 'application/json';
      // dio.options.headers['authorization'] = "token ${token}";
      var res = await dio.post(Api.login, data: {
        'username' : username,
        'password' : password,
        'system_key' : Api.KEY,
      });
      if(res.statusCode == 200) {
        AppSharedPreference.instance.setValue(PrefKeys.TOKEN, res.data['data']['access_token']);
        AppSharedPreference.instance.setValue(PrefKeys.USER, json.encode(res.data['data']['user']));                  
        // var customer_id = await 
        var auth = Get.find<AuthService>();
        auth.setIsAuth(true);
        Get.offAndToNamed(Routes.routeHomeScreen);
      }
    } catch (err) {
      print('--------$err');
    }
  }
}