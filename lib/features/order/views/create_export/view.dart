import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhe_npp/common/base/base_appBar.dart';
import 'package:lhe_npp/common/base/base_button.dart';
import 'package:lhe_npp/common/base/base_container.dart';
import 'package:lhe_npp/common/base/base_input.dart';
import 'package:lhe_npp/common/routes/app_routes.dart';
import 'package:lhe_npp/common/util/api.dart';
import 'package:lhe_npp/common/util/enum/status_noti.dart';
import 'package:lhe_npp/common/util/enum/type_ticket.dart';
import 'package:lhe_npp/components/item/row.dart';
import 'package:lhe_npp/common/constants/app_colors.dart';
import 'package:lhe_npp/common/constants/app_size_device.dart';
import 'package:lhe_npp/common/constants/app_spacing.dart';
import 'package:lhe_npp/common/constants/app_typography.dart';
import 'package:lhe_npp/common/constants/constans.dart';
import 'package:lhe_npp/features/order/models/order_product.dart';
import 'package:lhe_npp/features/order/views/create_export/controller.dart';
import 'package:lhe_npp/features/order/views/create_export/item.dart';
import 'package:lhe_npp/features/order/views/detail/index_controller.dart';
import 'package:lhe_npp/features/warehouse/apis/index.dart';
import 'package:lhe_npp/local%20storage/app_shared_preference.dart';

import '../../../../components/notification/index.dart';
import '../../../warehouse/models/consignment.dart';
import '../../models/index.dart';

class CreateExportOrder extends StatefulWidget {
  const CreateExportOrder({super.key});

  @override
  State<CreateExportOrder> createState() => _CreateExportOrderState();
}

