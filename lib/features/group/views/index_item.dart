import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '/common/base/base_button.dart';
import '/common/base/base_container.dart';
import '/common/base/base_input.dart';
import '/common/util/enum/status_noti.dart';
import '/components/notification/index.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_size_device.dart';
import '../../../common/constants/app_spacing.dart';
import '../../../common/constants/app_typography.dart';
import '../../../common/constants/assets_path.dart';
import '../../../common/constants/constans.dart';
import '/features/group/views/index_controller.dart';
import '/local%20storage/app_shared_preference.dart';

class GroupEmty extends StatelessWidget {
  const GroupEmty({required this.createGroup, super.key});

  final Function createGroup;

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      context,
      Column(
        children: [
          SvgPicture.asset('${AssetsPath.image}/group/emty.svg'),
          SizedBox(height: sp24),
          Text(
            'Chưa có nhóm người dùng nào',
            style: AppTypography.p4,
          ),
          SizedBox(height: sp8),
          Text(
            'Tạo nhóm người dùng mới để hiển thị và \n quản lý nhóm người dùng',
            textAlign: TextAlign.center,
            style: AppTypography.p4.copyWith(color: AppColors.greyColor),
          ),
          SizedBox(height: sp24),
          MainButton(
            title: 'Tạo nhóm người dùng mới',
            event: () {
              createGroup(context);
            },
            largeButton: true,
            icon: Icon(Icons.add_circle, size: sp16),
          ),
        ],
      ),
    );
  }
}

class GroupList extends StatelessWidget {
  const GroupList({required this.groupController, required this.createGroup, super.key});

  final GroupController? groupController;
  final Function createGroup;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: MainButton(
              title: 'Thêm mới nhóm người dùng',
              event: () {
                createGroup(context);
              },
              largeButton: true,
              icon: Icon(Icons.add_circle, size: sp16),
            ),
          ),
          SizedBox(height: sp24),
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 0,
              maxHeight: heightDevice(context) - 280,
            ),
            child: ListView.separated(
              itemBuilder: (context, index) => Dismissible(
                onDismissed: (direction) {
                  print('has delete');
                },
                confirmDismiss: (direction) {
                  return showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      icon: SvgPicture.asset(
                        '${AssetsPath.image}/noti/warning.svg',
                        width: 50,
                      ),
                      title: Text(
                        'Thông báo',
                        style: AppTypography.h2,
                      ),
                      content: Text(
                        'Bạn chắc chăn muốn xoá nhóm này ?',
                        style: AppTypography.p5.copyWith(
                          color: AppColors.greyColor,
                        ),
                      ),
                      actions: <Widget>[
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: MainButton(
                                title: 'Quay lại',
                                event: () {
                                  Navigator.of(context).pop(false);
                                },
                                largeButton: true,
                                icon: null,
                              ),
                            ),
                            SizedBox(width: sp12),
                            Expanded(
                              flex: 1,
                              child: Extrabutton(
                                title: 'Xoá',
                                event: () async {
                                  var payload = {
                                    'id' : groupController!.listGroup[index]['id']
                                  };
                                  await groupController!.deleteGroup(payload);
                                  Navigator.of(context).pop(true);
                                },
                                largeButton: true,
                                borderColor: AppColors.borderColor_2,
                                icon: null,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
                direction: DismissDirection.endToStart,
                background: Container(
                  padding: EdgeInsets.all(sp16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(sp8),
                    color: AppColors.red_2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.delete_outline,
                        color: AppColors.whiteColor,
                      )
                    ],
                  ),
                ),
                key: Key(groupController!.listGroup[index]['id'].toString()),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(sp8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(sp8),
                    color: AppColors.whiteColor,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundImage: NetworkImage(
                          'https://static.independent.co.uk/2022/05/05/13/newFile-2.jpg?quality=75&width=1200&auto=webp',
                        ),
                      ),
                      SizedBox(width: sp16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            groupController!.listGroup[index]['room_name'],
                            style: AppTypography.p5,
                          ),
                          SizedBox(height: sp8),
                          Text(
                            '24 người dùng',
                            style: AppTypography.p8.copyWith(
                              color: AppColors.greyColor,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(height: sp16),
              itemCount: groupController!.listGroup.length,
            ),
          )
        ],
      ),
    );
  }
}

class PopCreateGroup extends StatelessWidget {
  final _groupController = Get.put(GroupController());
  final _key = GlobalKey<FormState>();
  var _text = TextEditingController();

  void createGroup(BuildContext context) {
    var validate = _key.currentState!.validate();
    if (!validate) return;

    showDialog(
      context: context,
      builder: (context) => Center(
        child: Card(
          child: PopNotification(
            context,
            'Đang tạo nhóm người dùng, vui lòng đợi !',
            () {},
            StatusChat.LOADING,
          ),
        ),
      ),
    );

    var user = jsonDecode(AppSharedPreference.instance.getValue(PrefKeys.USER));

    var payload = {
      "room_name": _text.text,
      "system_key": "NPP",
      "owner_id": user['id'],
      "guest_id": [30],
      "user_id": user['id']
    };

    _groupController.createGroup(payload).then((value) {
      Get.back();
      showDialog(
        context: context,
        builder: (context) => Center(
          child: Card(
            child: PopNotification(
              context,
              value
                  ? 'Tạo nhóm thành công !'
                  : 'Tạo nhóm thất bại, vui lòng thử lại !',
              null,
              value ? StatusChat.SUCCESS : StatusChat.ERROR,
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: sp24, horizontal: sp16),
      width: widthDevice(context) - sp32,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Tạo danh nhóm mới',
            style: AppTypography.h6,
          ),
          SizedBox(height: sp16),
          Form(
            key: _key,
            child: AppInput(
              label: 'Đặt tên nhóm',
              hintText: 'Điền tên nhóm',
              controller: _text,
              context: context,
              show: true,
              isPassword: false,
              textInputType: TextInputType.text,
              suffixIcon: null,
              validate: (String value) {
                if (value.isEmpty) {
                  return 'Bạn cần đặt tên nhóm';
                }
              },
            ),
          ),
          SizedBox(height: sp24),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Extrabutton(
                  title: 'Huỷ bỏ',
                  event: () {
                    Get.back();
                  },
                  largeButton: true,
                  borderColor: AppColors.borderColor_2,
                  icon: null,
                ),
              ),
              SizedBox(width: sp16),
              Expanded(
                flex: 1,
                child: MainButton(
                  title: 'Xác nhận',
                  event: () {
                    createGroup(context);
                  },
                  largeButton: true,
                  icon: null,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
