import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_size_device.dart';
import '../../../constants/app_spacing.dart';
import '../../../constants/app_typography.dart';
import '../../../features/order/views/create_import/controller.dart';
import '../../../features/product/models/product_create_order.dart';

Widget CardSerlectProduct(
  BuildContext context,
  ProductPurchaseModel product,
  PurchaseOrderController controller,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: sp16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(sp8),
      border: Border.all(color: AppColors.borderColor_4),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 14,
          height: 14,
          child: Checkbox(
            value: controller.checkProduct(product.id),
            onChanged: (_) {
              controller.updateProduct(product);
            },
          ),
        ),
        SizedBox(width: sp16),
        SizedBox(
          width: widthDevice(context) - 136,
          child: ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading: SizedBox(
              width: sp48,
              height: sp48,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(sp8),
                child: Image.network(product.image),
              ),
            ),
            title: Text(product.title, style: AppTypography.p3),
            subtitle: Text('Đặt hàng: 10 thùng', style: AppTypography.p6),
          ),
        )
      ],
    ),
  );
}
