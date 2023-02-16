import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_typography.dart';

Widget AppInput({
  required String label,
  required String hintText,
  required controller,
  required BuildContext context,
  // required value,
  required bool show,
  required bool isPassword,
  required TextInputType textInputType,
  required Widget? suffixIcon,
  required Function validate,
  int? maxLines,
  FocusNode? fn,
  bool required = false,
  // required Function onChanged
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      RichText(
        text: TextSpan(
          text: '$label',
          style: AppTypography.p5.copyWith(color: AppColors.blackColor),
          children: [
            if (required) TextSpan(
              text: ' *',
              style: AppTypography.p5.copyWith(color: AppColors.red_1)
            )
          ],
        ),
      ),
      // Text('$label', style: AppTypography.p5),
      SizedBox(height: sp8),
      TextFormField(
        maxLines: maxLines,
        keyboardType: textInputType,
        controller: controller,
        obscureText: !show,
        focusNode: fn,
        validator: (value) {
          return validate(value);
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: AppColors.borderColor_2,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: AppColors.blue_1,
              width: 1,
            ),
          ),
          hintText: hintText,
          hintStyle: AppTypography.p6.copyWith(color: AppColors.greyColor),
          // label: Text(
          //   label,
          //   style: AppTypography.p5,
          // ),
          suffixIcon: suffixIcon,
          // isPassword
          //   ? IconButton(
          //       icon: Icon(
          //         show ? Icons.visibility : Icons.visibility_off_outlined,
          //       ),
          //       onPressed: () {
          //         _loginController.changeShowPassword(value: show ? false.obs : true.obs);
          //       },
          //     )
          //   : Spacer(),
        ),
      ),
    ],
  );
}
