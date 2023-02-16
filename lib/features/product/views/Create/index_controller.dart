import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../category/api/index.dart';

class CreateProductController extends GetxController {
  var categoryService = CategoryService();
  var product_name = TextEditingController();
  var product_description = TextEditingController();

  var formula = [].obs;
  var category_id;
  var categories = <Map<String, dynamic>>[].obs;

  void clear() {
    product_name.text = '';
    product_description.text = '';
    update();
  }

  // void setProduct_description(String value) {
  //   product_description = value as RxString;
  // }

  void setFormula(value) {
    formula = value;
  }
  void setCategory_id(int value) {
    category_id = value as RxInt;
  }

  Future<void> getCategory() async {
    try {
      var res = await categoryService.getAllCategory();
      categories.value = res.map((e) => {
            "id": e['id'],
            "category_name": e['category_name'],
            "category_code": null
        },).toList();
      // categories.value = await (categoryService.getAllCategory() as List<Map<String, dynamic>>);
      update();
    } catch (e) {
      debugPrint('err: $e');
    }
  }
  
  // var product = CreateProductModel(
  //   account_id: account_id,
  //   category_id: category_id,
  //   formula: formula,
  //   product_description: product_description,
  //   product_image: product_image,
  //   product_name: product_name,
  //   system_key: system_key,
  //   user_id: user_id,
  // ).obs;
}
