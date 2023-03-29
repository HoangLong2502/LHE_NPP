import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '/common/util/enum/status_noti.dart';
import '/components/notification/index.dart';
import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/app_typography.dart';
import '/features/product/api/product.dart';
import '/features/product/views/Create/index_item.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../../../common/base/base_appBar.dart';
import '../../../../common/base/base_button.dart';
import '../../../../common/base/base_container.dart';
import '../../../../common/base/base_input.dart';
import '../../../../common/constants/app_spacing.dart';
import 'index_controller.dart';

class CreateProductView extends StatefulWidget {
  const CreateProductView({super.key});

  @override
  State<CreateProductView> createState() => _CreateProductViewState();
}

class _CreateProductViewState extends State<CreateProductView> {
  final ScrollController _Scrollcontroller = ScrollController();
  final _createProductController = Get.put(CreateProductController());

  final _createProductItem = Get.put(CreateProductItem());

  final _createProductService = Get.put(ProductService());

  TextEditingController? product_sku_controller;
  TextEditingController? product_code_controller;
  List? formula;
  List product_properties = [];
  Map<String, dynamic>? product_category;
  List<XFile>? product_images;
  XFile? product_cover_image;

  final ImagePicker _picker = ImagePicker();

  void _handleAddProperties() {
    setState(() {
      product_properties
          .addIf(product_properties.where((e) => e['isUse']).length < 3, {
        'name': TextEditingController(),
        'value': <String>[],
        'controller': TextfieldTagsController(),
        'isUse': true,
      });
    });
  }

  void updateFormula() {
    setState(() {
      formula = _getListFormula;
    });
  }

  List get _getListFormula {
    if (product_properties.fold<num>(
            0,
            (previousValue, e) =>
                previousValue + (e['isUse'] ? e['value'].length : 0)) !=
        0) {
      final num number = product_properties.fold<num>(
        1,
        (total, item) =>
            total *
            (item['value'].length != 0 && item['isUse'] == true
                ? item['value'].length
                : 1),
      );

      final arr = List.generate(
        int.parse(number.toString()),
        (index) => {
          "formula_label": "",
          "formula_name": "",
          "formula_price": TextEditingController(),
          "formula_price_per_box": TextEditingController(),
          "formula_price_retail": TextEditingController(),
          "isChosed": true,
          "isError": false,
          "number_in_box": TextEditingController(),
          "options": [],
        },
      );

      num tick = 1;

      product_properties.forEach((item) {
        if (item['value'].length != 0 && item['isUse']) {
          tick = tick * item['value'].length;
          int number = 1;
          for (int i = 0; i < arr.length; i++) {
            if (i == (arr.length / tick) * number) {
              number += 1;
            }
            arr[i]["formula_name"] =
                '${arr[i]["formula_name"]} ${item['value'][(number - 1) % (item['value'].length == 0 ? 1 : item['value'].length)]}';
            arr[i]["formula_label"] =
                '${arr[i]["formula_label"]}${arr[i]["formula_label"] == "" ? '' : '/'}${item['value'][(number - 1) % (item['value'].length == 0 ? 1 : item['value'].length)]}';
            (arr[i]["options"] as List).add({
              'options_name': item['value'][(number - 1) %
                  (item['value'].length == 0 ? 1 : item['value'].length)],
              'options_value': [item['name'].text],
            });
          }
        }
      });

      return arr;
    } else
      return [];
  }

  void _handleSelectFormula(item) {
    setState(() {
      item['isChosed'] = !item['isChosed'];
    });
  }

  void _handleAddPropertiesTags() {
    setState(() {});
  }

  void _handleDeleteProperties(item) {
    setState(() {
      item['isUse'] = false;
    });
  }

  void _handleSelect(value) {
    setState(() {
      product_category = value;
    });
  }

  void _handlePickImgs(List<XFile> list) {
    setState(() {
      product_images = list;
    });
  }

  void _handlePickCoverImg(XFile file) {
    setState(() {
      product_cover_image = file;
    });
  }

  void _handleDeleteImg(XFile file) {
    setState(() {
      product_images?.removeWhere((element) => element == file);
    });
  }

