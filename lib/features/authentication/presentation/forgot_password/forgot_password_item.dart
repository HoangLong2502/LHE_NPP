import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../common/base/base_button.dart';
import '../../../../common/base/base_input.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_spacing.dart';
import '../../../../constants/app_typography.dart';
import '../../../../constants/assets_path.dart';
import '../../../../common/util/event.dart';
import 'forgot_password_controller.dart';

Widget buildStepCircle(int index, String title, bool active) {
  final _forgotPasswordController = Get.put(ForgotPasswordController());
  return Container(
    width: 100,
    child: Column(
      children: [
        Container(
          width: 40,
          height: 40,
          padding: EdgeInsets.all(sp0),
          decoration: BoxDecoration(
              border: Border.all(
                width: active ? 0 : 1,
                color: !active ? AppColors.borderColor_2 : AppColors.whiteColor,
              ),
              borderRadius: BorderRadius.circular(50)),
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () => _forgotPasswordController.changeStep(value: index.obs),
            child: CircleAvatar(
              backgroundColor:
                  active ? AppColors.mainColor : AppColors.whiteColor,
              child: Center(
                  child: Text(
                '$index',
                style: active
                    ? AppTypography.h6.copyWith(color: AppColors.whiteColor)
                    : AppTypography.p6.copyWith(color: AppColors.greyColor),
              )),
            ),
          ),
        ),
        SizedBox(height: sp16),
        Container(
          width: 85,
          child: Text(
            '$title',
            textAlign: TextAlign.center,
            style: active
                ? AppTypography.h6.copyWith(color: AppColors.mainColor)
                : AppTypography.p6.copyWith(color: AppColors.greyColor),
          ),
        ),
      ],
    ),
  );
}

Widget buildStep1(BuildContext context, GlobalKey<FormState> keyForm,
    TextEditingController controller) {
  final _forgotPasswordController = Get.put(ForgotPasswordController());
  return Column(
    children: [
      Container(
        height: 320,
        child: Form(
          key: keyForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppInput(
                  label: 'Email',
                  hintText: "type your Email".tr,
                  controller: controller,
                  context: context,
                  show: true,
                  isPassword: false,
                  textInputType: TextInputType.emailAddress,
                  suffixIcon: TextButton(
                    onPressed: () {},
                    child: Text(
                      'send OTP'.tr,
                      style: AppTypography.h6.copyWith(color: AppColors.blue_1),
                    ),
                  ),
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'Bạn cần hoàn thiện trường thông tin này';
                    } else if (!isValidEmail(value)) {
                      return 'Bạn cần điền đúng định dạng email';
                    }
                  }),
              SizedBox(height: sp16),
              Text(
                'OTP'.tr,
                style: AppTypography.p5,
              ),
              SizedBox(height: sp16),
              PinCodeTextField(
                appContext: context,
                length: 6,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  borderWidth: 1,
                  activeColor: AppColors.borderColor_2,
                  inactiveColor: AppColors.borderColor_2,
                ),
                errorTextSpace: 26,
                errorTextMargin: EdgeInsets.only(left: 12),
                textStyle: AppTypography.h6,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Bạn cần hoàn thiện trường này';
                  } else if (value.length < 6) {
                    return 'Bạn cần nhập đủ 6 số mã code';
                  }
                  return null;
                },
                onChanged: (value) {},
              )
            ],
          ),
        ),
      ),
      MainButton(
        title: 'confirm'.tr,
        event: () {
          if (checkValidate(keyForm)) {
            _forgotPasswordController.changeStep(value: 2.obs);
          }
        },
        largeButton: true,
        icon: null,
      )
    ],
  );
}

Widget buildStep2(BuildContext context, GlobalKey<FormState> keyForm,
    TextEditingController controller) {
  final _forgotPasswordController = Get.put(ForgotPasswordController());
  return Column(
    children: [
      Container(
        height: 320,
        child: Form(
          key: keyForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppInput(
                  label: 'new password'.tr,
                  hintText: "type your new password".tr,
                  controller: controller,
                  context: context,
                  show: true,
                  isPassword: false,
                  textInputType: TextInputType.emailAddress,
                  suffixIcon: Spacer(),
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'Bạn cần hoàn thiện trường thông tin này';
                    }
                  }),
              SizedBox(height: sp16),
              AppInput(
                  label: 'confirm your new password'.tr,
                  hintText: "confirm your new password".tr,
                  controller: controller,
                  context: context,
                  show: true,
                  isPassword: false,
                  textInputType: TextInputType.emailAddress,
                  suffixIcon: Spacer(),
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'Bạn cần hoàn thiện trường thông tin này';
                    }
                  }),
            ],
          ),
        ),
      ),
      MainButton(
        title: 'create new password'.tr,
        event: () {
          if (checkValidate(keyForm)) {
            _forgotPasswordController.changeStep(value: 3.obs);
          }
        },
        largeButton: true,
        icon: null
      )
    ],
  );
}

Widget buildStep3(BuildContext context) {
  return Column(
    children: [
      Container(
        height: 280,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.green_2,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('${AssetsPath.image}/noti-success.png'),
              SizedBox(height: sp16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Quý khách đã tạo \n mật khẩu mới thành công!',
                  textAlign: TextAlign.center,
                  style: AppTypography.h5.copyWith(color: AppColors.green_1),
                ),
              )
            ],
          ),
        ),
      ),
      SizedBox(
        height: 24,
      ),
      MainButton(
        title: 'back to login'.tr,
        event: () {
          Get.back();
        },
        largeButton: true,
        icon: null
      )
    ],
  );
}
