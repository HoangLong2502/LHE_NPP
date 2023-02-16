import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_size_device.dart';
import '../../constants/app_spacing.dart';
import 'base_appBar.dart';
import 'base_bottomBar.dart';

class BaseLayout extends StatelessWidget {
  final String titleAppBar;
  final Widget child;

  BaseLayout(this.titleAppBar, this.child);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar('$titleAppBar'),
      body: Stack(
        children: [
          Container(
            width: widthDevice(context),
            height: heightDevice(context),
            padding: EdgeInsets.symmetric(vertical: sp24, horizontal: sp16),
            color: AppColors.bg_4,
            child: child,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: buildBottomBar(context, 1, () {}),
          )
        ],
      ),
    );
  }
}
