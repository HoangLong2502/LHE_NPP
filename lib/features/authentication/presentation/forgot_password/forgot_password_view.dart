import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/app_size_device.dart';
import '../../../../constants/app_spacing.dart';
import 'forgot_password_controller.dart';
import 'forgot_password_item.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _forgotPasswordController = Get.put(ForgotPasswordController());

  final List<Map<String, dynamic>> stepForgot = [
    {'step': 1, 'title': "Xác thực thông tin",},
    {'step': 2, 'title': "Tạo mật khẩu mới"},
    {'step': 3, 'title': "Hoàn thành"},
  ];

  final _keyFormStep1 = GlobalKey<FormState>();
  final _keyFormStep2 = GlobalKey<FormState>();
  

  TextEditingController email = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    _forgotPasswordController.changeStep(value: 1.obs);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> stepForgotContent = [
      buildStep1(context, _keyFormStep1 ,email),
      buildStep2(context, _keyFormStep2, email),
      buildStep3(context)
    ];
    return Scaffold(
        appBar: AppBar(
          title: Text('forgot password'.tr),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: Spacing.p1,
            child: Column(
              children: [
                GetBuilder<ForgotPasswordController>(
                  builder: (controller) {
                    return Stack(children: [
                      Positioned(
                        top: 20,
                        child: Container(
                          width: widthDevice(context) - sp32*2,
                          height: 1,
                          padding: EdgeInsets.symmetric(horizontal: sp32),
                          // color: AppColors.borderColor_1,
                          child: Divider(),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // children: ListView.builder(itemBuilder:(context, index) {
                        //   return Expanded(child: buildStepCircle(index, stepForgot[index]));
                        // }, itemCount: stepForgot.length,)
                        children: stepForgot.map((value) {
                          return Container(
                            child: buildStepCircle(
                              value['step'],
                              value['title'],
                              controller.step.value == value['step']
                                  ? true
                                  : false,
                            ),
                          );
                        }).toList(),
                      ),
                    ]);
                  },
                ),
                SizedBox(height: sp32),
                GetBuilder<ForgotPasswordController>(builder:(controller) {
                  return stepForgotContent[controller.step.value - 1];
                },)
              ],
            ),
          ),
        ));
  }
}
