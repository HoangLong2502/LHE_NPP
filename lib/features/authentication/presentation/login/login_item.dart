import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/base/base_button.dart';
import '../../../../common/base/base_input.dart';
import '../../../../common/util/enum/status_noti.dart';
import '../../../../components/notification/index.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_spacing.dart';
import '../../../../constants/app_typography.dart';
import '../../../../constants/constans.dart';
import '../../../../local storage/app_shared_preference.dart';
import '../../../../common/util/event.dart';
import 'login_controller.dart';

Widget buildFormLogin(
  BuildContext context,
  GlobalKey key,
  TextEditingController username,
  TextEditingController password,
) {
  return Form(
    key: key,
    child: Column(
      children: [
        AppInput(
          label: 'Tên đăng nhập'.tr,
          hintText: 'Điền tên đăng nhập'.tr,
          controller: username,
          context: context,
          show: true,
          isPassword: false,
          textInputType: TextInputType.emailAddress,
          suffixIcon: null,
          validate: (String value) {
            if (value.isEmpty) {
              return 'Bạn cần hoàn thiện trường thông tin này';
            }
            // else if (!isValidEmail(value)) {
            //   return 'Bạn cần điền đúng định dạng email';
            // }
          },
          maxLines: 1,
        ),
        SizedBox(height: 16),
        GetBuilder<LoginController>(builder: (controller) {
          return AppInput(
            label: 'Mật khẩu'.tr,
            hintText: 'Nhập mật khẩu'.tr,
            controller: password,
            context: context,
            show: controller.showPassword.value,
            isPassword: true,
            textInputType: TextInputType.text,
            suffixIcon: IconButton(
              icon: Icon(
                controller.showPassword.value
                    ? Icons.visibility
                    : Icons.visibility_off_outlined,
              ),
              onPressed: () {
                controller.changeShowPassword(
                    value:
                        controller.showPassword.value ? false.obs : true.obs);
              },
            ),
            validate: (String value) {
              if (value.isEmpty) {
                return 'Bạn cần hoàn thiện trường thông tin này';
              }
            },
            maxLines: 1,
          );
        })
      ],
    ),
  );
}

Widget buildLoginButton(BuildContext context, GlobalKey<FormState> key) {
  final loginController = Get.put(LoginController());
  return StatefulBuilder(
    builder: (context, setState) => SizedBox(
      width: double.infinity,
      child: MainButton(
        title: 'Đăng nhập'.tr,
        event: () {
          if (checkValidate(key)) {
            showDialog(
              context: context,
              builder: (context) => Center(
                child:
                    PopNotification(context, 'Vui lòng đợi', () {}, StatusChat.LOADING),
              ),
            );
            loginController.handleLogin().then(
                  (value) => {
                    if (AppSharedPreference.instance.getValue(PrefKeys.TOKEN) ==
                        null)
                      {
                        Get.back(),
                        showDialog(
                          context: context,
                          builder: (context) => Center(
                            child: PopNotification(
                                context, 'Đăng nhập thất bại', null, StatusChat.ERROR),
                          ),
                        ),
                      }
                  },
                );
          }
        },
        largeButton: true,
        icon: null,
      ),
    ),
  );
}

Widget buildMoreActionLogin() {
  final _loginController = Get.put(LoginController());
  return Container(
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 24,
                width: 24,
                child: GetBuilder<LoginController>(
                  builder: (controller) {
                    return Checkbox(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2)),
                      value: _loginController.rememberPassword.value,
                      onChanged: (value) {
                        if (value != null) {
                          _loginController.changeRememberPassword(
                            value: value ? true.obs : false.obs,
                          );
                        }
                      },
                    );
                  },
                ),
              ),
              SizedBox(width: 8),
              Text(
                'Lưu tài khoản'.tr,
                style: AppTypography.p4.copyWith(color: AppColors.greyColor),
              ),
            ],
          ),
        ),
        Container(
          height: 24,
          child: TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(sp0),
            ),
            onPressed: () {
              Get.toNamed('/forgot_password');
            },
            child: Text(
              'Quên mật khẩu'.tr,
              style: AppTypography.p4.copyWith(color: AppColors.greyColor),
            ),
          ),
        ),
      ],
    ),
  );
}
