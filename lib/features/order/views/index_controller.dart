import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../apis/index.dart';
import '../models/index.dart';

class OrderController extends GetxController {
  var api = OrderService();
  var listOrders = <OrderModel>[];

  Future<List<OrderModel>> getAll(Map<String, dynamic> payload) async {
    try {
      var res = await api.getOrder(payload);
      if (res['code'] == 200) {
        listOrders = (res['data']['results'] as List).map(
          (item) => OrderModel.fromJson(item),
        ).toList();
        update();
      }
      return listOrders;
    } catch (e) {
      debugPrint('err <order/view/controller>: $e');
      return <OrderModel>[];
    }
  }

  void updateStatusOrder(int idOrder, int status) {
    var index = listOrders.indexWhere((e) => e.system_order_id == idOrder);
    if (status == 1) {
      listOrders[index].status_id = 2;
      listOrders[index].status_code = 'INPROGRESS';
      listOrders[index].status_name = 'Đang xử lý';
    } else {
      listOrders[index].status_id = 4;
      listOrders[index].status_code = 'FAILED';
      listOrders[index].status_name = 'Thất bại';
    }

    update();
  }
}
