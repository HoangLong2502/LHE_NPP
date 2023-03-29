import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../common/base/base_button.dart';
import '../../../../../common/base/base_container.dart';
import '../../../../../common/base/base_input.dart';
import '../../../../../common/util/enum/status_noti.dart';
import '../../../../../components/maps/map_picker.dart';
import '../../../../../components/notification/index.dart';
import '../../../../../common/constants/app_colors.dart';
import '../../../../../common/constants/app_size_device.dart';
import '../../../../../common/constants/app_spacing.dart';
import '../../../../../common/constants/app_typography.dart';
import '../../../../../common/constants/constans.dart';
import '../../../../../local storage/app_shared_preference.dart';
import '../index_controller.dart';

class CreateNVTT extends StatefulWidget {
  CreateNVTT({required this.controller, super.key});

  CreateUserController controller;
  @override
  State<CreateNVTT> createState() => _CreateNVTTState();
}

class _CreateNVTTState extends State<CreateNVTT> {
  final CarouselController _carouselController = CarouselController();

  int pageSelect = 0;

  void onPageChange(int index, CarouselPageChangedReason changeReason) {
    setState(() {
      pageSelect = index;
    });
  }

  List<Map<String, dynamic>> _list_1 = [
    {
      'label': 'Họ và tên',
      'hintText': 'Nhập tên họ và tên',
      'type': 'INPUT',
      'text': TextEditingController(),
      'fn': FocusNode(),
      'textInputType': TextInputType.name,
      'validate': (String value) {
        if (value.isEmpty) return 'Bạn cần hoàn thiện trường này';
      },
      "profile_name": "npp_representative_name",
    },
    {
      'label': 'Số điện thoại ',
      'hintText': 'Nhập số điện thoại',
      'type': 'INPUT',
      'text': TextEditingController(),
      'fn': FocusNode(),
      'textInputType': TextInputType.phone,
      'validate': (String value) {
        if (value.isEmpty) return 'Bạn cần hoàn thiện trường này';
      },
      "profile_name": "npp_phone_number",
    },
    {
      'label': 'Mã số thuế NPP ',
      'hintText': 'Nhập mã số thuế NPP',
      'type': 'INPUT',
      'text': TextEditingController(),
      'fn': FocusNode(),
      'textInputType': TextInputType.number,
      'validate': (String value) {
        if (value.isEmpty) return 'Bạn cần hoàn thiện trường này';
      },
      "profile_name": "npp_tax_code",
    },
    {
      'label': 'CMT/CCCD ',
      'hintText': 'Nhập CMT/CCCD',
      'type': 'INPUT',
      'text': TextEditingController(),
      'fn': FocusNode(),
      'textInputType': TextInputType.number,
      'validate': (String value) {
        if (value.isEmpty) return 'Bạn cần hoàn thiện trường này';
      },
      "profile_name": "npp_citizen_identity_number",
    },
    {
      'label': 'Ngày cấp',
      'hintText': 'DD/MM/YY',
      'type': 'DATE',
      'text': DateTime.now(),
      'fn': FocusNode(),
      'textInputType': TextInputType.name,
      'validate': (String value) {
        if (value.isEmpty) return 'Bạn cần hoàn thiện trường này';
      },
      "profile_name": "npp_issued_date",
    },
    {
      'label': 'Nơi cấp',
      'hintText': 'Nhập nơi cấp',
      'type': 'INPUT',
      'text': TextEditingController(),
      'fn': FocusNode(),
      'textInputType': TextInputType.name,
      'validate': (String value) {
        if (value.isEmpty) return 'Bạn cần hoàn thiện trường này';
      },
      "profile_name": "npp_issuer_name",
    }
  ];

