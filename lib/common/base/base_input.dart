import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';

Widget AppInput({
  required String label,
  required String hintText,
  required TextEditingController? controller,
  required BuildContext context,
  required TextInputType textInputType,
  required Widget? suffixIcon,
  required Function validate,
  bool show = true,
  bool isPassword = false,
  int? maxLines,
  FocusNode? fn,
  bool required = false,
  Function? onTap,
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
        onTap: () {
          if (onTap != null) onTap();
        },
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

class InputCurrency extends StatelessWidget {

  final String? label;
  final String hintText;
  final TextEditingController controller;
  final BuildContext context;
  final Widget? suffixIcon;
  final Function validate;
  final FocusNode? fn;
  final bool required;

  InputCurrency({
    required this.label,
    required this.hintText,
    required this.context,
    required this.suffixIcon,
    required this.validate,
    required this.controller,
    this.fn,
    this.required = false,
  });

  static const _locale = 'vi';
  String _formatNumber(String s) => NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency => NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;

  @override
  Widget build(BuildContext context) {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (label != null) RichText(
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
      if (label != null) SizedBox(height: sp8),
      TextFormField(
        keyboardType: TextInputType.number,
        controller: controller,
        focusNode: fn,
        onChanged: (string) {
          string = '${_formatNumber(string.replaceAll('.', ''))}';
          controller.value = TextEditingValue(
            text: string,
            selection: TextSelection.collapsed(offset: string.length),
          );
        },
        validator: (value) {
          return validate(value);
        },
        decoration: InputDecoration(
          prefixText: _currency,
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
          suffixIcon: suffixIcon,
        ),
      ),
    ],
  );
  }
}
