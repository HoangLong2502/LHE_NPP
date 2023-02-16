import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_typography.dart';
import 'index_controller.dart';
import 'index_item/historyOrder.dart';
import 'index_item/profile.dart';

class DetailNPPView extends StatefulWidget {
  const DetailNPPView({super.key});

  @override
  State<DetailNPPView> createState() => _DetailNPPViewState();
}

class _DetailNPPViewState extends State<DetailNPPView> {
  final DetailNPPController _controller = Get.put(DetailNPPController());

  final List<Map<String, dynamic>> _tabsTitle = [
    {
      'title': 'Hồ sơ',
      'page': Profile()
    },
    {
      'title': 'Ngân hàng',
      'page': HistoryOrder(),
    },
    {
      'title': 'Địa chỉ',
      'page': Profile()
    },
    {
      'title': 'Lịch sử đơn',
      'page': HistoryOrder(),
    },
    {
      'title': 'Hợp đồng',
      'page': Profile()
    },
    {
      'title': 'Thông tin kho',
      'page': Profile()
    }
  ];

  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isLoading == true) {
      final data = ModalRoute.of(context)!.settings.arguments;
      _controller.updateDataProfile(data);
      print(_controller.dataProfile['fullname']);

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: _tabsTitle.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chi tiết nhà phân phối'),
          bottom: TabBar(
              indicatorColor: AppColors.mainColor,
              labelStyle: AppTypography.p5,
              labelColor: AppColors.mainColor,
              unselectedLabelColor: AppColors.greyColor,
              isScrollable: true,
              tabs: _tabsTitle
                  .map((e) => Tab(
                        text: '${e['title']}',
                      ))
                  .toList()),
        ),
        body: TabBarView(
          children: _tabsTitle
              .map(
                (e) => (e['page'] as Widget),
              )
              .toList(),
        ),
      ),
    );
  }
}
