// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lh_nvtt_fe/constants/app_colors.dart';
// import 'package:lh_nvtt_fe/constants/app_spacing.dart';
// import 'package:lh_nvtt_fe/constants/app_typography.dart';
// import 'package:lh_nvtt_fe/features/customer/model/customer_model.dart';
// import 'package:lh_nvtt_fe/routes/app_routes.dart';

// import '../../constants/app_size_device.dart';

// Widget CardCustomer(BuildContext context, CustomerModel data, bool edit) {
//   return Card(
//     color: AppColors.whiteColor,
//     elevation: 2,
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(sp8)),
//     child: InkWell(
//       onTap: () => Get.toNamed(routes.routeCustomerDetail, arguments: data),
//       child: Container(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: double.infinity,
//               padding: EdgeInsets.all(sp16),
//               decoration: BoxDecoration(
//                   border: Border(
//                       bottom: BorderSide(color: AppColors.borderColor_4))),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(data.name.toString(), style: AppTypography.p3),
//                   SizedBox(height: sp8),
//                   Text('Cửa hàng tạp hóa',
//                       style:
//                           AppTypography.p3.copyWith(color: AppColors.mainColor))
//                 ],
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.only(top: sp16, right: sp16, left: sp16),
//               child: Column(
//                 children: [
//                   CardCustomerItemRow(
//                       context, Icons.phone_sharp, data.phone.toString()),
//                   CardCustomerItemRow(context, Icons.location_on_sharp,
//                       data.address.toString()),
//                   CardCustomerItemRow(
//                       context,
//                       Icons.note_sharp,
//                       data.note == ''
//                           ? 'Không có ghi chú'
//                           : data.note.toString()),
//                 ],
//               ),
//             ),
//             if (edit)
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: sp16, vertical: sp8),
//                 width: double.infinity,
//                 child: OutlinedButton(
//                   style: OutlinedButton.styleFrom(
//                       padding: EdgeInsets.symmetric(vertical: sp12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(sp8),
//                       )),
//                   onPressed: () {},
//                   child: Text(
//                     'Sửa thông tin',
//                     style:
//                         AppTypography.p5.copyWith(color: AppColors.blackColor),
//                   ),
//                 ),
//               )
//           ],
//         ),
//       ),
//     ),
//   );
// }

// Widget CardCustomerItemRow(BuildContext context, IconData icon, String title) {
//   return Container(
//     padding: EdgeInsets.only(bottom: sp16),
//     child: Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Icon(
//           icon,
//           color: AppColors.greyColor,
//           size: sp16,
//         ),
//         SizedBox(width: sp12),
//         Container(
//           width: widthDevice(context) - 16 * 4 - 36,
//           // width: MediaQuery.of(context).size.width - ,
//           child: Text(
//             '$title',
//             style: AppTypography.p3.copyWith(color: AppColors.greyColor),
//             softWrap: true,
//           ),
//         )
//       ],
//     ),
//   );
// }
