import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhe_npp/common/base/base_button.dart';
import 'package:lhe_npp/components/card/consignment.dart';
import 'package:lhe_npp/components/item/row.dart';
import 'package:lhe_npp/constants/constans.dart';
import 'package:lhe_npp/features/order/models/order_product.dart';
import 'package:lhe_npp/features/order/views/create_export/controller.dart';
import 'package:lhe_npp/features/warehouse/models/consignment.dart';
import 'package:lhe_npp/local%20storage/app_shared_preference.dart';

import '../../../../common/base/base_container.dart';
import '../../../../common/util/event.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_spacing.dart';
import '../../../../constants/app_typography.dart';

// ignore: must_be_immutable
class PopSuggestConsigment extends StatefulWidget {
  PopSuggestConsigment({required this.data, super.key});

  Map data;

  @override
  State<PopSuggestConsigment> createState() => _PopSuggestConsigmentState();
}

class _PopSuggestConsigmentState extends State<PopSuggestConsigment> {
  final _createExportOrderController = Get.put(CreateExportOrderController());

  bool _isLoading = true;
  int _step = 1;
  ConsignmentModel? _consignmentSelect;

  @override
  void initState() {
    super.initState();

    _getDataConsigment();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: BaseContainer(
          context,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: _step == 1
                ? [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Lô hàng hiện có',
                          style: AppTypography.p3,
                        ),
                        InkWell(
                          child: Icon(
                            Icons.close,
                            size: sp16,
                          ),
                          onTap: () => Get.back(),
                        )
                      ],
                    ),
                    SizedBox(height: sp8),
                    RichText(
                      text: TextSpan(
                          text: 'Chọn lô hàng từ sản phẩm',
                          style: AppTypography.p9
                              .copyWith(color: AppColors.greyColor),
                          children: [
                            TextSpan(
                                text: ' ${widget.data['product'].formula_name}',
                                style: AppTypography.p9
                                    .copyWith(color: AppColors.accentColor_5))
                          ]),
                    ),
                    SizedBox(height: sp16),
                    _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : _createExportOrderController
                                .listConsigmentSussgest.isEmpty
                            ? Center(
                              child: Column(
                                  children: [
                                    const Icon(
                                      Icons.hourglass_empty,
                                    ),
                                    SizedBox(height: sp8),
                                    Text('Sản phẩm hiện tại chưa có lô !', style: AppTypography.p5,)
                                  ],
                                ),
                            )
                            : Column(
                                children: _createExportOrderController
                                    .listConsigmentSussgest
                                    .map((item) => ConsignmentCard(
                                          data: item,
                                          select: _selectConsignment,
                                        ))
                                    .toList(),
                              ),
                  ]
                : [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Xuất sản phẩm vào lô hàng',
                          style: AppTypography.p3,
                        ),
                        InkWell(
                          child: Icon(
                            Icons.close,
                            size: sp16,
                          ),
                          onTap: () => Get.back(),
                        )
                      ],
                    ),
                    SizedBox(height: sp8),
                    RichText(
                      text: TextSpan(
                        text: 'Đang xuất sản phẩm từ lô ',
                        style: AppTypography.p9
                            .copyWith(color: AppColors.greyColor),
                        children: [
                          TextSpan(
                              text: _consignmentSelect!.consignment_code,
                              style: AppTypography.p9
                                  .copyWith(color: AppColors.accentColor_5))
                        ],
                      ),
                    ),
                    SizedBox(height: sp8),
                    buildRowItem(
                        title: 'Số thùng xuất',
                        content:
                            '${(widget.data['product'] as OrderProductModel).amount}'),
                    SizedBox(height: sp8),
                    buildRowItem(
                        title: 'Đơn giá xuất ( VNĐ / Gói )',
                        content:
                            '${FormatCurrency((widget.data['product'] as OrderProductModel).formula_price)} VNĐ'),
                    SizedBox(height: sp16),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: sp8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(sp8),
                        color: AppColors.green_2,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.check,
                              color: AppColors.green_1,
                            ),
                            SizedBox(width: sp8),
                            Text(
                              'Lô hàng này đáp ứng đề xuất',
                              style: AppTypography.p5
                                  .copyWith(color: AppColors.green_1),
                            )
                          ]),
                    ),
                    SizedBox(height: sp16),
                    buildRowItem(
                        title: 'Tổng giá trị xuất',
                        content:
                            '${FormatCurrency(((widget.data['product'] as OrderProductModel).formula_price)! * ((widget.data['product'] as OrderProductModel).amount!.toInt()))} VNĐ'),
                    SizedBox(height: sp16),
                    Row(
                      children: [
                        Expanded(
                          child: Extrabutton(
                            title: 'Quay lại',
                            event: () {
                              setState(() {
                                _step = 1;
                              });
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
                              _confirmConsignment();
                            },
                            largeButton: true,
                            icon: null,
                          ),
                        )
                      ],
                    )
                  ],
          ),
        ),
      ),
    );
  }

  void _getDataConsigment() {
    var warehouse =
        jsonDecode(AppSharedPreference.instance.getValue(PrefKeys.WAREHOUSE));
    var payload = {
      "amount_type_code": "BIN",
      "warehouse_code": warehouse['warehouse_code'],
      "source_type_code": "FORMULA",
      "custom_id": (widget.data['product'] as OrderProductModel).formula_id
    };
    _createExportOrderController.suggestConsigment(payload).then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _selectConsignment(ConsignmentModel value) {
    setState(() {
      _step = 2;
      _consignmentSelect = value;
    });
  }

  void _confirmConsignment() {
    _createExportOrderController.updateConsignment(_consignmentSelect!,
        (widget.data['product'] as OrderProductModel).formula_id!);
    Get.back();
  }
}
