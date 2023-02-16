import 'package:flutter/cupertino.dart';

import '../../common/base/base_layout.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_size_device.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_typography.dart';
import '../../features/category/views/category_view.dart';
import '../../features/product/views/product_view.dart';

enum TYPE { product, category }

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  TYPE _selectPage = TYPE.product;

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      'Sản phẩm',
      Column(
        children: [
          CupertinoSlidingSegmentedControl(
            groupValue: _selectPage,
            backgroundColor: AppColors.whiteColor,
            padding: const EdgeInsets.all(8),
            thumbColor: AppColors.bg_4,
            children: {
              TYPE.product: Container(
                width: widthDevice(context) / 2,
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'Sản phẩm',
                  textAlign: TextAlign.center,
                  style: AppTypography.p5.copyWith(
                      color: _selectPage == TYPE.product
                          ? AppColors.blackColor
                          : AppColors.greyColor),
                ),
              ),
              TYPE.category: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Danh mục',
                  textAlign: TextAlign.center,
                  style: AppTypography.p5.copyWith(
                      color: _selectPage == TYPE.category
                          ? AppColors.blackColor
                          : AppColors.greyColor),
                ),
              ),
            },
            onValueChanged: (value) {
              setState(() {
                _selectPage = value!;
              });
            },
          ),
          SizedBox(height: sp16),
          _selectPage == TYPE.product ? ProductView() : CategoryView(),
        ],
      ),
    );
  }
}