class _CreateExportOrderState extends State<CreateExportOrder> {
  final _orderDetailController = Get.put(OrderDetailController());
  final _createExportOrderController = Get.put(CreateExportOrderController());

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _getWarehouse();
    _createExportOrderController
        .converData(_orderDetailController.orderProduct);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        'Tạo đơn hàng xuất ${_orderDetailController.order.order_id}',
      ),
      body: Container(
        width: widthDevice(context),
        height: heightDevice(context),
        padding: EdgeInsets.all(sp16),
        color: AppColors.bg_4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Thông tin đơn hàng', style: AppTypography.p1),
            SizedBox(height: sp16),
            BaseContainer(
              context,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Mã đơn hàng',
                    style: AppTypography.p6.copyWith(
                      color: AppColors.greyColor,
                    ),
                  ),
                  Text(
                    _orderDetailController.order.order_code,
                    style: AppTypography.h5
                        .copyWith(color: AppColors.accentColor_6),
                  )
                ],
              ),
            ),
            SizedBox(height: sp16),
            BaseContainer(
              context,
              Column(
                children: [
                  buildRowItem(
                    title: 'Xuất hàng tới',
                    content: _orderDetailController.order.account_name,
                  ),
                  SizedBox(height: sp8),
                  const Divider(),
                  SizedBox(height: sp8),
                  AppInput(
                    label: 'Ghi chú',
                    hintText: 'Nhập ghi chú đơn hàng',
                    controller: TextEditingController(
                        text: _orderDetailController.order.order_note),
                    context: context,
                    show: true,
                    isPassword: false,
                    textInputType: TextInputType.text,
                    suffixIcon: null,
                    validate: () {},
                  )
                ],
              ),
            ),
            SizedBox(height: sp16),
            Text('Sản phẩm xuất', style: AppTypography.p1),
            SizedBox(height: sp16),
            _isLoading ? const Center(child: CircularProgressIndicator()) : GetBuilder<CreateExportOrderController>(
              builder: (controller) => Column(
                children: _createExportOrderController.listProductOrder
                    .map((item) => InkWell(
                          onTap: () => showDialog(
                            context: context,
                            builder: (context) => PopSuggestConsigment(
                              data: item,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppColors.borderColor_4),
                              borderRadius: BorderRadius.circular(sp8),
                              color: AppColors.whiteColor,
                            ),
                            padding: EdgeInsets.all(sp16),
                            margin: EdgeInsets.only(bottom: sp16),
                            child: Row(children: [
                              SizedBox(
                                width: sp48,
                                height: sp48,
                                child: Image.network(
                                  'https://thachlonghai.com.vn/FileManager/Thachlonghai/Sanpham/Thach_Rau_Cau/Thach_tui_910g/Thach-rau-cau-Long-Hai-Thach-Long-Hai-Thach-rau-cau-hoa-qua-tui-910g%20(1).jpg',
                                ),
                              ),
                              SizedBox(width: sp16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item['product'].formula_name,
                                      style: AppTypography.h6),
                                  SizedBox(height: sp8),
                                  Text(
                                    'Số lượng sản xuất',
                                    style: AppTypography.p6.copyWith(
                                      color: AppColors.greyColor,
                                    ),
                                  ),
                                  SizedBox(height: sp8),
                                  Text(
                                    (item['amount_data']['consignment'] as List)
                                            .isEmpty
                                        ? 'Chưa chọn lô'
                                        : 'Đã chọn lô: ${(item['amount_data']['consignment'][0] as ConsignmentModel).consignment_code}',
                                    style: AppTypography.p5.copyWith(
                                        color: (item['amount_data']
                                                    ['consignment'] as List)
                                                .isEmpty
                                            ? AppColors.red_1
                                            : AppColors.green_1),
                                  )
                                ],
                              ),
                            ]),
                          ),
                        ))
                    .toList(),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(sp16),
        color: AppColors.whiteColor,
        child: Row(
          children: [
            Expanded(
              child: Extrabutton(
                title: 'Huỷ bỏ',
                event: () {
                  Get.back();
                },
                largeButton: true,
                borderColor: AppColors.borderColor_4,
                icon: null,
              ),
            ),
            SizedBox(width: sp16),
            Expanded(
              child: MainButton(
                title: 'Tạo đơn',
                event: () {
                  _createExportOrder();
                },
                largeButton: true,
                icon: null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _getWarehouse() {
    final warehouseService = WarehouseService();
    var account =
        jsonDecode(AppSharedPreference.instance.getValue(PrefKeys.USER));
    var payload = {
      "system_key": Api.KEY,
      "account_id": account['id'],
      "page_size": 10,
      "page": 0
    };

    warehouseService.getWarehouse(payload).then(
      (value) {
        AppSharedPreference.instance
            .setValue(PrefKeys.WAREHOUSE, jsonEncode(value[0]));
        setState(() {
          _isLoading = false;
        });
      },
    );
  }

  void _createExportOrder() {
    showDialog(
      context: context,
      builder: (context) => PopNotification(
        context,
        'Đang đơn xuất hàng, vui lòng đợi!',
        null,
        StatusChat.LOADING,
      ),
    );
    var warehouse =
        jsonDecode(AppSharedPreference.instance.getValue(PrefKeys.WAREHOUSE));
    var account =
        jsonDecode(AppSharedPreference.instance.getValue(PrefKeys.USER));
    var payload = {
      "order_id": (_orderDetailController.order as OrderModel).order_id,
      "system_key": Api.KEY,
      "warehouse_code": warehouse['warehouse_code'],
      "user_created": 2,
      "amount_data": _createExportOrderController.listProductOrder.map((item) {
        return {
          "source_type_code": "FORMULA",
          "amount_type_code": "BIN",
          "consignment": [
            (item['amount_data']['consignment'][0] as ConsignmentModel)
                .toJsonCreateRe(
                    "BIN", (item['product'] as OrderProductModel).amount!)
          ],
          "custom_id": (item['product'] as OrderProductModel).formula_id,
          "amount": (item['product'] as OrderProductModel).amount
        };
      }).toList()
    };

    debugPrint('payload: $payload');

    _createExportOrderController.createReceiptsExport(payload).then((value) {
      Get.back();
      showDialog(
        context: context,
        builder: (context) => PopNotification(
          context,
          value['isErr']
              ? 'Có lỗi trong quá trình tạo'
              : 'Tạo đơn xuất hàng thành công',
          value['isErr']
              ? null
              : () {
                  Get.offAndToNamed(
                    Routes.routeOrderDetail,
                    arguments: {
                      'order': _orderDetailController.order,
                      'type': TYPE_TICKET.EXPORT
                    },
                  );
                },
          value['isErr'] ? StatusChat.ERROR : StatusChat.SUCCESS,
        ),
      );
    });
  }
}
