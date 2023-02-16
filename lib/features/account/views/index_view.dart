import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/base/base_button.dart';
import '../../../common/base/base_container.dart';
import '../../../common/routes/app_routes.dart';
import '../../../components/filter/filter_button.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_spacing.dart';
import '../../../constants/app_typography.dart';
import '../../../constants/constans.dart';
import '../../../local storage/app_shared_preference.dart';
import '../../authentication/presentation/logout/index_controller.dart';
import 'index_item.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {

  final _logoutController = Get.put(LogoutController());

  final _listFilter = [
    {
      'title' : 'Thông tin tài khoản',
      'value' : 'Thông tin tài khoản'
    },
    {
      'title' : 'Thông tin cá nhân',
      'value' : 'Thông tin cá nhân'
    },
    {
      'title' : 'Tài khoản ngân hàng',
      'value' : 'Tài khoản ngân hàng'
    },
  ];

  String _selectFilter = 'Thông tin tài khoản';

  void _handleSelectFilter(value) {
    setState(() {
      _selectFilter = value;
    });
  }

  Map? account;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    account = json.decode(AppSharedPreference.instance.getValue(PrefKeys.USER) ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          BaseContainer(
            context,
            Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: sp32,
                      backgroundImage: const NetworkImage('https://kenh14cdn.com/thumb_w/660/2017/208369346895884245754992025556316809854976n-1513265246708.jpg'),
                    ),
                    SizedBox(width: sp16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(account!['fullname'], style: AppTypography.p3),
                        SizedBox(height: sp12),
                        Row(
                          children: [
                            const Icon(Icons.phone,
                                size: 20, color: AppColors.greyColor),
                            SizedBox(width: sp8),
                            Text(
                              '(+84) 879242473',
                              style: AppTypography.p5
                                  .copyWith(color: AppColors.greyColor),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: sp16),
                SizedBox(
                  width: double.infinity,
                  child: Extrabutton(
                    title: 'Đăng xuất khỏi tài khoản',
                    event: () {
                      _logoutController.handleLogout().then((value) => Get.offAndToNamed(Routes.routeLogin));
                    },
                    largeButton: false,
                    borderColor: AppColors.borderColor_2,
                    icon: Icon(
                      Icons.logout,
                      size: sp16,
                      color: AppColors.blackColor,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: sp24),
          FilterButton(_listFilter, _selectFilter, _handleSelectFilter),
          SizedBox(height: sp24),
          if (_selectFilter == 'Thông tin tài khoản') AccountItem.buildInfoAccount(context, account!)
          else if (_selectFilter == 'Thông tin cá nhân') AccountItem.buildInfo(context)
        ],
      ),
    );
  }
}
