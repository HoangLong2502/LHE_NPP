import 'package:flutter/material.dart';

import '/common/base/base_button.dart';
import '/components/item/row.dart';
import '/constants/app_colors.dart';
import '/constants/app_spacing.dart';
import '/constants/app_typography.dart';
import '/features/warehouse/models/consignment.dart';

// ignore: must_be_immutable
class ConsignmentCard extends StatelessWidget {
  ConsignmentCard({required this.data, required this.select, super.key});

  ConsignmentModel data;
  Function select;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(sp16),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderColor_4),
              borderRadius: BorderRadius.vertical(top: Radius.circular(sp8))),
          child: Column(
            children: [
              buildRowItem(title: 'Nhập hàng từ', content: data.import_from),
              SizedBox(height: sp12),
              buildRowItem(title: 'Hàng có sẵn', content: '${data.quantity.toInt()} ${data.amount_type == 'BIN' ? 'thùng' : 'gói'}'),
              SizedBox(height: sp12),
              buildRowItem(
                  title: 'Nhập ngày', content: data.date_of_manufacture),
              SizedBox(height: sp12),
              buildRowItem(title: 'Hạn sử dụng', content: data.expiration_date),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(sp16),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderColor_4),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(sp8)),
              color: AppColors.bg_4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Mã lô hàng', style: AppTypography.p5),
                  SizedBox(height: sp8),
                  Text(
                    data.consignment_code,
                    style:
                        AppTypography.h5.copyWith(color: AppColors.mainColor),
                  )
                ],
              ),
              Extrabutton(
                title: 'Xuất từ lô hàng',
                event: () {
                  select(data);
                },
                largeButton: false,
                borderColor: AppColors.borderColor_4,
                icon: null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
