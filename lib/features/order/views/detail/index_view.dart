import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhe_npp/common/routes/app_routes.dart';
import 'package:lhe_npp/common/util/enum/type_ticket.dart';
import '/common/base/base_button.dart';
import '/common/util/enum/status_noti.dart';
import '/components/card/order.dart';
import '/components/notification/index.dart';
import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/app_size_device.dart';
import '../../../../common/constants/app_spacing.dart';
import '../../../../common/constants/app_typography.dart';
import '../../../../common/constants/constans.dart';
import '/features/order/models/index.dart';
import '/features/order/views/detail/index_controller.dart';
import '/features/order/views/detail/index_item.dart';
import '/features/order/views/index_controller.dart';
import '/common/util/event.dart';
import '/local%20storage/app_shared_preference.dart';

import '../../../../common/base/base_appBar.dart';

class OrderDetailView extends StatefulWidget {
  const OrderDetailView({super.key});

  @override
  State<OrderDetailView> createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends State<OrderDetailView> {
  final _orderDetailController = Get.put(OrderDetailController());
  final _orderController = Get.put(OrderController());

  bool isLoading = true;

  OrderModel? order;

  void updateStatusOrder(String status) {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Card(
          child: PopNotification(
            context,
            'Vui lòng đợi',
            null,
            StatusChat.LOADING,
          ),
        ),
      ),
    );
    var account =
        jsonDecode(AppSharedPreference.instance.getValue(PrefKeys.USER));
    var payload = {
      "system_key": "NPP",
      "system_order_id": _orderDetailController.order.system_order_id,
      "order_id": _orderDetailController.order.order_id,
      "user_id": account['id'],
      "status": status,
      "note": "AD ${account['fullname']} duyệt"
    };

    _orderDetailController.confirmOrder(payload, status).then((value) {
      Get.back();
      showDialog(
        context: context,
        builder: (context) => Center(
          child: Card(
            child: PopNotification(
              context,
              value ? 'Xác nhận đơn thành công' : 'Có lỗi, vui lòng thử lại',
              null,
              value ? StatusChat.SUCCESS : StatusChat.ERROR,
            ),
          ),
        ),
      );
      if (value) {
        _orderController.updateStatusOrder(
          int.parse(_orderDetailController.order.system_order_id.toString()),
          int.parse(status),
        );
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    order = (ModalRoute.of(context)!.settings.arguments as Map)['order'];

    if (isLoading) {
      var payload = {
        "system_key": "NPP",
        "system_order_id": order!.system_order_id,
      };

      _orderDetailController.getDetailOrder(payload).then((value) {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final typeOrder = (ModalRoute.of(context)!.settings.arguments as Map)['type'];
    return Scaffold(
      appBar: BaseAppBar('Chi tiết đơn hàng'),
      body: isLoading
          ? const SizedBox(
              height: 200,
              width: double.infinity,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              padding: EdgeInsets.all(sp16).copyWith(bottom: 120),
              color: AppColors.bg_4,
              width: widthDevice(context),
              height: heightDevice(context),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GetBuilder<OrderDetailController>(
                      builder: (controller) =>
                          OrderCard(order: _orderDetailController.order, goToDetail: false, type: typeOrder,),
                    ),
                    SizedBox(height: sp16),
                    GetBuilder<OrderDetailController>(
                      builder: (controller) => Text(
                        'Danh sách sản phẩm (${isLoading ? 0 : _orderDetailController.orderProduct.length})',
                        style: AppTypography.p1,
                      ),
                    ),
                    SizedBox(height: sp8),
                    GetBuilder<OrderDetailController>(
                      builder: (controller) => ListProductOrderCanEdit(
                        listProduct: _orderDetailController.orderProduct,
                      ),
                    ),
                  ],
                ),
              ),
            ),
      bottomSheet: BottomAppBar(
        elevation: 5,
        child: !isLoading
            ? GetBuilder<OrderDetailController>(
                builder: (controller) => Container(
                  color: AppColors.whiteColor,
                  padding: EdgeInsets.all(sp16).copyWith(bottom: sp32),
                  width: widthDevice(context),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tổng đơn hàng',
                            style: AppTypography.p5
                                .copyWith(color: AppColors.greyColor),
                          ),
                          GetBuilder<OrderDetailController>(
                            builder: (controller) => Text(
                              '${FormatCurrency(_orderDetailController.totalPrice)} VNĐ',
                              style: AppTypography.p3
                                  .copyWith(color: AppColors.mainColor),
                            ), 
                          ),
                          // Text(
                          //     '${FormatCurrency(_orderDetailController.totalPrice)} VNĐ',
                          //     style: AppTypography.p3
                          //         .copyWith(color: AppColors.mainColor),
                          //   ),
                        ],
                      ),
                      if (_orderDetailController.order.status_id == 1 && typeOrder == TYPE_TICKET.EXPORT)
                        SizedBox(height: sp16),
                      if (_orderDetailController.order.status_id == 1 && typeOrder == TYPE_TICKET.EXPORT)
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Extrabutton(
                                title: 'Từ chối',
                                event: () {
                                  updateStatusOrder('2');
                                },
                                largeButton: true,
                                borderColor: AppColors.borderColor_4,
                                icon: null,
                              ),
                            ),
                            SizedBox(width: sp16),
                            Expanded(
                              child: MainButton(
                                title: 'Phê duyệt',
                                event: () {
                                  _confirmOrder();
                                  // updateStatusOrder('1');
                                },
                                largeButton: true,
                                icon: null,
                              ),
                            ),
                          ],
                        )
                    ],
                  ),
                ),
              )
            : const SizedBox(),
      ),
    );
  }

  _confirmOrder () {
    Get.toNamed(Routes.routeCreateOrderExport, arguments: order);
  }
}
