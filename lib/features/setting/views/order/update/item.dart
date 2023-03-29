import 'package:flutter/widgets.dart';
import 'package:lhe_npp/common/constants/app_colors.dart';
import 'package:lhe_npp/features/setting/models/typeRuleRoom.dart';
import 'package:lhe_npp/features/setting/views/order/update/controller.dart';

import '../../../../../common/base/base_container.dart';
import '../../../../../common/base/base_select.dart';
import '../../../../../common/constants/app_spacing.dart';
import '../../../../../common/constants/app_typography.dart';

class UpdateTypeOrderItem {
  Widget stepItem(
    BuildContext context,
    UpdateTypeOrderController controller,
    TypeRuleRoomModel item,
  ) {
    return BaseContainer(
      context,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bước ${item.step}',
            style: AppTypography.p6.copyWith(color: AppColors.greyColor),
          ),
          const SizedBox(height: sp16),
          Text(
            'Hệ thống: ${item.system_key}',
            style: AppTypography.p5,
          ),
          const SizedBox(height: sp16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 8,
                child: BaseSelect(
                  list: item.listSelect?.map((e) => e.toJsonSelectItem()).toList(),
                  select: item.type_rules_room,
                  handleSelect: (value) {
                    controller.selectRoom(
                        value, item);
                  },
                  validator: (value) {
                    if (value == null) return 'Vui lòng chọn';
                  },
                  hint: 'Chọn phòng',
                ),
              ),
              const SizedBox(
                width: sp8,
              ),
            ],
          )
        ],
      ),
    );
  }
}
