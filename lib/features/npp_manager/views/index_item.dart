import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/base/base_button.dart';
import '../../../common/routes/app_routes.dart';
import '../../../components/item/row.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_spacing.dart';
import '../../../constants/app_typography.dart';

class NppCard extends StatelessWidget {
  const NppCard({required this.npp, super.key});
  final Map npp;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderColor_4),
          borderRadius: BorderRadius.circular(sp8)),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(sp16),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(sp8),
                bottom: const Radius.circular(0),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 48,
                      height: 48,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(sp8),
                        child: Image.network('https://www.w3schools.com/howto/img_avatar.png'),
                      ),
                    ),
                    SizedBox(width: sp16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(npp['fullname'], style: AppTypography.p3,),
                        SizedBox(height: sp8),
                        Text(npp['account_code'], style: AppTypography.p6.copyWith(color: AppColors.greyColor),)
                      ],
                    )
                  ],
                ),
                SizedBox(height: sp16),
                buildRowItem(title: 'Địa chỉ', content: 'Văn khê - nghĩa hương, Hà Đông, Hà Nội'),
                SizedBox(height: sp12),
                buildRowItem(title: 'Công nợ', content: '1.000.000 VNĐ'),
                SizedBox(height: sp12),
                buildRowItem(title: 'Số điện thoại', content: '0923430733'),
                SizedBox(height: sp12),
                buildRowItem(title: 'Loại nhà phân phối', content: 'Cá nhân')
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.borderColor_2),
          Container(
            padding: EdgeInsets.all(sp8),
            decoration: BoxDecoration(
                color: AppColors.bg_4,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(sp8),
                  top: const Radius.circular(0),
                )),
            child: SizedBox(
              width: double.infinity,
              child: Extrabutton(
                title: 'Xem chi tiết',
                event: () {
                  Get.toNamed(Routes.routeDetailNPP, arguments: npp);
                },
                largeButton: false,
                borderColor: AppColors.borderColor_2,
                icon: null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
