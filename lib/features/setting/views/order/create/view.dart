import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/util/enum/status_type_order.dart';
import '/common/base/base_appBar.dart';
import '/common/base/base_button.dart';
import '/common/base/base_container.dart';
import '../../../../../common/constants/app_colors.dart';
import '../../../../../common/constants/app_size_device.dart';
import '../../../../../common/constants/app_spacing.dart';
import '../../../../../common/constants/app_typography.dart';
import '/features/setting/views/order/create/controller.dart';

class CreateTypeOrder extends StatefulWidget {
  const CreateTypeOrder({super.key});

  @override
  State<CreateTypeOrder> createState() => _CreateTypeOrderState();
}

class _CreateTypeOrderState extends State<CreateTypeOrder> {
  final CreateTypeOrderController _controller =
      Get.put(CreateTypeOrderController());
  TextEditingController? type_name;
  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller.getTypeList();
    type_name = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    type_name!.dispose();
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
        child: GetBuilder<CreateTypeOrderController>(
          builder: (controller) => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  itemBuilder: (context, index) => BaseContainer(
                    context,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${controller.listType[index].type_name}',
                                style: AppTypography.p3,
                              ),
                              const SizedBox(
                                height: sp12,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Mã: ',
                                  style: AppTypography.p9
                                      .copyWith(color: AppColors.greyColor),
                                  children: [
                                    TextSpan(
                                      text:
                                          '${controller.listType[index].type_code}',
                                      style: AppTypography.p9.copyWith(
                                        color: AppColors.blackColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: sp8),
                        if (controller.listType[index].isUse! ==
                            StatusTypeUse.USE)
                          Extrabutton(
                            title: 'Huỷ',
                            event: () {},
                            largeButton: false,
                            borderColor: AppColors.borderColor_2,
                            icon: null,
                          )
                        else if (controller.listType[index].isUse! ==
                            StatusTypeUse.NONE)
                          Expanded(
                            flex: 2,
                            child: MainButton(
                              title: 'Dùng',
                              event: () {
                                controller
                                    .useTypePressed(controller.listType[index]);
                              },
                              largeButton: false,
                              icon: null,
                            ),
                          )
                        else
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                      ],
                    ),
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: sp16,
                  ),
                  itemCount: controller.listType.length,
                ),
        ),
      ),
    );
  }
}
