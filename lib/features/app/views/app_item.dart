import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/base/base_container.dart';
import '../../../components/chart/sale_chart.dart';
import '../../../components/maps/index.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_size_device.dart';
import '../../../constants/app_spacing.dart';
import '../../../constants/app_typography.dart';
import '../../../common/routes/app_routes.dart';
import '../../../constants/assets_path.dart';
import '../model/app_model.dart';
import 'app_controller.dart';

Widget buildAppItem(BuildContext context, Widget logo, String title,
    String routeName, int index) {
  return InkWell(
    onTap: () {
      Get.toNamed('$routeName');
      // routeName == ''
      //     ? Get.toNamed(Routes.routeTabs, arguments: '$index')
      //     : Get.toNamed('$routeName');
    },
    child: Column(
      children: [
        Container(height: (widthDevice(context) - 15) / 4, child: logo),
        Text(
          title,
          style: AppTypography.p8.copyWith(color: AppColors.whiteColor),
          textAlign: TextAlign.center,
        )
      ],
    ),
  );
}

Widget buildSlider_1(BuildContext context, List<AppModel> _listApp) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.6,
        crossAxisSpacing: 16,
        mainAxisSpacing: 8,
      ),
      itemCount: _listApp.length,
      itemBuilder: (context, index) => buildAppItem(
        context,
        _listApp[index].logo,
        _listApp[index].title,
        _listApp[index].routeName,
        index,
      ),
    ),
  );
}

Widget buildSlider_2(BuildContext context, AppController appController) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: ListView(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.asset('${AssetsPath.image}/dashboard/sale.png', fit: BoxFit.cover,)),
            SizedBox(width: sp16),
            Expanded(
              flex: 1,
              child: Image.asset('${AssetsPath.image}/dashboard/owe.png', fit: BoxFit.cover,))
          ],
        ),
        SizedBox(height: sp16),
        FinancialSituation(context, appController.dataFinancialSituation),
        // Plan(context, appController.dataFinancialSituation),
        SizedBox(height: sp16),
        LineChartSample1(),
        SizedBox(height: sp16),
        SalesNetwork(context),
      ],
    ),
  );
}

Widget FinancialSituation(BuildContext context, List data) {
  return BaseContainer(
      context,
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tình hình tài chính',
                style: AppTypography.h4,
              ),
              // SizedBox(
              //   width: 120,
              //   child: BaseSelect(list: ['Tháng này'],select: 'Tháng này',handleSelect: () {}, hint: ''))
            ],
          ),
          SizedBox(height: sp16),
          Container(
            width: widthDevice(context) - 64,
            height: 114,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => SizedBox(width: sp16),
              itemBuilder: (context, index) => ItemHomeContainer(data[index]),
              itemCount: data.length,
            ),
          )
        ],
      ));
}

Widget Plan(BuildContext context, List data) {
  return BaseContainer(
      context,
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Kế hoạch',
                style: AppTypography.h4,
              ),
              // SizedBox(
              //   width: 120,
              //   child: BaseSelect(list: ['Tháng này'],select: 'Tháng này',handleSelect: () {},hint: ''))
            ],
          ),
          SizedBox(height: sp16),
          Container(
            width: widthDevice(context) - 64,
            height: 114,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => SizedBox(width: sp16),
              itemBuilder: (context, index) => ItemHomeContainer(data[index]),
              itemCount: data.length,
            ),
          )
        ],
      ));
}

Widget SalesNetwork(BuildContext context) {
  return BaseContainer(
    context,
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Mạng lưới bán hàng', style: AppTypography.h3),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(0),
              ),
              onPressed: () {
                Get.toNamed(Routes.routeGoogleMapScreen);
              },
              child: Text('Chi tiết'),
            ),
          ],
        ),
        SizedBox(height: sp16),
        GoogleMapComponent(),
      ],
    ),
  );
}

Widget ItemHomeContainer(Map<String, dynamic> data) {
  return Container(
    width: 208,
    height: 114,
    padding: EdgeInsets.all(sp16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(sp8),
      color: AppColors.bg_4,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data['title'],
          style: AppTypography.p5,
        ),
        SizedBox(height: sp12),
        Text(
          data['value'],
          style: AppTypography.h4,
        )
      ],
    ),
  );
}
