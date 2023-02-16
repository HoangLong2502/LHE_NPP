import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../apis/index.dart';
import '../../models/index.dart';
import '../../models/order_product.dart';

class OrderDetailController extends GetxController {
  var api = OrderService();
  var order;
  var orderProduct = [].obs;

  Future<bool> getDetailOrder(Map<String, dynamic> payload) async {
    try {
      var orderDetail = await api.getDetailOrder(payload);
      if (orderDetail['code'] == 200) {
        order = OrderModel.fromJson(orderDetail['data']);
      }
      orderProduct.value = (orderDetail['data']['product_item'] as List).map((item) => OrderProductModel.fromJson(item)).toList();
      return true;
    } catch (e) {
      debugPrint('err : $e');
      return false;
    }
  }

  void updateAmountProduct(int id, int amount) {
    var index = orderProduct.indexWhere((item) => item.id == id);
    orderProduct[index].amount = amount;
    update();
  }

  void deleteProduct(int id) {
    orderProduct.removeWhere((item) => item.id == id);
    update();
  }

  get totalPrice {
    var price = orderProduct.fold(0, (total, item) {
      return total += int.parse(item.amount.toString()) * (item.formula_price as double).toInt();
    });
    return price;
  }

  Future<bool> confirmOrder(Map<String, dynamic> payload, String status) async {
    try {
      var res = await api.confirmOrder(payload);
      if (res['code'] == 200) {
        if (status == '1') {
          order.status_id = 2;
          order.status_code = 'INPROGRESS';
          order.status_name = 'Đang xử lý';
        } else {
          order.status_id = 4;
          order.status_code = 'FAILED';
          order.status_name = 'Thất bại';
        }
        update();
      }
      return true;
    } catch (e) {
      debugPrint('err : $e');
      return false;
    }

  }
}
