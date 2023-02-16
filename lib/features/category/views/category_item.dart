import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/base/base_button.dart';
import '../../../common/base/base_container.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_size_device.dart';
import '../../../constants/app_spacing.dart';
import '../../../constants/app_typography.dart';
import '../../../constants/assets_path.dart';
import 'Create/index_view.dart';
import 'category_controller.dart';

class EmtyCategory extends StatelessWidget {
  const EmtyCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: sp24, horizontal: sp16),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(sp8),
        color: AppColors.whiteColor,
      ),
      child: Column(
        children: [
          SizedBox(
            child: SvgPicture.asset('${AssetsPath.image}/category/emty.svg'),
          ),
          SizedBox(height: sp16),
          Text(
            'Chưa có danh mục nào',
            style: AppTypography.p4,
          ),
          SizedBox(height: sp12),
          Text(
            'Tạo danh mục sản phẩm mới để hiển thị và quản lý danh mục',
            style: AppTypography.p4.copyWith(color: AppColors.greyColor),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: sp24),
          MainButton(
              title: 'Tạo danh mục mới',
              event: () {
                showDialog(
                  context: context,
                  builder: (context) => CreateCategoryPop(),
                );
              },
              largeButton: true,
              icon: Icon(Icons.add_circle_outline))
        ],
      ),
    );
  }
}

class ListCategory extends StatelessWidget {
  final CategoryController _categoryController;

  ListCategory(
    this._categoryController,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Danh sách danh mục', style: AppTypography.h4),
          SizedBox(height: sp16),
          SizedBox(
            width: double.infinity,
            child: MainButton(
              title: 'Tạo danh mục mới',
              event: () {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(child: CreateCategoryPop()),
                );
              },
              largeButton: true,
              icon: const Icon(
                Icons.add_circle_outline,
              ),
            ),
          ),
          SizedBox(height: sp16),
          SizedBox(
            width: widthDevice(context) - 32,
            height: heightDevice(context) - 400,
            child: ListView.separated(
                itemBuilder: (context, index) => BaseContainer(
                    context,
                    Row(
                      children: [
                        const Icon(
                          Icons.folder_outlined,
                          color: AppColors.greyColor,
                        ),
                        SizedBox(width: sp8),
                        Text(
                          _categoryController.listCategory[index].category_name,
                          style: AppTypography.p4,
                        )
                      ],
                    )),
                separatorBuilder: (context, index) => SizedBox(height: sp16),
                itemCount: _categoryController.listCategory.length),
          ),
          // Column(
          //   children: _categoryController.listCategory.map((e) {
          //     return Padding(
          //       padding: EdgeInsets.symmetric(vertical: sp8),
          //       child: BaseContainer(context, Row(
          //         children: [
          //           Icon(Icons.folder_outlined, color: AppColors.greyColor,),
          //           SizedBox(width: sp8),
          //           Text(e['category_name'], style: AppTypography.p4,)
          //         ],
          //       )),
          //     );
          //   }).toList(),
          // )
        ],
      ),
    );
  }
}
