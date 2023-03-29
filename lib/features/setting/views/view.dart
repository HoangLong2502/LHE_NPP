import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/common/base/base_container.dart';
import '/common/base/base_layout.dart';
import '/common/routes/app_routes.dart';
import '../../../common/constants/app_spacing.dart';
import '../../../common/constants/app_typography.dart';
import '../../../common/constants/assets_path.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      'Cài đặt',
      Column(
        children: [
          BaseContainer(
            context,
            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0),
              leading: SizedBox(
                height: 48,
                width: 48,
                child: ClipRRect(
                  child: Image.asset('${AssetsPath.image}/setting/setting_genera.png'),
                ),
              ),
              title: Text(
                'Cài đặt chung',
                style: AppTypography.p4,
              ),
            ),
          ),
          SizedBox(height: sp16),
          BaseContainer(
            context,
            InkWell(
              onTap: () {
                Get.toNamed(Routes.routeSettingOrder);
              },
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                leading: SizedBox(
                  height: 48,
                  width: 48,
                  child: ClipRRect(
                    child: Image.asset('${AssetsPath.image}/setting/setting_order.png'),
                  ),
                ),
                title: Text(
                  'Cài đặt luồng đơn',
                  style: AppTypography.p4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
