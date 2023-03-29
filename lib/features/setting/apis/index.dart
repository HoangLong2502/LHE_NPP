import 'package:flutter/material.dart';

import '../../../common/util/api.dart';
import '../../../common/util/base_dio.dart';

class SettingService {
  final _dio = BaseDio();

  Future<Map> getTypeList(int? userId) async {
    try {
      var res = await _dio.dio().get('${Api.type}/type_list?user_id=${userId ?? ''}');
      return {
        'isErr' : false,
        'data' : res.data,
      };
    } catch (e) {
      debugPrint('err/SettingService/getTypeList : $e');
      return {
        'isErr' : true,
        'message' : e,
      };
    }
  }

  Future<Map> getAllSystem() async {
    var res = await _dio.dio().get('${Api.all_system}/get_all');
    return res.data;
  }

  Future<Map> createTypeOrder(Map<String, dynamic> payload) async {
    var res = await _dio.dio().post('${Api.type}/insert_or_update_type', data: payload);
    return res.data;
  }

  Future<Map> usingTypeForUser(Map<String, dynamic> payload) async {
    var res = await _dio.dio().post('${Api.type}/using_type_for_user', data: payload);
    return res.data;
  }

  Future<Map> typeDetailForUser(Map<String, dynamic> payload) async {
    var res = await _dio.dio().get('${Api.type}/type_detail_for_user?type_id=${payload['type_id']}&user_id=${payload['user_id']}');
    return res.data;
  }

  Future<Map> getRoomBySystem(String system_key) async {
    var res = await _dio.dio().get('${Api.room}/get_room_by_system?system_key=$system_key');
    return res.data;
  }

  Future<Map> accountsRoomList(int account_id) async {
    var res = await _dio.dio().get('${Api.room}/accounts_room_list?account_id=$account_id');
    return res.data;
  }

  Future<Map> insertOrUpdateType(Map<String, dynamic> payload) async {
    var res = await _dio.dio().post('${Api.type}/insert_or_update_type', data: payload);
    return res.data;
  }
}