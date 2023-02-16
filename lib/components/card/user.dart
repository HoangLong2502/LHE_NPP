import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_typography.dart';

Widget UserItem(e) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: sp8, horizontal: sp16),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(sp8), color: AppColors.whiteColor),
    width: double.infinity,
    child: Row(children: [
      Row(
        children: [
          const CircleAvatar(
            radius: 21,
            backgroundImage: NetworkImage(
              'https://cdn-icons-png.flaticon.com/512/149/149071.png',
            ),
          ),
          SizedBox(width: sp16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                e['fullname'],
                style: AppTypography.p5,
              ),
              SizedBox(height: sp8),
              RichText(
                text: TextSpan(
                  text: 'Chức vụ: ',
                  style: AppTypography.p7.copyWith(color: AppColors.greyColor),
                  children: [
                    TextSpan(
                      text: 'Trưởng phòng',
                      style: AppTypography.p7.copyWith(color: AppColors.blackColor),
                    ),
                  ],
                ),
              ),
              SizedBox(height: sp8),
              RichText(
                text: TextSpan(
                  text: 'Bộ phận: ',
                  style: AppTypography.p7.copyWith(color: AppColors.greyColor),
                  children: [
                    TextSpan(
                      text: 'Xưởng',
                      style: AppTypography.p7.copyWith(color: AppColors.blackColor),
                    ),
                  ],
                ),
              ),
              SizedBox(height: sp8),
              RichText(
                text: TextSpan(
                  text: 'Mã: ',
                  style: AppTypography.p7.copyWith(color: AppColors.greyColor),
                  children: [
                    TextSpan(
                      text: e['account_code'],
                      style: AppTypography.p7.copyWith(color: AppColors.blue_1),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      )
    ]),
  );
}
