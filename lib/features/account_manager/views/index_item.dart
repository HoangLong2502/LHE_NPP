import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../common/base/base_button.dart';
import '../../../common/routes/app_routes.dart';
import '../../../components/filter/filter_button.dart';
import '../../../components/infinite_scroll/event.dart';
import '../../../components/infinite_scroll/index.dart';
import '../../../constants/app_size_device.dart';
import '../../../constants/app_spacing.dart';
import '../apis/user.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _userService = UserService();

  final _pagingController = PagingController<int, dynamic>(firstPageKey: 1);
  
  final _listFilterButton = [
    {'title': 'Tất cả', 'value': 'all'},
    {'title': 'Quản lý tổng', 'value': 'AD'},
    {'title': 'Nhà phân phối', 'value': 'NPP'},
    {'title': 'Nhân viên thị trường', 'value': 'NVTT'},
    {'title': 'Kế toán', 'value': 'KT'},
    {'title': 'Quản lý kho', 'value': 'KH'},
    {'title': 'Cửa hàng tạp hoá', 'value': 'CHTH'},
  ];

  String _selectFilter = 'all';

  void _handleSelectFilter(value) {
    setState(() {
      _selectFilter = value;
    });

    _pagingController.refresh();
  }

  Future<List> _getAll(int page) async {
    var res = await _userService.getAllUser(page);
    return res;
  }

  Future<List> _getByKey(int page) async {
    var res = await _userService.getUserByKey(page, _selectFilter);
    return res;
  }

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener((pageKey) {
      fetchPage(
        pagingController: _pagingController,
        pageSize: 5,
        fetchData: _selectFilter == 'all' ? _getAll : _getByKey,
        pageKey: pageKey,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: MainButton(
            title: 'Thêm mới người dùng',
            event: () => Get.toNamed(Routes.routeTypeCreateUser),
            largeButton: true,
            icon: Icon(
              Icons.add_circle_outline,
              size: sp16,
            ),
          ),
        ),
        SizedBox(height: sp16),
        FilterButton(_listFilterButton, _selectFilter, _handleSelectFilter),
        SizedBox(height: sp16),
        SizedBox(
          height: heightDevice(context) - 380,
          width: widthDevice(context),
          child: PagingView(pagingController: _pagingController),
        )
      ],
    );
  }
}
