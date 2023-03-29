import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../common/base/base_button.dart';
import '../../../../common/base/base_container.dart';
import '../../../../common/base/base_input.dart';
import '../../../../components/card/order/quantity.dart';
import '../../../../components/card/order/select.dart';
import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/app_size_device.dart';
import '../../../../common/constants/app_spacing.dart';
import '../../../../common/constants/app_typography.dart';
import '../../../../common/constants/assets_path.dart';
import 'controller.dart';

// Widget buildPurchaseOrderItem(
//   BuildContext context,
//   ProductOrderModel item,
//   Function changeQuantity,
//   Type type,
// ) {
//   return BaseContainer(
//     context,
//     Column(
//       children: [
//         Row(
//           children: [
//             Container(
//               width: sp48,
//               height: sp48,
//               decoration:
//                   BoxDecoration(borderRadius: BorderRadius.circular(sp8)),
//               child: Image.network(
//                 item.product!.image.toString(),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             SizedBox(width: sp16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     item.product!.name.toString(),
//                     style: AppTypography.p3,
//                   ),
//                   SizedBox(height: sp8),
//                   Text(
//                     '( 10 gói / 1 thùng )',
//                     style:
//                         AppTypography.p6.copyWith(color: AppColors.greyColor),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: sp16),
//         Container(
//           padding: EdgeInsets.symmetric(vertical: sp4, horizontal: sp8),
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(sp8),
//               color: AppColors.borderColor_1),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 '${'quantity'.tr} (${item.product!.unitQuantity})',
//                 style: AppTypography.p4,
//               ),
//               Container(
//                 width: 130,
//                 decoration: BoxDecoration(
//                     color: AppColors.whiteColor,
//                     borderRadius: BorderRadius.circular(sp8)),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         changeQuantity('minus', item.product!.id, type);
//                       },
//                       icon: Text('-'),
//                     ),
//                     Text(
//                       item.quantity.toString(),
//                       style: AppTypography.p4,
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         changeQuantity('plus', item.product!.id, type);
//                       },
//                       icon: Text('+'),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         )
//       ],
//     ),
//   );
// }

class PurchaseOrderItem {
  static Widget list(
    BuildContext context,
    Function selectProduct,
    PurchaseOrderController controller,
  ) {
    return Column(
      children: [
        SizedBox(
          width: widthDevice(context),
          child: MainButton(
            title: 'Chọn sản phẩm để nhập',
            event: () {
              selectProduct();
            },
            largeButton: true,
            icon: Icon(Icons.add_circle_outline, size: sp16),
          ),
        ),
        SizedBox(height: sp8),
        SizedBox(
          width: widthDevice(context),
          child: Column(
            children: controller.productAvailable
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: CardQuantityProduct(
                      context,
                      e,
                      () {
                        controller.changeQuantity('minus', e.id);
                      },
                      () {
                        controller.changeQuantity('plus', e.id);
                      },
                      controller.fieldQuantity,
                      controller.deleteProduct,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  static Widget emty(BuildContext context, Function selectProduct) {
    return BaseContainer(
      context,
      Column(
        children: [
          // SizedBox(
          //   width: 80,
          //   height: 96,
          //   child: SvgPicture.asset(
          //           '${AssetsPath.image}/order_assets/empty_2.svg'),
          // ),
          SizedBox(height: sp8),
          Text('Chưa chọn sản phẩm nào', style: AppTypography.p6),
          SizedBox(height: sp4),
          Text(
            'Chọn sản phẩm để đặt hàng',
            style: AppTypography.p6.copyWith(color: AppColors.greyColor),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: sp24),
          SizedBox(
            width: widthDevice(context),
            child: MainButton(
              title: 'Chọn sản phẩm',
              event: () {
                selectProduct();
              },
              largeButton: false,
              icon: Icon(Icons.add_circle_outline, size: sp16),
            ),
          )
        ],
      ),
    );
  }

  static popup(
    BuildContext context,
    TextEditingController search,
    PurchaseOrderController controller,
  ) {
    return Center(
      child: SizedBox(
        width: widthDevice(context) - sp32,
        child: Card(
          child: Container(
            padding: EdgeInsets.all(sp16),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Thêm sản phẩm', style: AppTypography.p3),
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.close, size: sp16))
                  ],
                ),
                Text('Vui lòng chọn sản phẩm để lấy hàng',
                    style:
                        AppTypography.p9.copyWith(color: AppColors.greyColor)),
                SizedBox(height: sp16),
                AppInput(
                  label: '',
                  hintText: 'Tìm kiếm sản phẩm',
                  controller: search,
                  context: context,
                  show: true,
                  isPassword: false,
                  textInputType: TextInputType.name,
                  suffixIcon: Icon(Icons.search),
                  validate: () {},
                ),
                SizedBox(height: sp16),
                SizedBox(
                  height: heightDevice(context) - 400,
                  width: widthDevice(context),
                  child: GetBuilder<PurchaseOrderController>(
                    builder: (controller) => ListView.separated(
                      separatorBuilder: (context, index) =>
                          SizedBox(height: sp16),
                      itemBuilder: (context, index) => CardSerlectProduct(
                        context,
                        controller.productOrder[index],
                        controller,
                      ),
                      itemCount: controller.productOrder.length,
                    ),
                  ),
                ),
                SizedBox(height: sp16),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: Extrabutton(
                          title: 'Đặt lại',
                          event: () {
                            controller.cleanProduct();
                            // Get.back();
                          },
                          largeButton: true,
                          borderColor: AppColors.borderColor_4,
                          icon: null,
                        ),
                      ),
                      SizedBox(width: sp16),
                      GetBuilder<PurchaseOrderController>(
                        builder: (controller) => Expanded(
                          child: MainButton(
                            title:
                                'Thêm (${controller.productAvailable.length})',
                            event: () {
                              Get.back();
                            },
                            largeButton: true,
                            icon: null,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
