import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_typography.dart';


class BaseSelect extends StatelessWidget {
  List<Map<String, dynamic>>? list;
  Map<String, dynamic>? select;
  Function? handleSelect;
  String? hint;

  BaseSelect({
    required this.list,
    required this.select,
    required this.handleSelect,
    this.hint
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sp12),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderColor_2),
          borderRadius: BorderRadius.circular(sp8)),
      child: DropdownButton<Map<String, dynamic>>(
        hint: Text(
          '$hint',
          style: AppTypography.p6.copyWith(color: AppColors.greyColor),
        ),
        isExpanded: true,
        style: AppTypography.p6,
        underline: Container(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        value: select,
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 3,
        onChanged: (Map<String, dynamic>? value) {
          handleSelect!(value);
        },
        items: list?.map<DropdownMenuItem<Map<String, dynamic>>>((item) {
          return DropdownMenuItem<Map<String, dynamic>>(
            value: item,
            child: Text(
              item['category_name'],
              style: AppTypography.p6.copyWith(color: AppColors.blackColor),
            ),
          );
        }).toList(),
      ),
    );
  }
}
