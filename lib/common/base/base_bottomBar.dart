import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../constants/app_size_device.dart';
import '../constants/assets_path.dart';
import '../routes/app_routes.dart';

Widget buildBottomBar(BuildContext context, int pageIndex, Function changeTab) {
  return SizedBox(
    height: 116,
    width: widthDevice(context),
    child: Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: CustomPaint(
            size: Size(widthDevice(context), 80),
            painter: BNBCustomPainter(context: context),
          ),
        ),
        Center(
          heightFactor: 1,
          child: SizedBox(
            width: 64,
            height: 64,
            child: FloatingActionButton(
              elevation: 4,
              onPressed: () {
                Get.offAllNamed(Routes.routeHomeScreen);
              },
              backgroundColor: AppColors.mainColor,
              child: SvgPicture.asset(
                '${AssetsPath.image}/icon_home.svg',
                width: 21,
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 24),
          width: widthDevice(context),
          height: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Get.toNamed(Routes.routeProduct);
                },
                icon: SvgPicture.asset(
                  '${AssetsPath.image}/icon_warehouse.svg',
                  width: 18,
                  color: pageIndex == 0
                      ? const Color.fromARGB(255, 0, 0, 0)
                      : AppColors.greyColor,
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.toNamed(Routes.routeOrder);
                },
                icon: SvgPicture.asset(
                  '${AssetsPath.image}/icon_order.svg',
                  width: 21,
                  color: pageIndex == 3
                      ? const Color.fromARGB(255, 0, 0, 0)
                      : AppColors.greyColor,
                ),
              ),
              const SizedBox(),
              IconButton(
                onPressed: () {
                  changeTab(2);
                },
                icon: SvgPicture.asset(
                  '${AssetsPath.image}/icon_customer.svg',
                  width: 21,
                  color: pageIndex == 2
                      ? const Color.fromARGB(255, 0, 0, 0)
                      : AppColors.greyColor,
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.toNamed(Routes.routeUserManager);
                },
                icon: SvgPicture.asset(
                  '${AssetsPath.image}/icon_user.svg',
                  width: 16,
                  color: pageIndex == 3
                      ? const Color.fromARGB(255, 0, 0, 0)
                      : AppColors.greyColor,
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

class BNBCustomPainter extends CustomPainter {
  final context;

  BNBCustomPainter({required this.context});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColors.whiteColor
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(0, 0, 16, 0);
    path.lineTo(size.width * 0.357, 0);
    path.quadraticBezierTo(size.width * 0.385, 0, size.width * 0.405, 13.5);
    // path.arcToPoint(Offset(size.width*0.6, 20), radius: Radius.circular(8), clockwise: false);
    path.quadraticBezierTo(size.width * 0.445, 36, size.width * 0.5, 36);
    path.quadraticBezierTo(size.width * 0.555, 36, size.width * 0.595, 13.5);
    path.quadraticBezierTo(size.width * 0.615, 0, size.width * 0.643, 0);
    path.lineTo(size.width - 16, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 20);
    path.lineTo(size.width, 80);
    path.lineTo(0, 80);
    path.close();

    canvas.drawPath(path, paint);
    canvas.drawShadow(path, Colors.black45, 1, false);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
