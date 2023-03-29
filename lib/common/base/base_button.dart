import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';

Widget MainButton(
    {required String? title,
    required Function event,
    required bool largeButton,
    required Widget? icon}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.mainColor,
        padding: EdgeInsets.symmetric(
            vertical: largeButton ? sp16 : sp8,
            horizontal: largeButton ? sp16 : sp12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
    onPressed: () {
      event();
    },
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) icon,
        if (icon != null && title != null) SizedBox(width: sp8),
        if (title != null)
          Text(
            '$title',
            style: largeButton ? AppTypography.h6 : AppTypography.p5,
          )
      ],
    ),
  );
}

Widget Extrabutton(
    {required String? title,
    required Function event,
    required bool largeButton,
    required Color? borderColor,
    required Widget? icon,
    Color? bgColor}) {
  return OutlinedButton(
    style: OutlinedButton.styleFrom(
        backgroundColor: bgColor ?? Color.fromARGB(0, 0, 0, 0),
        padding: EdgeInsets.symmetric(
            vertical: largeButton ? sp16 : sp8,
            horizontal: largeButton ? sp16 : sp12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(sp8)),
        side: BorderSide(color: borderColor ?? AppColors.borderColor_2, width: 1)),
    onPressed: () {
      event();
    },
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) icon,
        if (icon != null && title != null) SizedBox(width: sp8),
        if (title != null)
          Text(
            '$title',
            style: (largeButton ? AppTypography.h6 : AppTypography.p5)
                .copyWith(color:AppColors.blackColor),
          )
      ],
    ),
  );
}

Widget SupportButton(
    {required String? title,
    required Function event,
    required bool largeButton,
    required Widget? icon,
    required Color? backgroundColor}
    ) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.accentColor_5,
        padding: EdgeInsets.symmetric(
            vertical: largeButton ? sp16 : sp8,
            horizontal: largeButton ? sp16 : sp12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
    onPressed: () {
      event();
    },
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) icon,
        if (icon != null && title != null) SizedBox(width: sp8),
        if (title != null)
          Text(
            '$title',
            style: largeButton ? AppTypography.h6 : AppTypography.p5,
          )
      ],
    ),
  );
}
