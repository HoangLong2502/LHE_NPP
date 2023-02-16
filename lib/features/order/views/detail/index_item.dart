import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/base/base_button.dart';
import '../../../../common/base/base_input.dart';
import '../../../../common/util/enum/status_noti.dart';
import '../../../../common/util/event.dart';
import '../../../../components/notification/index.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_size_device.dart';
import '../../../../constants/app_spacing.dart';
import '../../../../constants/app_typography.dart';
import '../../models/order_product.dart';
import 'index_controller.dart';

class ListProductOrderCanEdit extends StatelessWidget {
  const ListProductOrderCanEdit(
      {required this.listProduct,
      super.key});

  final List listProduct;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: listProduct
          .map((product) => Padding(
                padding: EdgeInsets.symmetric(vertical: sp8),
                child: buildOrderProductItem(context, product),
              ))
          .toList(),
    );
  }

  Widget buildOrderProductItem(
      BuildContext context, OrderProductModel product) {
    final orderDetailController = Get.put(OrderDetailController());
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor_4),
        borderRadius: BorderRadius.circular(sp8),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(sp16),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(sp8),
                bottom: Radius.circular(orderDetailController.order.status_id != 1 ? sp8 : 0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 48,
                      height: 48,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(sp8),
                        child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppColors.borderColor_4),
                              borderRadius: BorderRadius.circular(sp8)),
                          child: Image.network(
                            'https://thachlonghai.com.vn/FileManager/Thachlonghai/Sanpham/Thach_Rau_Cau/Thach_tui_910g/Thach-rau-cau-Long-Hai-Thach-Long-Hai-Thach-rau-cau-hoa-qua-tui-910g%20(1).jpg',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: sp8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 250,
                          child: Text(
                            product.formula_name.toString(),
                            style: AppTypography.p3,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: sp4),
                        Text(
                          'Số lượng: ${product.amount} thùng',
                          style: AppTypography.p6,
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: sp16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Đơn giá', style: AppTypography.p6),
                    Text(
                      '${FormatCurrency(product.formula_price)} VNĐ',
                      style: AppTypography.h6.copyWith(
                        color: AppColors.mainColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: sp8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Đơn giá', style: AppTypography.p6),
                    Text(
                      '${FormatCurrency(product.formula_price! * int.parse(product.amount.toString()))} VNĐ',
                      style: AppTypography.h6.copyWith(
                        color: AppColors.mainColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          if (orderDetailController.order.status_id == 1) const Divider(
            height: 1,
            color: AppColors.borderColor_4,
          ),
          if (orderDetailController.order.status_id == 1) Container(
            padding: EdgeInsets.all(sp16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(sp8),
                top: const Radius.circular(0),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Extrabutton(
                    title: 'Điều chỉnh số lượng',
                    event: () {
                      showDialog(
                        context: context,
                        builder: (context) => Center(
                            child: ModalEdit(
                                id: product.id, amount: product.amount)),
                      );
                    },
                    largeButton: true,
                    borderColor: AppColors.borderColor_4,
                    icon: null,
                    bgColor: AppColors.whiteColor,
                  ),
                ),
                SizedBox(width: sp16),
                SizedBox(
                  width: 45,
                  height: 45,
                  child: Extrabutton(
                    title: null,
                    event: () {
                      showDialog(
                        context: context,
                        builder: (context) => Center(
                          child: buildNoti(
                            context,
                            () {
                              orderDetailController.deleteProduct(product.id!);
                              Get.back();
                            }
                          ),
                        ),
                      );
                    },
                    largeButton: false,
                    borderColor: AppColors.borderColor_4,
                    icon: const Icon(
                      Icons.delete_outline,
                      size: 16,
                      color: AppColors.blackColor,
                    ),
                    bgColor: AppColors.whiteColor
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildNoti(BuildContext context, Function handleDelete) {
  return Card(
    child: SizedBox(
        width: widthDevice(context) - 32,
        child: PopNotification(context, 'Xác nhận xóa sản phẩm này?',
          handleDelete , StatusChat.ERROR)),
  );
}

class ModalEdit extends StatefulWidget {
  const ModalEdit({required this.id, required this.amount, super.key});

  final int? id;
  final int? amount;

  @override
  State<ModalEdit> createState() => _ModalEditState();
}

class _ModalEditState extends State<ModalEdit> {
  final _orderDetailController = Get.put(OrderDetailController());
  final _edit = TextEditingController();
  final FocusNode _editFn = new FocusNode();
  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _editFn.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: widthDevice(context) - 32, maxHeight: 300),
        child: Container(
          padding: EdgeInsets.all(sp16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(sp16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Điều chỉnh số lượng', style: AppTypography.h6),
              SizedBox(height: sp16),
              RichText(
                text: TextSpan(
                  text: 'Số lượng hiện tại: ',
                  style: AppTypography.p6.copyWith(color: AppColors.blackColor),
                  children: [
                    TextSpan(
                        text: '${widget.amount.toString()} Thùng',
                        style: AppTypography.h6),
                  ],
                ),
              ),
              SizedBox(height: sp16),
              Form(
                key: _key,
                child: AppInput(
                  label: 'Số lượng mới',
                  hintText: 'Nhập số lượng mới',
                  controller: _edit,
                  context: context,
                  show: true,
                  isPassword: false,
                  textInputType: TextInputType.number,
                  suffixIcon: null,
                  validate: (value) {
                    if (value == '') {
                      return 'Trường này không được bỏ trống';
                    }
                  },
                  fn: _editFn,
                ),
              ),
              SizedBox(height: sp24),
              Row(
                children: [
                  Expanded(
                    flex: 1,
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
                    flex: 1,
                    child: MainButton(
                      title: 'Xác nhận',
                      event: () {
                        var err = _key.currentState!.validate();
                        if (!err) {
                          return;
                        }

                        _orderDetailController.updateAmountProduct(
                          int.parse(widget.id.toString()),
                          int.parse(_edit.text.toString()),
                        );

                        Get.back();
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
      ),
    );
  }
}