  List<Map<String, dynamic>> _list_2 = [
    {
      'label': 'Địa chỉ ',
      'hintText': 'Nhập địa chỉ nhà phân phối',
      'type': 'INPUT',
      'text': TextEditingController(),
      'fn': FocusNode(),
      'textInputType': TextInputType.name,
      'validate': (String value) {
        if (value.isEmpty) return 'Bạn cần hoàn thiện trường này';
      },
      'required': true,
      "profile_name": "npp_address",
    },
    {
      'label': 'Vùng',
      'hintText': 'Chọn vùng',
      'type': 'INPUT',
      'text': TextEditingController(),
      'fn': FocusNode(),
      'textInputType': TextInputType.name,
      'validate': (String value) {
        if (value.isEmpty) return 'Bạn cần hoàn thiện trường này';
      },
      "profile_name": "npp_zone",
    },
    {
      'label': 'Chọn khu vực',
      'hintText': 'Chọn khu vực',
      'type': 'INPUT',
      'text': TextEditingController(),
      'fn': FocusNode(),
      'textInputType': TextInputType.name,
      'validate': (String value) {
        if (value.isEmpty) return 'Bạn cần hoàn thiện trường này';
      },
      "profile_name": "npp_area",
    },
    {
      'label': 'Ngành nghề kinh doanh',
      'hintText': 'Nhập ngành nghề kinh doanh',
      'type': 'INPUT',
      'text': TextEditingController(),
      'fn': FocusNode(),
      'textInputType': TextInputType.name,
      'validate': (String value) {
        if (value.isEmpty) return 'Bạn cần hoàn thiện trường này';
      },
    },
    {
      'label': 'Diện tích kho',
      'hintText': 'Nhập diện tích kho',
      'type': 'INPUT',
      'text': TextEditingController(),
      'fn': FocusNode(),
      'textInputType': TextInputType.phone,
      'validate': (String value) {
        if (value.isEmpty) return 'Bạn cần hoàn thiện trường này';
      },
      "profile_name": "npp_warehouse_area",
    },
    {
      'label': 'Nhân công ',
      'hintText': 'Nhập nhân công',
      'type': 'INPUT',
      'text': TextEditingController(),
      'fn': FocusNode(),
      'textInputType': TextInputType.number,
      'validate': (String value) {
        if (value.isEmpty) return 'Bạn cần hoàn thiện trường này';
      },
      "profile_name": "npp_number_of_staff",
    },
    {
      'label': 'Thời gian vào ',
      'hintText': 'DD/MM/YY',
      'type': 'DATE',
      'text': DateTime.now(),
      'fn': FocusNode(),
      'textInputType': TextInputType.name,
      'validate': (String value) {
        if (value.isEmpty) return 'Bạn cần hoàn thiện trường này';
      },
      "profile_name": "npp_join_date",
    },
    {
      'label': 'Mã NPP - Phòng kế toán tạo',
      'hintText': 'Nhập Mã NPP',
      'type': 'INPUT',
      'text': TextEditingController(),
      'fn': FocusNode(),
      'textInputType': TextInputType.name,
      'validate': (String value) {
        if (value.isEmpty) return 'Bạn cần hoàn thiện trường này';
      },
      "profile_name": "npp_accounting_code",
    },
    {
      'label': 'Mã chiện - Phòng thị trường tạo',
      'hintText': 'Nhập mã NPP',
      'type': 'INPUT',
      'text': TextEditingController(),
      'fn': FocusNode(),
      'textInputType': TextInputType.name,
      'validate': (String value) {
        if (value.isEmpty) return 'Bạn cần hoàn thiện trường này';
      },
      "profile_name": "npp_export_code",
    },
  ];

  List<Map<String, dynamic>> _list_3 = [
    {
      'label': 'Tên đăng nhập ',
      'hintText': 'Nhập tên đăng nhập',
      'type': 'INPUT',
      'text': TextEditingController(),
      'fn': FocusNode(),
      'textInputType': TextInputType.name,
      'validate': (String value) {
        if (value.isEmpty) return 'Bạn cần hoàn thiện trường này';
      }
    },
    {
      'label': 'Mật khẩu',
      'hintText': 'Nhập mật khẩu',
      'type': 'INPUT',
      'text': TextEditingController(),
      'fn': FocusNode(),
      'textInputType': TextInputType.name,
      'validate': (String value) {
        if (value.isEmpty) return 'Bạn cần hoàn thiện trường này';
      }
    },
    {
      'label': 'Email ',
      'hintText': 'Nhập email',
      'type': 'INPUT',
      'text': TextEditingController(),
      'fn': FocusNode(),
      'textInputType': TextInputType.name,
      'validate': (String value) {
        if (value.isEmpty) return 'Bạn cần hoàn thiện trường này';
      }
    },
  ];

  void _updatePosition(String address) {
    setState(() {
      _list_2[0]['text'].text = address;
      _list_2[1]['text'].text = 'Vùng 1';
      _list_2[2]['text'].text = 'Khu vực 13';
    });
  }

