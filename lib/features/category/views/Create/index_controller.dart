import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateCategoryController extends GetxController {
  var category_name = TextEditingController();


  void clear() {
    category_name.text = '';
    update();
  }
}