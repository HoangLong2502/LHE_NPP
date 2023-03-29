import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lhe_npp/common/base/base_button.dart';
import 'package:lhe_npp/common/routes/app_routes.dart';
import 'package:lhe_npp/common/util/enum/type_ticket.dart';
import 'package:lhe_npp/common/constants/app_size_device.dart';

import '../../common/constants/app_colors.dart';
import '../../common/constants/app_spacing.dart';
import '../../common/constants/app_typography.dart';
import '../../common/constants/assets_path.dart';
import '../../features/order/models/index.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  final bool goToDetail;
  final TYPE_TICKET type;

  const OrderCard({required this.order, required this.goToDetail, required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderColor_4),
          borderRadius: BorderRadius.circular(sp8)),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(sp16),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(sp8),
                bottom: const Radius.circular(0),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(order.account_name.toString(),
                            style: AppTypography.p3),
                        SizedBox(height: sp8),
                        Text(
                          '#${order.order_code}',
                          style: AppTypography.p5
                              .copyWith(color: AppColors.blue_1),
                        )
                      ],
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: sp8, horizontal: sp16),
                      decoration: BoxDecoration(
                          color: order.status_id == 1
                              ? AppColors.bg_2
                              : order.status_id == 2
                                  ? AppColors.yellow_2
                                  : order.customer_id == 3
                                      ? AppColors.green_2
                                      : AppColors.red_2,
                          borderRadius: BorderRadius.circular(sp8)),
                      child: Text(
                        order.status_name.toString(),
                        style: AppTypography.p5.copyWith(
                          color: order.status_id == 1
                              ? AppColors.blackColor
                              : order.status_id == 2
                                  ? AppColors.yellow_1
                                  : order.customer_id == 3
                                      ? AppColors.green_1
                                      : AppColors.red_1,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: sp16),
                // info order
                buildInfoItem(
                  SizedBox(
                    child:
                        SvgPicture.asset('${AssetsPath.image}/order/type.svg'),
                  ),
                  order.account_system.toString(),
                ),
                SizedBox(height: sp12),
                buildInfoItem(
                  SizedBox(
                    child: SvgPicture.asset(
                        '${AssetsPath.image}/order/calendar.svg'),
                  ),
                  order.created_at.toString(),
                ),
                SizedBox(height: sp12),
                buildInfoItem(
                  SizedBox(
                    child:
                        SvgPicture.asset('${AssetsPath.image}/order/note.svg'),
                  ),
                  order.order_note.toString(),
                ),
              ],
            ),
          ),
          if (goToDetail) Container(
            decoration: BoxDecoration(
                color: AppColors.bg_4,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(sp8))),
            padding: EdgeInsets.symmetric(horizontal: sp16, vertical: sp12),
            child: SizedBox(
              width: widthDevice(context),
              child: Extrabutton(
                title: 'Xem chi tiết',
                event: () {
                  Get.toNamed(Routes.routeOrderDetail, arguments: {
                    'order' : order,
                    'type' : type
                  });
                },
                largeButton: false,
                borderColor: AppColors.borderColor_4,
                icon: null,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildInfoItem(Widget icon, String text) {
    return Row(
      children: [
        icon,
        SizedBox(width: sp8),
        Text(
          text != '' ? text : 'Không có ghi chú',
          style: AppTypography.p5.copyWith(color: AppColors.greyColor),
        )
      ],
    );
  }
}
