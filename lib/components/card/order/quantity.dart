import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lhe_npp/common/util/event.dart';
import 'package:lhe_npp/components/item/row.dart';

import '../../../common/base/base_container.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_spacing.dart';
import '../../../constants/app_typography.dart';
import '../../../features/product/models/product_create_order.dart';
import '../../quantity/index.dart';

Widget CardQuantityProduct(
  BuildContext context,
  ProductPurchaseModel product,
  Function minus,
  Function plus,
  Function fieldQuantity,
  Function delete,
) {
  return Slidable(
    key: ValueKey(product.id),
    endActionPane: ActionPane(
      motion: const ScrollMotion(),
      dismissible: DismissiblePane(onDismissed: () {delete(product.id);}),
      children: [
        SlidableAction(
          flex: 1,
          spacing: 1,
          onPressed: (context) {
            print(1);
          },
          backgroundColor: AppColors.purple_2,
          foregroundColor: AppColors.purple_1,
          icon: Icons.report,
        ),
        SlidableAction(
          flex: 1,
          spacing: 1,
          onPressed: (context) {
            delete(product.id);
          },
          borderRadius: BorderRadius.horizontal(right: Radius.circular(sp8)),
          backgroundColor: AppColors.red_2,
          foregroundColor: AppColors.red_1,
          icon: Icons.delete_outline,
        ),
      ],
    ),
    child: BaseContainer(
      context,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: SizedBox(
                width: 48,
                height: 48,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(sp8),
                  child: Image.network(product.image),
                ),
              ),
              title: Text(product.title, style: AppTypography.p3),
              subtitle: Text(
                'SKU: ${product.SKU}',
                style: AppTypography.p6.copyWith(color: AppColors.greyColor),
              ),
            ),
          ),
          SizedBox(height: sp16),
          buildRowItem(title: 'Đơn giá', content: '${FormatCurrency(product.price)} VNĐ'),
          SizedBox(height: sp16),
          buildRowItem(title: 'Tổng giá', content: '${FormatCurrency(product.price * product.quantity)} VNĐ'),
          SizedBox(height: sp16),
          Container(
            padding: EdgeInsets.all(sp4).copyWith(left: sp16),
            decoration: BoxDecoration(
                color: AppColors.borderColor_1,
                borderRadius: BorderRadius.circular(sp8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Số lượng',
                    style: AppTypography.p4),
                ChangeQuantity(minus, plus, fieldQuantity, product.quantity, product.id)
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
