import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../../../common/base/base_button.dart';
import '../../../../common/base/base_container.dart';
import '../../../../common/base/base_input.dart';
import '../../../../common/base/base_select.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_size_device.dart';
import '../../../../constants/app_spacing.dart';
import '../../../../constants/app_typography.dart';

class CreateProductItem {
  Widget InfoProduct(
    BuildContext context,
    Map<String, dynamic>? product_category,
    Function handleSelect,
    TextEditingController? product_name_controller,
    TextEditingController? product_note_controller,
    List<Map<String, dynamic>> listCategory,
  ) {
    return BaseContainer(
      context,
      Column(
        children: [
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Danh mục *', style: AppTypography.p5),
                SizedBox(height: sp4),
                SizedBox(
                  width: double.infinity,
                  child: BaseSelect(
                    list: listCategory,
                    select: product_category ?? null,
                    handleSelect: handleSelect,
                    hint: 'Chọn một danh mục',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: sp16),
          AppInput(
            label: 'Tên sản phẩm *',
            hintText: 'Nhập tên sản phẩm',
            controller: product_name_controller,
            context: context,
            show: true,
            isPassword: false,
            textInputType: TextInputType.name,
            suffixIcon: null,
            validate: () {},
            maxLines: 1,
          ),
          SizedBox(height: sp16),
          AppInput(
            label: 'Mô tả sản phẩm',
            hintText: 'Nhập mô tả sản phẩm',
            controller: product_note_controller,
            context: context,
            show: true,
            isPassword: false,
            textInputType: TextInputType.multiline,
            suffixIcon: null,
            validate: () {},
            maxLines: null,
          ),
        ],
      ),
    );
  }

  Widget ImgsProduct(
    BuildContext context,
    List<XFile>? product_images,
    ImagePicker _picker,
    XFile? product_cover_image,
    Function _handlePickImgs,
    Function _handlePickCoverImg,
    Function _handleDeleteImg,
  ) {
    return BaseContainer(
      context,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ảnh sản phẩm *',
            style: AppTypography.p3,
          ),
          SizedBox(height: sp16),
          Container(
            width: widthDevice(context) - 64,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  InkWell(
                    onTap: () async {
                      final list = await _picker.pickMultiImage();
                      _handlePickImgs(list);
                    },
                    child: Container(
                      width: 97,
                      height: 97,
                      child: DottedBorder(
                        radius: Radius.circular(sp8),
                        color: AppColors.mainColor,
                        child: Center(
                          child: Icon(
                            Icons.add_a_photo,
                            color: AppColors.mainColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (product_images != null)
                    Row(
                      children: (product_images).map((file) {
                        return InkWell(
                          onTap: () {
                            _handlePickCoverImg(file);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: sp8),
                            child: Stack(children: [
                              Container(
                                width: 97,
                                height: 97,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(sp8),
                                  child: Image.file(
                                    File(file.path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: IconButton(
                                  onPressed: () {
                                    _handleDeleteImg(file);
                                  },
                                  style: IconButton.styleFrom(
                                    backgroundColor: Colors.white,
                                  ),
                                  icon: Icon(
                                    Icons.close,
                                    color: AppColors.greyColor,
                                  ),
                                ),
                              ),
                              if (file == product_cover_image)
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  left: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.mainColor,
                                        borderRadius: BorderRadius.vertical(
                                            bottom: Radius.circular(sp8))),
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 2,
                                    ),
                                    child: Text(
                                      'Ảnh bìa',
                                      style: AppTypography.p7.copyWith(
                                          color: AppColors.whiteColor),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                            ]),
                          ),
                        );
                      }).toList(),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget PropertiesProduct(BuildContext context, List product_properties,
      Function _handleDeleteProperties, Function _updateFormula) {
    return Column(
      children: product_properties
          .map(
            (e) => Visibility(
              visible: e['isUse'] ? true : false,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: sp8),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: AppColors.borderColor_4, width: 1),
                    borderRadius: BorderRadius.circular(sp8),
                  ),
                  child: Column(
                    children: [
                      AppInput(
                        label: 'Tên thuộc tính',
                        hintText: 'Điền tên thuộc tính',
                        controller: e['name'],
                        context: context,
                        show: true,
                        isPassword: false,
                        textInputType: TextInputType.name,
                        suffixIcon: null,
                        validate: () {},
                      ),
                      SizedBox(height: sp16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Giá trị thuộc tính',
                            style: AppTypography.p5,
                          ),
                          SizedBox(height: sp4),
                          TextFieldTags(
                            textfieldTagsController: e['controller'],
                            textSeparators: [' '],
                            initialTags: e['value'],
                            inputfieldBuilder: (context, tec, fn, error,
                                onChanged, onSubmitted) {
                              return ((context, sc, tags, onTagDelete) {
                                // _handleAddPropertiesTags(e, tags);
                                e['value'] = tags;
                                return Padding(
                                  padding: EdgeInsets.all(0),
                                  child: TextField(
                                    controller: tec,
                                    focusNode: fn,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          color: AppColors.borderColor_4,
                                          width: 1.0,
                                        ),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.mainColor,
                                          width: 1.0,
                                        ),
                                      ),
                                      // helperText: 'Enter language...',
                                      // helperStyle: const TextStyle(
                                      //   color: Color.fromARGB(255, 74, 137, 92),
                                      // ),
                                      hintText: "Điền thuộc tính",
                                      errorText: error,
                                      prefixIconConstraints: BoxConstraints(
                                          maxWidth: widthDevice(context) - 64),
                                      prefixIcon: tags.isNotEmpty
                                          ? SingleChildScrollView(
                                              controller: sc,
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                  children:
                                                      tags.map((String tag) {
                                                return Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(4),
                                                    ),
                                                    color: AppColors.bg_2,
                                                  ),
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 5.0),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      InkWell(
                                                        child: Text(
                                                          '$tag',
                                                          style:
                                                              const TextStyle(
                                                            color: AppColors
                                                                .blackColor,
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          print(" selected");
                                                        },
                                                      ),
                                                      const SizedBox(
                                                          width: 4.0),
                                                      InkWell(
                                                        child: const Icon(
                                                          Icons.cancel,
                                                          size: 14.0,
                                                          color: AppColors
                                                              .greyColor,
                                                        ),
                                                        onTap: () {
                                                          onTagDelete(tag);
                                                          e['value']
                                                              .removeWhere(
                                                                  (item) =>
                                                                      item ==
                                                                      tag);
                                                          _updateFormula();
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                );
                                              }).toList()),
                                            )
                                          : null,
                                    ),
                                    onChanged: (value) {
                                      onChanged!(value);
                                      _updateFormula();
                                    },
                                    onSubmitted: (value) {
                                      onSubmitted!(value);
                                      _updateFormula();
                                    },
                                  ),
                                );
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: sp24),
                      Container(
                        width: double.infinity,
                        child: Extrabutton(
                          title: 'Xóa thuộc tính này',
                          event: () {
                            _handleDeleteProperties(e);
                          },
                          largeButton: true,
                          borderColor: AppColors.red_1,
                          icon: Icon(Icons.delete,
                              size: 16, color: AppColors.red_1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget FormulaItem(BuildContext context, item, Function _handleSelectFormula) {
    return Container(
      padding: EdgeInsets.all(sp16),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(sp8),
          border: Border.all(color: AppColors.borderColor_4)),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 25,
                child: Checkbox(
                  value: item['isChosed'],
                  onChanged: (value) {
                    _handleSelectFormula(item);
                  },
                ),
              ),
              SizedBox(width: sp4),
              Text(
                item['formula_label'],
                style: AppTypography.p4,
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tiêu đề', style: AppTypography.p5),
              SizedBox(height: sp4),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: sp16, horizontal: sp12),
                decoration: BoxDecoration(
                  color: AppColors.bg_2,
                  borderRadius: BorderRadius.circular(sp8),
                ),
                child: Text(
                  item['formula_name'],
                  style: AppTypography.p6,
                ),
              )
            ],
          ),
          SizedBox(height: sp16),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: AppInput(
                  label: 'Giá bán lẻ',
                  hintText: 'Điền giá bán lẻ',
                  controller: item['formula_price_retail'],
                  context: context,
                  show: true,
                  isPassword: false,
                  textInputType: TextInputType.number,
                  suffixIcon: null,
                  validate: () {},
                ),
              ),
              SizedBox(width: sp16),
              Expanded(
                flex: 1,
                child: AppInput(
                  label: 'Giá theo thùng',
                  hintText: 'Điền giá bán theo thùng',
                  controller: item['formula_price_per_box'],
                  context: context,
                  show: true,
                  isPassword: false,
                  textInputType: TextInputType.number,
                  suffixIcon: null,
                  validate: () {},
                ),
              ),
            ],
          ),
          SizedBox(height: sp16),
          Container(
            width: double.infinity,
            child: AppInput(label: 'Số lượng sản phẩm trong thùng', hintText: 'Điền số lượng', controller: item['number_in_box'], context: context, show: true, isPassword: false, textInputType: TextInputType.number, suffixIcon: null, validate: () {}))
        ],
      ),
    );
  }
}
