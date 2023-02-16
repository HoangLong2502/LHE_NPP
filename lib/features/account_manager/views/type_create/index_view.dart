import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../common/base/base_appBar.dart';
import '../../../../common/base/base_container.dart';
import '../../../../common/routes/app_routes.dart';
import '../../../../common/util/enum/type_user.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_size_device.dart';
import '../../../../constants/app_spacing.dart';
import '../../../../constants/app_typography.dart';
import '../../../../constants/assets_path.dart';

class TypeCreateUserView extends StatefulWidget {
  const TypeCreateUserView({super.key});

  @override
  State<TypeCreateUserView> createState() => _TypeCreateUserViewState();
}

class _TypeCreateUserViewState extends State<TypeCreateUserView> {
  final List<Map<String, dynamic>> listTypeCreateAccount = [
    {
      "image": "${AssetsPath.image}/user_manager/npp.svg",
      "title": "Nhà phân phối",
      "bg_color": AppColors.blue_2,
      "color": AppColors.blue_1,
      "key": TypeUser.NPP
    },
    {
      "image": "${AssetsPath.image}/user_manager/npp.svg",
      "title": "Nhân viên thị trường",
      "bg_color": AppColors.green_2,
      "color": AppColors.green_1,
      "key": TypeUser.NVTT
    },
    {
      "image": "${AssetsPath.image}/user_manager/npp.svg",
      "title": "Kế toán",
      "bg_color": AppColors.yellow_2,
      "color": AppColors.yellow_1,
      "key": TypeUser.KT
    },
    {
      "image": "${AssetsPath.image}/user_manager/npp.svg",
      "title": "Kho",
      "bg_color": AppColors.purple_2,
      "color": AppColors.purple_1,
      "key": TypeUser.KH
    },
    {
      "image": "${AssetsPath.image}/user_manager/npp.svg",
      "title": "Quản lý tổng",
      "bg_color": AppColors.pink_2,
      "color": AppColors.pink_1,
      "key": TypeUser.AD
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar('Tạo người dùng'),
      body: Container(
        color: AppColors.bg_4,
        width: widthDevice(context),
        height: heightDevice(context),
        padding: EdgeInsets.symmetric(vertical: sp24, horizontal: sp16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Vui lòng chọn hệ thống \n mà bạn muốn tạo tài khoản !',
                style: AppTypography.p3,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: sp24),
              SizedBox(
                width: widthDevice(context),
                height: heightDevice(context) - 100,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: sp16,
                      crossAxisSpacing: sp16,
                      childAspectRatio: 1.25),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () => Get.toNamed(
                      Routes.routeCreateUser,
                      arguments: listTypeCreateAccount[index]['key'],
                    ),
                    child: BaseContainer(
                      context,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 56,
                            width: 56,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(sp8),
                              color: listTypeCreateAccount[index]['bg_color']
                                  as Color,
                            ),
                            child: Center(
                              child: SizedBox(
                                height: sp16,
                                width: sp16,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(sp8),
                                  child: SvgPicture.asset(
                                    '${listTypeCreateAccount[index]['image']}',
                                    color: listTypeCreateAccount[index]['color']
                                        as Color,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: sp16),
                          Text(
                            '${listTypeCreateAccount[index]['title']}',
                            style: AppTypography.h6,
                          )
                        ],
                      ),
                    ),
                  ),
                  itemCount: listTypeCreateAccount.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
