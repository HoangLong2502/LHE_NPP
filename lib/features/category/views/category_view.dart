import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/index.dart';
import 'category_controller.dart';
import 'category_item.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  final _categoryController = Get.put(CategoryController());
  final _categoryService = Get.put(CategoryService());

  bool isLoading = true;

  void getData() {
    _categoryService.getAllCategory().then((value) {
      _categoryController.updateListCategory(value);
      setState(() {
        isLoading = false;
      });
    });
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();

  //   getData();
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isLoading
          ? const CircularProgressIndicator()
          : GetBuilder<CategoryController>(
              builder: (controller) {
                return _categoryController.listCategory.isEmpty
                    ? const EmtyCategory()
                    : ListCategory(_categoryController);
              },
            ),
    );
  }
}
