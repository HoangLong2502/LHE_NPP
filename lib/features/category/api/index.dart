import 'dart:convert';

import '../../../common/util/api.dart';
import '../../../common/util/base_dio.dart';
import '../../../constants/constans.dart';
import '../../../local storage/app_shared_preference.dart';

class CategoryService {
  final _dio = BaseDio();

  Future<List> getAllCategory() async {
    try {
      var user = json.decode(AppSharedPreference.instance.getValue(PrefKeys.USER));
      var res = await _dio.dio.post(Api.category, data: {
        "user_created": user['id'],
        "system_key": Api.KEY
      });

      return res.data['data'];
    } catch (e) {
      return [];
    }
  }

  Future<void> createCategory(String category_name) async {
    try {
      var user = json.decode(AppSharedPreference.instance.getValue(PrefKeys.USER));
      var res = await _dio.dio.post(Api.category_create, data: {
        "category_name": category_name,
        "user_id": user['id'],
        "system_key": Api.KEY
      });

      print(res.data);
    } catch (e) {
      throw Exception('err : $e');
    }
  }
}