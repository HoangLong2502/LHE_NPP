import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../common/routes/app_routes.dart';
import '../../../common/constants/assets_path.dart';
import '../model/app_model.dart';

class AppController extends GetxController {
  var listApp = [
    AppModel(
      logo: Image.asset(
        '${AssetsPath.image}/app_sanpham.png',
        width: double.infinity,
      ),
      title: 'Sản phẩm',
      routeName: Routes.routeProduct,
      show: true,
    ),
    AppModel(
      logo: Image.asset(
        '${AssetsPath.image}/app_khachhang.png',
        width: double.infinity,
      ),
      title: 'Khách hàng',
      routeName: '',
      show: true,
    ),
    AppModel(
      logo: SvgPicture.asset(
        '${AssetsPath.image}/app_donhang.svg',
        width: double.infinity,
      ),
      title: 'Đơn hàng',
      routeName: Routes.routeOrder,
      show: true,
    ),
    AppModel(
      logo: Image.asset('${AssetsPath.image}/app_quanlytaikhoan.png'),
      title: 'Quản lý tài khoản',
      routeName: Routes.routeUserManager,
      show: true,
    ),
    AppModel(
      logo: Image.asset('${AssetsPath.image}/app_quanlynpp.png'),
      title: 'Quản lý NPP',
      routeName: Routes.routeNPP,
      show: true,
    ),
    AppModel(
      logo: Image.asset('${AssetsPath.image}/app_canhan.png'),
      title: 'Cá nhân',
      routeName: Routes.routeAccount,
      show: true,
    ),
    AppModel(
      logo: Image.asset('${AssetsPath.image}/app_setting.png'),
      title: 'Cài đặt hệ thống',
      routeName: Routes.routeSetting,
      show: true,
    ),
    // AppModel(
    //   logo: Image.asset('${AssetsPath.image}/app_thuongmaidientu.png'),
    //   title: 'ecommerce'.tr,
    //   routeName: '',
    //   show: true,
    // ),
    // AppModel(
    //   logo: Image.asset('${AssetsPath.image}/app_mangxahoinoibo.png'),
    //   title: 'internal social network'.tr,
    //   routeName: Routes.routeProduct,
    //   show: true,
    // )
  ].obs;

  var dataFinancialSituation = [
    {
      'title' : 'Tổng tiền',
      'value' : '1000000',
    },
    {
      'title' : 'Phải thu',
      'value' : '2000000',
    },
    {
      'title' : 'Phải trả',
      'value' : '3000000',
    }
  ].obs;
}
