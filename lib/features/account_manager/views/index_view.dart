import 'package:flutter/cupertino.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_size_device.dart';
import '../../../common/constants/app_spacing.dart';
import '../../../common/constants/app_typography.dart';
import '../../group/views/index_view.dart';
import 'index_item.dart';

enum TYPE { USER, GROUP }

class UserManagerView extends StatefulWidget {
  const UserManagerView({super.key});

  @override
  State<UserManagerView> createState() => _UserManagerViewState();
}

class _UserManagerViewState extends State<UserManagerView> {
  TYPE page = TYPE.USER;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoSlidingSegmentedControl(
          children: {
            TYPE.USER: Container(
              width: (widthDevice(context) - 32 - 16) / 2,
              padding: EdgeInsets.symmetric(vertical: sp12),
              child: Center(
                child: Text(
                  'Người dùng',
                  style: AppTypography.p5.copyWith(
                    color: page == TYPE.USER
                        ? AppColors.blackColor
                        : AppColors.greyColor,
                  ),
                ),
              ),
            ),
            TYPE.GROUP: Container(
              width: (widthDevice(context) - 32 - 16) / 2,
              padding: EdgeInsets.symmetric(vertical: sp12),
              child: Center(
                child: Text(
                  'Nhóm người dùng',
                  style: AppTypography.p5.copyWith(
                    color: page == TYPE.GROUP
                        ? AppColors.blackColor
                        : AppColors.greyColor,
                  ),
                ),
              ),
            ),
          },
          padding: EdgeInsets.all(sp8),
          thumbColor: AppColors.bg_4,
          backgroundColor: AppColors.whiteColor,
          groupValue: page,
          onValueChanged: (value) {
            setState(() {
              page = value!;
            });
          },
        ),
        SizedBox(height: sp16),
        page == TYPE.USER ? const UserPage() : const GroupView(),
      ],
    );
  }
}
