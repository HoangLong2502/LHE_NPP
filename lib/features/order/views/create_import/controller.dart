import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../product/models/product_create_order.dart';
import '../../apis/index.dart';

class PurchaseOrderController extends GetxController {
  final api = OrderService();

  var order_item = [].obs;
  var productAvailable = <ProductPurchaseModel>[].obs;
  var productOrder = <ProductPurchaseModel>[].obs;

  // Handle change quantity product
  changeQuantity(String typeChangeQuantity, int id) {
    int index = productAvailable.indexWhere((item) => item.id == id);

    typeChangeQuantity == 'minus'
        ? productAvailable[index].quantity != 0
            ? productAvailable[index].quantity -= 1
            : null
        : productAvailable[index].quantity += 1;

    update();
  }

  //Field quantity
  fieldQuantity(String value, int id) {
    int index = productAvailable.indexWhere((item) => item.id == id);
    productAvailable[index].quantity = int.parse(value);
  }

  // Check product is select from NPP
  bool checkProduct(int id) {
    var index = productAvailable.indexWhere((e) => e.id == id);
    return index != -1;
  }

  // handle checkbox select product from NPP
  updateProduct(ProductPurchaseModel product) {
    if (checkProduct(product.id))
      deleteProduct(product.id);
    else {
      var index = productOrder.indexWhere((e) => e.id == product.id);
      productAvailable.add(([...productOrder].toList())[index]);
    }

    update();
  }

  // submit select product

  // Delete Product select from NPP in controller
  cleanProduct() {
    productAvailable.value = [];
    update();
  }

  deleteProduct(int id) {
    productAvailable.removeWhere((e) => e.id == id);
    update();
  }

  // Total price all product from NPP
  int totalPrice() {
    var total = productAvailable.fold(0, (total, element) {
      return total += (element.price * element.quantity);
    });

    return total;
  }

  //  Handle get Product NPP
  Future<bool> getProductNPP(Map<String, dynamic> payload) async {
    try {
      var res = await api.getProductNPP(payload);
      productOrder.value = (res['data']['results'] as List)
          .map((e) => ProductPurchaseModel.fromJson(e))
          .toList();
      update();
      return true;
    } catch (e) {
      debugPrint('$e');
      return true;
    }
  }

  // Handle create Order
  Future<bool> createOrder(Map<String, dynamic> payload) async {
    try {
      var res = await api.createOrder(payload);
      if (res['code'] == 400) {
        print(res);
        return false;
      } else {
        return true;
      }
    } catch (e) {
      debugPrint('$e');
      return false;
    }
  }
}