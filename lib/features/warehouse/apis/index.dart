import 'package:flutter/material.dart';
import 'package:lhe_npp/common/util/base_dio.dart';

import '../../../common/util/api.dart';

class WarehouseService {
  final _dio = BaseDio();

  Future<List> getWarehouse(Map<String, dynamic> payload) async {
    try {
      var res = await _dio.dio().get('${Api.warehouse}/warehouse/api/warehouses?page=0&page_size=${payload['page_size']}0&account_id=${payload['account_id']}&system_key=${payload['system_key']}');
      return res.data['data']['results'];
    } catch (e) {
      debugPrint('$e');
      return [];
    }
  }
  
  // Suggest Consignment
  Future<Map> suggestConsigment(Map<String, dynamic> payload) async {
    try {
      var res = await _dio.dio().post('${Api.warehouse}/consignment/api/suggest_consignment', data: payload);
      return res.data;
    } catch (e) {
      debugPrint('$e');
      return {};
    }
  }
}