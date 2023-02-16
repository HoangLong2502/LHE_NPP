// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '/common/base/base_button.dart';
// import '/common/base/base_input.dart';
// import '/components/card/order.dart';
// import '/components/filter/filter_button.dart';
// import '/constants/app_colors.dart';
// import '/constants/app_size_device.dart';
// import '/constants/app_spacing.dart';
// import '/features/order/models/index.dart';
// import '/features/order/views/index_controller.dart';
// import '/common/routes/app_routes.dart';

// class OrderNPP extends StatefulWidget {
//   const OrderNPP({super.key});

//   @override
//   State<OrderNPP> createState() => _OrderNPPState();
// }

// class _OrderNPPState extends State<OrderNPP> {
//   final _orderController = Get.put(OrderController());

//   bool isLoading = true;

//   final List<Map<String, dynamic>> _listFilter = [
//     {'title': 'Tất cả', 'value': 'all'},
//     {'title': 'Thành công', 'value': 'Thành công'},
//     {'title': 'Thất bại', 'value': 'Thất bại'},
//     {'title': 'Chờ phê duyệt', 'value': 'Chờ phê duyệt'}
//   ];

//   String _selectFilter = 'all';

//   void _handleSelectFilter(value) {
//     setState(() {
//       _selectFilter = value;
//     });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     Map<String, dynamic> payload = {
//       "page": "0",
//       "page_size": "10",
//       "system_key": "NPP",
//       "account_from": "1",
//     };

//     _orderController.getAll(payload).then((value) {
//       setState(() {
//         isLoading = false;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: heightDevice(context) - 260,
//       child: isLoading
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : SingleChildScrollView(
//               child: Container(
//                 child: Column(
//                   children: [
//                     AppInput(
//                       label: '',
//                       hintText: 'Tìm kiếm đơn hàng',
//                       controller: TextEditingController(),
//                       context: context,
//                       show: true,
//                       isPassword: false,
//                       textInputType: TextInputType.text,
//                       suffixIcon: Icon(Icons.mic),
//                       validate: () {},
//                     ),
//                     SizedBox(height: sp24),
//                     FilterButton(
//                         _listFilter, _selectFilter, _handleSelectFilter),
//                     SizedBox(height: sp16),
//                     GetBuilder<OrderController>(
//                       builder: (controller) => Column(
//                         children: _orderController.listOrders
//                             .map((order) => buildOrderCard(order))
//                             .toList(),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }

//   Widget buildOrderCard(OrderModel order) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: sp8),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(sp8),
//         border: Border.all(color: AppColors.borderColor_4),
//         color: AppColors.whiteColor,
//       ),
//       child: Column(
//         children: [
//           // order card
//           OrderCard(order: order, goToDetail: false,),
//           const Divider(
//             color: AppColors.borderColor_4,
//             height: 1,
//           ),
//           Container(
//             width: double.infinity,
//             padding: EdgeInsets.all(sp16),
//             decoration: BoxDecoration(
//               color: AppColors.bg_4,
//               borderRadius: BorderRadius.vertical(
//                 top: Radius.circular(0),
//                 bottom: Radius.circular(sp8),
//               ),
//             ),
//             child: Extrabutton(
//                 title: 'Xem chi tiết',
//                 event: () {
//                   Get.toNamed(Routes.routeOrderDetail, arguments: order);
//                 },
//                 largeButton: true,
//                 borderColor: AppColors.borderColor_2,
//                 icon: null,
//                 bgColor: AppColors.whiteColor),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class OrderCHTH extends StatelessWidget {
//   const OrderCHTH({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
