import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhe_npp/common/base/base_appBar.dart';
import 'package:lhe_npp/common/base/base_container.dart';
import 'package:lhe_npp/common/base/base_input.dart';
import 'package:lhe_npp/common/util/api.dart';
import 'package:lhe_npp/components/item/row.dart';
import 'package:lhe_npp/constants/app_colors.dart';
import 'package:lhe_npp/constants/app_size_device.dart';
import 'package:lhe_npp/constants/app_spacing.dart';
import 'package:lhe_npp/constants/app_typography.dart';

import '../../../../common/base/base_button.dart';
import '../../../../common/util/enum/status_noti.dart';
import '../../../../common/util/event.dart';
import '../../../../components/notification/index.dart';
import '../../../../constants/constans.dart';
import '../../../../local storage/app_shared_preference.dart';
import 'controller.dart';
import 'item.dart';

class CreateImportOrder extends StatefulWidget {
  const CreateImportOrder({super.key});

  @override
  State<CreateImportOrder> createState() => _CreateImportOrderState();
}

class _CreateImportOrderState extends State<CreateImportOrder> {
  final _controller = Get.put(PurchaseOrderController());

  TextEditingController? search;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getProductNPP();
    search = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    search!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar('Tạo đơn nhập hàng'),
      body: Container(
        width: widthDevice(context),
        height: heightDevice(context),
        color: AppColors.bg_4,
        padding: EdgeInsets.symmetric(vertical: sp24, horizontal: sp16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thông tin đơn hàng',
                style: AppTypography.p1,
              ),
              SizedBox(height: sp24),
              BaseContainer(
                context,
                Column(
                  children: [
                    buildRowItem(title: 'Nhập hàng từ', content: 'Kho Long Hải'),
                    SizedBox(height: sp16),
                    const Divider(height: 1),
                    SizedBox(height: sp16),
                    AppInput(
                      label: 'Ghi chú',
                      hintText: 'Nhập ghi chú',
                      controller: TextEditingController(),
                      context: context,
                      show: true,
                      isPassword: false,
                      textInputType: TextInputType.text,
                      suffixIcon: null,
                      validate: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: sp24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Danh sách sản phẩm',
                    style: AppTypography.p1,
                  ),
                  SizedBox(height: sp16),
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : GetBuilder<PurchaseOrderController>(
                          builder: (controller) =>
                              _controller.productAvailable.isEmpty
                                  ? PurchaseOrderItem.emty(context, selectProduct)
                                  : PurchaseOrderItem.list(
                                      context,
                                      selectProduct,
                                      _controller,
                                    ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Material(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(sp16),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tổng đơn hàng',
                    style:
                        AppTypography.p5.copyWith(color: AppColors.greyColor)),
                GetBuilder<PurchaseOrderController>(
                  builder: (controller) => Text(
                    '${FormatCurrency(_controller.totalPrice())} VNĐ',
                    style:
                        AppTypography.p3.copyWith(color: AppColors.mainColor),
                  ),
                )
              ],
            ),
            SizedBox(height: sp16),
            Row(
              children: [
                Expanded(
                  child: Extrabutton(
                    title: 'Huỷ',
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
                    title: 'Xác nhận',
                    event: () {
                      _createOrder();
                    },
                    largeButton: true,
                    icon: null,
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }

  void selectProduct() {
    showDialog(
      context: context,
      builder: (context) => PurchaseOrderItem.popup(
        context,
        search!,
        _controller,
      ),
    );
  }

  void _getProductNPP() {
    var payload = {"page": "0", "page_size": "10", "system_key": "AD"};
    _controller.getProductNPP(payload).then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _createOrder() {
    showDialog(
      context: context,
      builder: (context) => PopNotification(
        context,
        'Đang tạo đơn vui lòng đợi',
        null,
        StatusChat.LOADING,
      ),
    );

    List<dynamic> order_item = createOrderItem();
    
    var account =
        jsonDecode(AppSharedPreference.instance.getValue(PrefKeys.USER));
    var payload = {
      "order_price": _controller.totalPrice(),
      "address_from": "Tang 1 - 48 To Huu",
      "address_to": "Tang 2 - 48 To Huu",
      "note": "Ghi chu",
      "type_code": "AD#KT#NPP", //"AD#KT#KH#NPP", // QC create type_code
      "customer_id": 1, // account['id'], // id ADMIN
      "order_item": order_item,
      "user_id": account['id'],
      "account_from": account['id'],
      "account_name": account['fullname'],
      "account_system": Api.KEY,
      "transport_id": 1,
      "transport_status": false
    };
    _controller.createOrder(payload).then((value) {
      Get.back();

      showDialog(
        context: context,
        builder: (context) => PopNotification(
          context,
          value ? 'Tạo đơn thành công' : 'Tạo đơn thất bại, vui lòng thử lại !',
          null,
          value ? StatusChat.SUCCESS : StatusChat.ERROR,
        ),
      );
    });
  }

  // create order item in payload create order
  List<dynamic> createOrderItem() {
    var order_item = _controller.productAvailable.fold([], (results, item) {
      var index = results.indexWhere((e) => e['product_id'] == item.product_id);
      if (index == -1) {
        results.add({
          "product_id": item.product_id,
          "product_price": item.price,
          "product_name": item.subtitle,
          "formula": [
            {
              "formula_id": item.id,
              "formula_price": item.price,
              "formula_name": item.title,
              "amount": item.quantity,
              "warehouse_id": 1,
              "consignment": 1,
              "unit" : "BIN"
            }
          ],
        });
      } else {
        (results[index]['formula'] as List).add({
          "formula_id": item.id,
          "formula_price": item.price,
          "formula_name": item.title,
          "amount": item.quantity,
          "warehouse_id": 1,
          "consignment": 1,
          "unit" : "BIN"
        });
      }
      return results;
    });
    return order_item;
  }
}
