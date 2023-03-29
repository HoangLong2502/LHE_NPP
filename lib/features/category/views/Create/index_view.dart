import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/base/base_button.dart';
import '../../../../common/base/base_input.dart';
import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/app_size_device.dart';
import '../../../../common/constants/app_spacing.dart';
import '../../../../common/constants/app_typography.dart';
import '../../api/index.dart';
import '../category_controller.dart';
import 'index_controller.dart';

class CreateCategoryPop extends StatelessWidget {
  final _createCategoryController = Get.put(CreateCategoryController());
  final _createCategoryService = Get.put(CategoryService());
  final _categoryController = Get.put(CategoryController());
  final _categoryService = Get.put(CategoryService());

  void create() {
    _createCategoryService.createCategory(
      _createCategoryController.category_name.text
    ).then((value) {
      _createCategoryController.clear();
       _categoryService.getAllCategory().then((value) {
        _categoryController.updateListCategory(value);
      });
      Get.back();
      // showDialog(context: context, builder: builder)
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sp16, vertical: sp24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(sp8),
      ),
      width: widthDevice(context) - 32,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tạo danh mục mới', style: AppTypography.h5),
          SizedBox(height: sp16),
          AppInput(
            label: 'Đặt tên danh mục',
            hintText: 'Điền tên thư mục mới',
            controller: _createCategoryController.category_name,
            context: context,
            show: true,
            isPassword: false,
            textInputType: TextInputType.name,
            suffixIcon: null,
            validate: () {},
          ),
          SizedBox(height: sp24),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Extrabutton(
                  title: 'Huỷ bỏ',
                  event: () {
                    _createCategoryController.clear();
                    Get.back();
                  },
                  largeButton: true,
                  borderColor: AppColors.borderColor_4,
                  icon: null,
                ),
              ),
              SizedBox(width: sp16),
              Expanded(
                flex: 1,
                child: MainButton(
                  title: 'Xác nhận',
                  event: () {
                    create();
                  },
                  largeButton: true,
                  icon: null,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
