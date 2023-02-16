import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../features/product/views/Create/index_view.dart';

class CreateProductScreen extends StatelessWidget {
  CreateProductScreen({super.key});

  final _createProduct = Get.put(CreateProductView());

  @override
  Widget build(BuildContext context) {
    return CreateProductView();
  }
}
