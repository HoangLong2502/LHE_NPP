import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhe_npp/features/order/apis/index.dart';
import 'package:lhe_npp/features/order/models/order_product.dart';
import 'package:lhe_npp/features/warehouse/apis/index.dart';
import 'package:lhe_npp/features/warehouse/models/consignment.dart';

class CreateExportOrderController extends GetxController {
  final _warehouseService = WarehouseService();
  final _orderService = OrderService();

  var listProductOrder = [].obs;
  var listConsigmentSussgest = <ConsignmentModel>[].obs;

  converData(dataOrder) {
    listProductOrder.value = amountData(dataOrder);
    update();
  }

  updateConsignment(ConsignmentModel value, int formulaIdUpdate) {
    var index = listProductOrder.indexWhere((item) => (item['product'] as OrderProductModel).formula_id == formulaIdUpdate);
    listProductOrder[index]['amount_data']['consignment'] = [value];
    update();
  }

  List<Map> amountData(List dataOrder) {
    final amountData = dataOrder.map((item) {
      return {
        "product" : item,
        "amount_data": {
            "source_type_code": 'FORMULA',
            "consignment": [],
            "custom_id": item.formula_id,
            "amount": item.amount,
          },
      };
    }).toList();
    return amountData;
  }

  Future<Map> suggestConsigment(Map<String, dynamic> payload) async {
    try {
      var res = await _warehouseService.suggestConsigment(payload);
      listConsigmentSussgest.value = (res['data'] as List).map((e) => ConsignmentModel.fromJson(e),).toList();
      update();
      return {
        "isErr" : false,
        "data" : res['data']
      };
    } catch (e) {
      debugPrint('err : $e');
      return {
        "isErr" : true,
        "message" : '$e'
      };
    }
  }

  Future<Map> createReceiptsExport(Map<String, dynamic> payload) async {
    try {
      var res = await _orderService.createReceiptsExport(payload);
      return {
        "isErr" : false,
        "data" : res['data']
      };
    } catch (e) {
      debugPrint('err : $e');
      return {
        "isErr" : true,
        "message" : '$e'
      };
    }
  }
}