import 'package:flutter/material.dart';

import '../../../../../constants/app_colors.dart';
import '../../../../../constants/app_size_device.dart';
import '../../../../../constants/app_spacing.dart';

class HistoryOrder extends StatefulWidget {
  const HistoryOrder({super.key});

  @override
  State<HistoryOrder> createState() => _HistoryOrderState();
}

class _HistoryOrderState extends State<HistoryOrder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightDevice(context),
      padding: EdgeInsets.symmetric(horizontal: sp16),
      color: AppColors.bg_4,
      child: const Spacer()
    );
  }
}
