import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/card/product.dart';
import '../../../constants/app_size_device.dart';
import '../../../constants/app_spacing.dart';
import '../api/product.dart';
import '../models/index.dart';
import 'product_controller.dart';
import 'product_item.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  final _api = ProductService();
  final _productController = Get.put(ProductController());
  // final _productService = Get.put(ProductService());

  final List<Map<String, dynamic>> _listFilter = [
    {
      'title': 'Tất cả',
      'value': 'all',
    },
    {
      'title': 'Đang hoạt động',
      'value': 'Đang hoạt động',
    },
    {
      'title': 'Tạm dừng',
      'value': 'Tạm dừng',
    },
    {
      'title': 'Ngưng hoạt động',
      'value': 'Ngưng hoạt động',
    }
  ];

  bool _isLoading = true;

  String _selectFilter = 'all';

  void _handleSelectFilter(value) {
    setState(() {
      _selectFilter = value;
    });
  }

  void _getDataProduct() {
    _api.getAllProduct().then((value) {
      List<ProductModel> listProduct = value.map((item) {
        return ProductModel(
          product_id: item['product_id'],
          img:
              'https://bizweb.dktcdn.net/100/255/723/products/thach-rau-cau-hoa-qua-long-hai-06.jpg',
          product_name: item['product_name'],
          product_code: item['product_code'],
          system_key: item['system_key'],
          category: [],
        );
      }).toList();
      _productController.updateListProduct(listProduct);
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    _getDataProduct();
  }

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();

  //   // if (_productController.listProduct.length != 0) {
  //   //   setState(() {
  //   //     _isLoading = false;
  //   //   });
  //   // }

  //   _getDataProduct();
  // }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: heightDevice(context) - 270,
              minHeight: heightDevice(context) - 350,
            ),
            // height: heightDevice(context) - 210,
            // padding: EdgeInsets.only(bottom: 100),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ProductPage1(context, _productController, _listFilter,
                      _selectFilter, _handleSelectFilter),
                  SizedBox(height: sp16),
                  GetBuilder<ProductController>(
                    builder: (controller) => Column(
                      children: (_productController.listProduct)
                          .map(
                            (element) => Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: CardProduct(
                                context,
                                element,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    // child: ListView.separated(
                    //   itemBuilder: (context, index) => CardProduct(
                    //     context,
                    //     _productController.listProduct[index],
                    //   ),
                    //   separatorBuilder: (context, index) =>
                    //       SizedBox(height: sp16),
                    //   itemCount: _productController.listProduct.length,
                    // ),
                  ),
                ],
              ),
            ),
          );
  }
}