  void _create_NPP() {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Card(
            child: PopNotification(
          context,
          'Đang tạo tài khoản NPP, vui lòng đợi !',
          null,
          StatusChat.LOADING,
        )),
      ),
    );
    var account =
        jsonDecode(AppSharedPreference.instance.getValue(PrefKeys.USER));
    var profile_data = _list_1.map((item) {
          if (item['profile_name'] != null)
            return {
              'profile_name': item['profile_name'],
              'value': item['text'] is DateTime
                  ? '${DateFormat('y-MM-dd').format(_list_2[6]['text'])}'
                  : item['text'].text
            };
        }).toList() +
        _list_2.map((item) {
          if (item['profile_name'] != null)
            return {
              'profile_name': item['profile_name'],
              'value': item['text'] is DateTime
                  ? '${DateFormat('y-MM-dd').format(_list_2[6]['text'])}'
                  : item['text'].text
            };
        }).toList() +
        _list_3.map((item) {
          if (item['profile_name'] != null)
            return {
              'profile_name': item['profile_name'],
              'value': item['text'].text
            };
        }).toList();
    ;

    var payload = {
      "fullname": "Nhà phân phối ${_list_1[0]['text'].text}",
      "email": _list_3[2]['text'].text,
      "username": _list_3[0]['text'].text,
      "password": _list_3[1]['text'].text,
      "system_key": "NPP",
      "join_date": '${DateFormat('y-MM-dd').format(_list_2[6]['text'])}',
      "phone": "${_list_1[1]['text'].text}",
      "address": "48 Tố Hữu, Hà Nội",
      "user_id": account['id'],
      "profile_data": profile_data.fold<List>(
        [],
        (total, item) {
          if (item != null) total.add(item);

          return total;
        },
      ),
    };

    print(profile_data.fold<List>([], (total, item) {
      if (item != null) total.add(item);

      return total;
    }));

    widget.controller.registerAccount(payload).then((value) {
      Get.back();
      showDialog(
        context: context,
        builder: (context) => Center(
          child: Card(
              child: PopNotification(
            context,
            value ? 'Tạo tài khoản NPP thành công' : 'Tạo tài khoản thật bại',
            null,
            value ? StatusChat.SUCCESS : StatusChat.ERROR,
          )),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightDevice(context) - 100,
      child: Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  const Positioned(
                    left: 48,
                    right: 48,
                    top: 10,
                    child: const Divider(),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ...Iterable<int>.generate(3).map(
                        (int pageIndex) => Flexible(
                          child: InkWell(
                            onTap: () =>
                                _carouselController.animateToPage(pageIndex),
                            child: CircleAvatar(
                              backgroundColor: pageIndex <= pageSelect
                                  ? AppColors.mainColor
                                  : AppColors.whiteColor,
                              radius: 20,
                              child: Center(
                                child: Text(
                                  '${pageIndex + 1}',
                                  style: AppTypography.p5.copyWith(
                                    color: pageIndex <= pageSelect
                                        ? AppColors.whiteColor
                                        : AppColors.greyColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: sp24),
              CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                    height: heightDevice(context) - 258,
                    viewportFraction: 1,
                    // enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    initialPage: 0,
                    onPageChanged: onPageChange),
                items: [
                  buildSlider_1(),
                  buildSlider_2(),
                  buildSlider_3(),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              width: widthDevice(context),
              child: Container(
                color: AppColors.whiteColor,
                padding: EdgeInsets.all(sp16),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Extrabutton(
                        title: pageSelect == 0 ? 'Huỷ bỏ' : 'Quay lại',
                        event: () {
                          pageSelect == 0
                              ? Get.back()
                              : _carouselController.previousPage();
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
                        title: pageSelect == 2 ? 'Tạo tài khoản' : 'Tiếp tục',
                        event: () {
                          pageSelect == 2
                              ? _create_NPP()
                              : _carouselController.nextPage();
                        },
                        largeButton: true,
                        icon: null,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSlider_1() {
    return BaseContainer(
      context,
      SizedBox(
        height: heightDevice(context) - 200,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Thông tin cá nhân',
                style: AppTypography.p3.copyWith(color: AppColors.mainColor),
              ),
              SizedBox(height: sp12),
              Column(
                children: _list_1.map((e) {
                  if (e['type'] == 'INPUT') {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: sp8),
                      child: AppInput(
                        label: e['label'],
                        hintText: e['hintText'],
                        controller: e['text'],
                        fn: e['fn'],
                        context: context,
                        show: true,
                        isPassword: false,
                        textInputType: e['textInputType'],
                        suffixIcon: null,
                        validate: e['validate'],
                        required: true,
                      ),
                    );
                  } else if (e['type'] == 'DATE')
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: sp8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${e['label']}', style: AppTypography.p5),
                          SizedBox(height: sp4),
                          InkWell(
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: e['text'],
                                firstDate: DateTime(2020),
                                lastDate: DateTime.now(),
                                // selectableDayPredicate: (day) {
                                //     e['text'] = day;
                                //   print('${e['text']}');
                                //   return true;
                                // },
                              ).then((value) {
                                setState(() {
                                  e['text'] = value;
                                });
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  vertical: sp16, horizontal: sp12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(sp8),
                                  border: Border.all(
                                      color: AppColors.borderColor_2)),
                              child: Text(
                                  '${DateFormat.yMMMMd().format(e['text'])}'
                                  // e['text'] == '' ? e['label'] : e['text'],
                                  ),
                            ),
                          )
                        ],
                      ),
                    );
                  return Text('data');
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSlider_2() {
    return BaseContainer(
      context,
      SizedBox(
        height: heightDevice(context) - 200,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Thông tin Nhà phân phối của bạn',
                style: AppTypography.p3.copyWith(color: AppColors.mainColor),
              ),
              SizedBox(height: sp24),
              SizedBox(
                width: double.infinity,
                child: MainButton(
                  title: 'Thêm vị trí',
                  event: () {
                    showModalBottomSheet(
                      enableDrag: false,
                      context: context,
                      builder: (context) => SizedBox(
                        height: heightDevice(context) - 200,
                        child: MapPickerNPP(comfirmPosition: _updatePosition),
                      ),
                    );
                  },
                  largeButton: true,
                  icon: Icon(Icons.map, size: sp16),
                ),
              ),
              SizedBox(height: sp16),
              Column(
                children: _list_2.map((e) {
                  if (e['type'] == 'INPUT')
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: sp8),
                      child: AppInput(
                          label: e['label'],
                          hintText: e['hintText'],
                          controller: e['text'],
                          fn: e['fn'],
                          context: context,
                          show: true,
                          isPassword: false,
                          textInputType: e['textInputType'],
                          suffixIcon: null,
                          validate: e['validate'],
                          required: e['required'] ?? false),
                    );
                  else if (e['type'] == 'DATE')
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: sp8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${e['label']}', style: AppTypography.p5),
                          SizedBox(height: sp4),
                          InkWell(
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: e['text'],
                                firstDate: DateTime(2020),
                                lastDate: DateTime.now(),
                                // selectableDayPredicate: (day) {
                                //     e['text'] = day;
                                //   print('${e['text']}');
                                //   return true;
                                // },
                              ).then((value) {
                                setState(() {
                                  e['text'] = value;
                                });
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  vertical: sp16, horizontal: sp12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(sp8),
                                  border: Border.all(
                                      color: AppColors.borderColor_2)),
                              child: Text(
                                  '${DateFormat.yMMMMd().format(e['text'])}'
                                  // e['text'] == '' ? e['label'] : e['text'],
                                  ),
                            ),
                          )
                        ],
                      ),
                    );
                  return Text('data');
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSlider_3() {
    return BaseContainer(
      context,
      SizedBox(
        height: heightDevice(context) - 200,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Thông tin đăng nhập nhà phân phối',
                style: AppTypography.p3.copyWith(color: AppColors.mainColor),
              ),
              SizedBox(height: sp24),
              Column(
                children: _list_3.map((e) {
                  if (e['type'] == 'INPUT')
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: sp8),
                      child: AppInput(
                          label: e['label'],
                          hintText: e['hintText'],
                          controller: e['text'],
                          fn: e['fn'],
                          context: context,
                          show: true,
                          isPassword: false,
                          textInputType: e['textInputType'],
                          suffixIcon: null,
                          validate: e['validate'],
                          required: true),
                    );
                  return Text('data');
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
