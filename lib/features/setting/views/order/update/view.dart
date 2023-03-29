import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhe_npp/common/base/base_container.dart';
import 'package:lhe_npp/features/setting/views/order/update/item.dart';
import '../../../../../common/constants/constans.dart';
import '../../../../../local storage/app_shared_preference.dart';
import '/common/base/base_appBar.dart';
import '/common/base/base_button.dart';
import '../../../../../common/constants/app_colors.dart';
import '../../../../../common/constants/app_size_device.dart';
import '../../../../../common/constants/app_spacing.dart';
import '../../../../../common/constants/app_typography.dart';
import '/features/setting/views/order/update/controller.dart';

class UpdateTypeOrder extends StatefulWidget {
  const UpdateTypeOrder({super.key});

  @override
  State<UpdateTypeOrder> createState() => _UpdateTypeOrderState();
}

class _UpdateTypeOrderState extends State<UpdateTypeOrder> {
  final UpdateTypeOrderController _controller =
      Get.put(UpdateTypeOrderController());
  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller.typeDetailForUser();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar('Cài đặt luồng đơn'),
      body: Container(
        height: heightDevice(context),
        width: widthDevice(context),
        color: AppColors.bg_4,
        padding: const EdgeInsets.all(sp16),
        child: SingleChildScrollView(
          child: Form(
            key: _keyForm,
            child: GetBuilder<UpdateTypeOrderController>(
              builder: (controller) => controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        BaseContainer(
                          context,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tên luồng',
                                style: AppTypography.p6
                                    .copyWith(color: AppColors.greyColor),
                              ),
                              const SizedBox(height: sp12),
                              Text(
                                _controller.typeDetail.type_name,
                                style: AppTypography.p5
                                    .copyWith(color: AppColors.blackColor),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: sp24),
                        Column(
                          children: [
                            Text(
                              'Bắt đầu',
                              style: AppTypography.p3
                                  .copyWith(color: AppColors.greyColor),
                            ),
                            const SizedBox(height: sp16),
                            GetBuilder<UpdateTypeOrderController>(
                              builder: (controller) => ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) =>
                                    UpdateTypeOrderItem().stepItem(
                                  context,
                                  controller,
                                  _controller.listStep[index],
                                ),
                                separatorBuilder: (context, index) => Center(
                                  child: Container(
                                    height: sp24,
                                    width: 1,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: sp8),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          color: AppColors.borderColor_4,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                itemCount: _controller.listStep.length,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors.whiteColor,
        width: widthDevice(context),
        padding: const EdgeInsets.all(sp16),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Extrabutton(
                title: 'Huỷ bỏ',
                event: () {},
                largeButton: true,
                borderColor: AppColors.borderColor_4,
                icon: null,
              ),
            ),
            const SizedBox(width: sp12),
            Expanded(
              flex: 1,
              child: MainButton(
                title: 'Lưu lại',
                event: () {
                  _handleCreateTypeOrder();
                },
                largeButton: true,
                icon: null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleCreateTypeOrder() {
    final validate = _keyForm.currentState!.validate();
    if (!validate) return;
    _controller.showBeforeEvent(context);
    var account =
        jsonDecode(AppSharedPreference.instance.getValue(PrefKeys.USER));
    var payload = {
      "type_name": _controller.typeDetail.type_name,
      "type_code": _controller.typeDetail.type_code,
      "user_id": account['id'],
      "room_system": _controller.listStep
          .map((item) => {
                "system_key": item.system_key,
                "room_to": item.type_rules_room!['value'],
              })
          .toList(),
    };

    print(payload);

    _controller.createTypeOrder(payload).then((value) {
      print(value);
      Get.back();
      _controller.showAffterEvent(context, !value['isErr']);
    });
  }
}
