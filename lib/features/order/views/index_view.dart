import 'package:flutter/material.dart';

import 'package:lhe_npp/common/constants/app_colors.dart';
import 'package:lhe_npp/features/order/views/index_item/export.dart';
import 'package:lhe_npp/features/order/views/index_item/import.dart';

enum TYPE { NPP, CHTH }

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  final List<Map<String, dynamic>> _tabList = [
    {'title': 'Nhập hàng', 'page': const ImportOrderView()},
    {'title': 'Xuất hàng', 'page': const ExportOrderView()},
    {'title': 'Khiếu nại đổi trả', 'page': const Text('123')}
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabList.length,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Đơn hàng'),
          bottom: TabBar(
            isScrollable: false,
            labelPadding: const EdgeInsets.all(0),
            labelColor: AppColors.mainColor,
            unselectedLabelColor: AppColors.greyColor,
            indicatorColor: AppColors.mainColor,
            tabs: _tabList
                .map((e) => Tab(
                      text: e['title'],
                    ))
                .toList(),
          ),
        ),
        body: TabBarView(
          children: _tabList.map((e) => (e['page'] as Widget)).toList(),
        ),
        // bottomNavigationBar: buildBottomBar(context, 1, () {}),
      ),
    );
    // Column(
    //   children: [
    //     CupertinoSlidingSegmentedControl(
    //       groupValue: pageSelect,
    //       padding: EdgeInsets.all(sp8),
    //       backgroundColor: AppColors.whiteColor,
    //       thumbColor: AppColors.bg_4,
    //       children: {
    //         TYPE.NPP: Container(
    //           padding: EdgeInsets.symmetric(vertical: sp12),
    //           width: widthDevice(context) / 2,
    //           child: const Text(
    //             'Từ nhà phân phối',
    //             textAlign: TextAlign.center,
    //           ),
    //         ),
    //         TYPE.CHTH: Container(
    //           padding: EdgeInsets.symmetric(vertical: sp12),
    //           width: widthDevice(context) / 2,
    //           child: const Text(
    //             'Từ cửa hàng tạp hóa',
    //             textAlign: TextAlign.center,
    //           ),
    //         )
    //       },
    //       onValueChanged: (value) {
    //         setState(() {
    //           pageSelect = value!;
    //         });
    //       },
    //     ),
    //     pageSelect == TYPE.NPP ? const OrderNPP() : const OrderCHTH(),
    //   ],
    // );
  }
}
