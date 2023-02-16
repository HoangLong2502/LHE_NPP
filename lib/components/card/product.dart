import 'package:flutter/material.dart';

import '../../common/base/base_container.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_typography.dart';
import '../../features/product/models/index.dart';

Widget CardProduct(BuildContext context, ProductModel item) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(sp8),
        border: Border.all(color: AppColors.borderColor_4, width: 1)),
    child: Column(
      children: [
        BaseContainer(
          context,
          Row(
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderColor_4, width: 1),
                  borderRadius: BorderRadius.circular(sp8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(sp8),
                  child: Image.network('${item.img}'),
                ),
              ),
              SizedBox(width: sp16),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  '${item.product_name}',
                  style: AppTypography.p3,
                ),
                SizedBox(height: sp8),
                Text(
                  'Mã sản phẩm: #11111111',
                  style: AppTypography.p6.copyWith(
                    color: AppColors.greyColor,
                  ),
                ),
              ]),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(sp16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(sp8),
              bottomRight: Radius.circular(sp8),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Trạng thái sản phẩm', style: AppTypography.p6,),
              Text(
                'Đang hoạt động',
                style: AppTypography.h6.copyWith(
                  color: AppColors.green_1,
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
