import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lhe_npp/common/util/enum/type_ticket.dart';

import '/common/base/base_button.dart';
import '/common/util/api.dart';
import '/components/card/order.dart';
import '/components/filter/filter_button.dart';
import '/components/infinite_scroll/event.dart';
import '/constants/app_colors.dart';
import '/constants/app_size_device.dart';
import '/constants/app_spacing.dart';
import '/constants/constans.dart';
import '/features/order/models/index.dart';
import '/features/order/views/index_controller.dart';
import '/local%20storage/app_shared_preference.dart';

class ExportOrderView extends StatefulWidget {
  const ExportOrderView({super.key});

  @override
  State<ExportOrderView> createState() => _ExportOrderViewState();
}

class _ExportOrderViewState extends State<ExportOrderView> {
  final _controller = Get.put(OrderController());
  final _pagingController = PagingController<int, dynamic>(firstPageKey: 0);

  final _listFilter = [
    {
      'title': 'Tất cả',
      'value': 'all',
    },
    {
      'title': 'Chờ phê duyệt',
      'value': 'CPD',
    },
    {
      'title': 'Thành công',
      'value': 'TC',
    },
    {
      'title': 'Thất bại',
      'value': 'TB',
    }
  ];

  String _selectFilter = 'all';

  _handleSelectFilter(value) {
    setState(() {
      _selectFilter = value;
    });
  }

  Future<List<OrderModel>> _getData(int page) async {
    var account =
        jsonDecode(AppSharedPreference.instance.getValue(PrefKeys.USER));
    var payload = {
      "customer_id": 2,
      "page": page.toString(),
      "page_size": "10",
      "system_key": Api.KEY
    };
    var res = await _controller.getAll(payload);
    return res;
  }

  @override
  void initState() {
    super.initState();  

    _pagingController.addPageRequestListener(
      (pageKey) {
        fetchPage(
          pagingController: _pagingController,
          pageSize: 10,
          fetchData: _getData,
          pageKey: pageKey,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightDevice(context),
      width: widthDevice(context),
      color: AppColors.bg_4,
      padding: EdgeInsets.all(sp16),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: MainButton(
              title: 'Tạo đơn xuất hàng mới',
              event: () {},
              largeButton: true,
              icon: const Icon(
                Icons.add_circle_outline,
                size: 16,
              ),
            ),
          ),
          SizedBox(height: sp16),
          FilterButton(_listFilter, _selectFilter, _handleSelectFilter),
          SizedBox(height: sp16),
          SizedBox(
            height: heightDevice(context) - 300,
            width: widthDevice(context),
            child: PagedListView.separated(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<dynamic>(
                itemBuilder: (context, item, index) => OrderCard(order: item, goToDetail: true, type: TYPE_TICKET.EXPORT,),
              ),
              separatorBuilder: (context, index) => SizedBox(height: sp16),
            ),
          ),
        ],
      ),
    );
  }
}
