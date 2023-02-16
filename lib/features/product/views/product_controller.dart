import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/index.dart';

class ProductController extends GetxController {
  var search = TextEditingController();

  var listProduct = [].obs;

  updateListProduct(List<ProductModel> value) {
    listProduct = value.obs;
    update();
  }
}