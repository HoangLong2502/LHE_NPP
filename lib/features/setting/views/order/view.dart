import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhe_npp/features/setting/views/order/update/controller.dart';
import '/common/base/base_appBar.dart';
import '/common/base/base_button.dart';
import '/common/base/base_container.dart';
import '/common/routes/app_routes.dart';
import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/app_size_device.dart';
import '../../../../common/constants/app_spacing.dart';
import '../../../../common/constants/app_typography.dart';
import '/features/setting/views/order/controller.dart';

class SettingOrderView extends StatefulWidget {
  const SettingOrderView({super.key});

  @override
  State<SettingOrderView> createState() => _SettingOrderViewState();
}

class _SettingOrderViewState extends State<SettingOrderView> {
  final _settingOrderController = Get.put(SettingOrderController());
  final _updateTypeOrderController = Get.put(UpdateTypeOrderController());

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _settingOrderController.getTypeList().then((value) {
      setState(() {
        _isLoading = !_isLoading;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar('Danh sách luồng'),
      body: Container(
        color: AppColors.bg_4,
        width: widthDevice(context),
        height: heightDevice(context),
        padding: const EdgeInsets.symmetric(vertical: sp24, horizontal: sp16),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: MainButton(
                        title: 'Thêm luồng mới',
                        event: () {
                          Get.toNamed(Routes.routeCreateSettingOrder);
                        },
                        largeButton: true,
                        icon: const Icon(
                          Icons.add_circle_outline,
                          size: sp16,
                        ),
                      ),
                    ),
                    const SizedBox(height: sp16),
                    _settingOrderController.listType.isEmpty
                        ? const Center(
                            child: Text(
                              'Chưa có luồng đơn được sử dụng',
                              style: AppTypography.p5,
                            ),
                          )
                        : Column(
                            children: _settingOrderController.listType
                                .map(
                                  (item) => InkWell(
                                    onTap: () {
                                      _updateTypeOrderController.updateTypeId(item.id!);
                                      Get.toNamed(Routes.routeUpdateSettingOrder);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: sp8),
                                      child: BaseContainer(
                                        context,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: widthDevice(context) / 2,
                                              child: ListTile(
                                                minVerticalPadding: 0,
                                                contentPadding:
                                                    const EdgeInsets.all(0),
                                                title: Text(
                                                  item.type_name!,
                                                  style: AppTypography.p3,
                                                ),
                                                subtitle: Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: sp8),
                                                  child: Text(
                                                    '${item.type_code!.split('#').length} bước',
                                                    style:
                                                        AppTypography.p6.copyWith(
                                                      color: AppColors.greyColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            PopupMenuButton(
                                              icon: const Icon(
                                                Icons.more_vert,
                                                color: AppColors.greyColor,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(sp8)),
                                              itemBuilder: (context) => [
                                                const PopupMenuItem(
                                                  child: Text(
                                                    'Đổi tên luồng',
                                                    style: AppTypography.p5,
                                                  ),
                                                ),
                                                const PopupMenuItem(
                                                  child: Text(
                                                    'Xóa danh mục',
                                                    style: AppTypography.p5,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                  ],
                ),
              ),
      ),
    );
  }
}
