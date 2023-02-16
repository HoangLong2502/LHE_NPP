import 'package:flutter/widgets.dart';
import '../../../common/util/api.dart';
import '../../../common/util/base_dio.dart';

class OrderService {
  final _dio = BaseDio();

  Future<Map> getOrder(Map<String, dynamic> payload) async {
    try {
      var res = await _dio.dio.post('${Api.order}/all_order', data: payload);
      return res.data;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map> getDetailOrder(Map<String, dynamic> payload) async {
    try {
      var res = await _dio.dio.post(Api.order_detail,data: payload);
      return res.data;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map> confirmOrder(Map<String, dynamic> payload) async {
    try {
      var res = await _dio.dio.post(Api.order_confirm, data: payload);
      return res.data;
    } catch (e) {
      debugPrint('err : $e');
      return {};
    }
  }

  Future<Map> getProductNPP(Map<String, dynamic> payload) async {
    try {
      var res = await _dio.dio.post('${Api.product}/all_product_formula', data: payload);
      return res.data;
    } catch (e) {
      debugPrint('service err (getProductNPP) : $e');
      return {};
    }
  }

  Future<Map> createOrder(Map<String, dynamic> payload) async {
    try {
      var res = await _dio.dio.post('${Api.order}/create_order', data: payload);
      return res.data;
    } catch (e) {
      debugPrint('$e');
      return {};
    }
  }

  Future<Map> createReceiptsExport(Map<String, dynamic> payload) async {
    try {
      var res = await _dio.dio.post('${Api.warehouse}/receipt/api/create_receipts_export', data: payload);
      return res.data;
    } catch (e) {
      debugPrint('$e');
      return {};
    }
  }
}