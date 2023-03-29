import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/base/base_button.dart';
import '../../../../../common/base/base_container.dart';
import '../../../../../components/item/row.dart';
import '../../../../../common/constants/app_colors.dart';
import '../../../../../common/constants/app_size_device.dart';
import '../../../../../common/constants/app_spacing.dart';
import '../index_controller.dart';

class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final DetailNPPController _controller = Get.put(DetailNPPController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightDevice(context),
      padding: EdgeInsets.all(sp16),
      color: AppColors.bg_4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Extrabutton(
              title: 'Chỉnh sửa',
              event: () {},
              largeButton: true,
              borderColor: AppColors.borderColor_2,
              icon: Icon(
                Icons.edit,
                size: sp16,
                color: AppColors.blackColor,
              ),
              bgColor: AppColors.whiteColor),
          SizedBox(height: sp24),
          BaseContainer(
            context,
            GetBuilder<DetailNPPController>(
              builder: (controller) {
                return Column(
                  children: [
                    buildRowItem(
                      title: 'Họ và tên',
                      content: _controller.dataProfile['fullname'],
                    ),
                    SizedBox(height: sp16),
                    buildRowItem(
                      title: 'Họ và tên',
                      content: _controller.dataProfile['fullname'],
                    ),
                    SizedBox(height: sp16),
                    buildRowItem(
                      title: 'Họ và tên',
                      content: _controller.dataProfile['fullname'],
                    ),
                    SizedBox(height: sp16),
                    buildRowItem(
                      title: 'Họ và tên',
                      content: _controller.dataProfile['fullname'],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
