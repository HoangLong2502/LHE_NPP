import 'package:flutter/material.dart';

import '../../common/constants/app_typography.dart';

Widget buildRowItem({
  required String title,
  required String content,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        flex: 1,
        child: Text('$title', style: AppTypography.p6),
      ),
      Expanded(
        flex: 1,
        child: Text('$content', style: AppTypography.h6, textAlign: TextAlign.right, maxLines: 1, overflow: TextOverflow.ellipsis,),
      ),
    ],
  );
}
