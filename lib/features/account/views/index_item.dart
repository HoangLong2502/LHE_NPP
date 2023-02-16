import 'package:flutter/material.dart';

import '../../../common/base/base_button.dart';
import '../../../common/base/base_container.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_spacing.dart';
import '../../../constants/app_typography.dart';

class AccountItem {
  static Widget buildInfoAccount(
    BuildContext context,
    Map account,
  ) {
    return BaseContainer(
      context,
      Column(
        children: [
          buildRowText('Tài khoản', account['username']),
          SizedBox(height: sp12),
          buildRowText('Email', account['email']),
          SizedBox(height: sp12),
          buildRowText('Mật khẩu', '************'),
          SizedBox(height: sp16),
          
          SizedBox(
            width: double.infinity,
            child: SupportButton(
              title: 'Thay đổi mật khẩu',
              event: () {},
              largeButton: false,
              icon: const Icon(Icons.key),
              backgroundColor: AppColors.blackColor
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildInfo(BuildContext context) {
    return BaseContainer(
      context,
      Column(
        children: [],
      ),
    );
  }

  static Widget buildRowText(title, value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$title',
          style: AppTypography.p6,
        ),
        Text(
          '$value',
          style: AppTypography.h6,
        ),
      ],
    );
  }
}
