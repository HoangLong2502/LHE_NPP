import 'package:flutter/material.dart';

import '../../../common/util/api.dart';
import '../../../common/util/base_dio.dart';

class UserService {
  final _dio = BaseDio();

  Future<List> getAllUser(int page) async {
    try {
      var pageSize = 5;
      var res = await _dio.dio.get('${Api.user_by_admin}?page=${page - 1}&page_size=$pageSize');
      return res.data['data']['account'];
    } catch (e) {
      debugPrint('err : $e');
      return [];
    }
  }

  Future<List> getUserByKey(int page, String systemKey) async {
    try {
      var pageSize = 5;
      var res = await _dio.dio.get('${Api.user}?page=${page - 1}&page_size=$pageSize&system_key=$systemKey');
      return res.data['data']['account'];
    } catch (e) {
      throw Exception('err : $e');
    }
  }

  Future<Map> getProfile(String key) async {
    try {
      var res = await _dio.dio.get('${Api.profile_by_system}?system_key=$key');
      return res.data;
    } catch (e) {
      debugPrint('$e');
      return {};
    }
  }

  Future<Map> registerAccount(Map<String, dynamic> payload) async {
    try {
      var res = await _dio.dio.post(Api.register, data: payload);
      return {
        'isErr' : false,
        'data' : res.data
      };
    } catch (e) {
      debugPrint('$e');
      return {
        'isErr' : true,
        'message' : e
      };
    }
  }
}