  void createProduct() {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Card(
          child: PopNotification(
            context,
            'Đang tạo sản phẩm, vui lòng chờ',
            null,
            StatusChat.LOADING,
          ),
        ),
      ),
    );
    _createProductService
        .createproduct(
      product_category!['id'],
      formula!,
      _createProductController.product_description.text,
      product_images!,
      _createProductController.product_name.text,
    )
        .then((value) {
        Get.back();
        showDialog(
          context: context,
          builder: (context) => Center(
            child: Card(
              child: PopNotification(
                context,
                value ? 'Tạo sản phẩm thành công' : 'Tạo sản phẩm thất bại, vui lòng thử lại sau!',
                null,
                value ? StatusChat.SUCCESS : StatusChat.ERROR,
              ),
            ),
          ),
        );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // updateFormula();

    // product_name_controller = TextEditingController();
    // product_note_controller = TextEditingController();
    product_code_controller = TextEditingController();
    product_sku_controller = TextEditingController();

    _createProductController.getCategory();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    // updateFormula();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _createProductController.clear();

    // product_name_controller!.dispose();
    // product_note_controller!.dispose();
    product_code_controller!.dispose();
    product_sku_controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar('Thêm mới sản phẩm'),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: sp24, horizontal: sp16),
        color: AppColors.bg_4,
        child: Container(
          padding: EdgeInsets.only(bottom: 60),
          child: SingleChildScrollView(
            controller: _Scrollcontroller,
            child: Container(
              padding: EdgeInsets.only(bottom: sp24),
              child: Column(
                children: [
                  GetBuilder<CreateProductController>(
                    builder: (controller) => _createProductItem.InfoProduct(
                      context,
                      product_category,
                      _handleSelect,
                      controller.product_name,
                      controller.product_description,
                      controller.categories,
                    ),
                  ),
                  SizedBox(height: sp16),
                  _createProductItem.ImgsProduct(
                    context,
                    product_images,
                    _picker,
                    product_cover_image,
                    _handlePickImgs,
                    _handlePickCoverImg,
                    _handleDeleteImg,
                  ),
                  SizedBox(height: sp16),
                  BaseContainer(
                    context,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mã sản phẩm',
                          style: AppTypography.h5,
                        ),
                        SizedBox(height: 16),
                        AppInput(
                          label: 'SKU (stock keeping unit)',
                          hintText: 'Nhập mã SKU',
                          controller: product_sku_controller,
                          context: context,
                          show: true,
                          isPassword: false,
                          textInputType: TextInputType.name,
                          suffixIcon: null,
                          validate: () {},
                        ),
                        SizedBox(height: sp16),
                        AppInput(
                          label: 'Mã vạch (ISBN, UPC, G TIN,...)',
                          hintText: 'Nhập mã vạch',
                          controller: product_code_controller,
                          context: context,
                          show: true,
                          isPassword: false,
                          textInputType: TextInputType.name,
                          suffixIcon: null,
                          validate: () {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: sp16),
                  BaseContainer(
                    context,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Thuộc tính',
                          style: AppTypography.h5,
                        ),
                        if (product_properties.length != 0)
                          SizedBox(height: 16),
                        _createProductItem.PropertiesProduct(
                          context,
                          product_properties,
                          _handleDeleteProperties,
                          updateFormula,
                        ),
                        SizedBox(height: sp16),
                        Container(
                          width: double.infinity,
                          child: Extrabutton(
                            title:
                                'Thêm thuộc tính (${product_properties.where((e) => e['isUse']).length}/3)',
                            event: () {
                              _handleAddProperties();
                            },
                            largeButton: true,
                            borderColor: AppColors.blackColor,
                            icon: Icon(
                              Icons.add_circle_outline,
                              color: AppColors.blackColor,
                              size: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: sp16),
                        Divider(),
                        SizedBox(height: sp16),
                        Text('Mẫu mã', style: AppTypography.h5),
                        SizedBox(height: sp8),
                        _getListFormula.length == 0
                            ? Text(
                                'Chưa có mẫu mã nào !!',
                                style: AppTypography.p6,
                              )
                            : Column(
                                children: formula!
                                    .map((item) => Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: sp8),
                                          child: _createProductItem.FormulaItem(
                                              context,
                                              item,
                                              _handleSelectFormula),
                                        ))
                                    .toList(),
                              )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: BottomAppBar(
        child: Container(
          padding: EdgeInsets.all(sp16),
          child: Row(children: [
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
                title: 'Tạo mới',
                event: () {
                  createProduct();
                },
                largeButton: true,
                icon: null,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
