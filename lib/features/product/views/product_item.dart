import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/base/base_button.dart';
import '../../../common/base/base_input.dart';
import '../../../common/routes/app_routes.dart';
import '../../../components/filter/filter_button.dart';
import '../../../constants/app_spacing.dart';
import 'product_controller.dart';

Widget ProductPage1(
  BuildContext context,
  ProductController _productController,
  List<Map<String, dynamic>> listFilter,
  String selectFilter,
  Function handleSelectFilter
) {
  return Column(
    children: [
      Container(
        width: double.infinity,
        child: MainButton(
          title: 'Thêm mới sản phẩm',
          event: () {
            Get.toNamed(Routes.routeProductCreate);
          },
          largeButton: true,
          icon: const Icon(
            Icons.add_circle_outline,
          ),
        ),
      ),
      AppInput(
        label: '',
        hintText: 'Tìm kiếm sản phẩm',
        controller: _productController.search,
        context: context,
        show: true,
        isPassword: false,
        textInputType: TextInputType.none,
        suffixIcon: Icon(Icons.search),
        validate: () {},
      ),
      SizedBox(height: sp16),
      FilterButton(listFilter, selectFilter, handleSelectFilter)
    ],
  );
}
