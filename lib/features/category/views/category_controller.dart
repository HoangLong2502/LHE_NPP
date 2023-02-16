import 'package:get/get.dart';

import '../models/category.dart';

class CategoryController extends GetxController {
  var listCategory = [];

  updateListCategory(value) {
    final List<CategoryModel> dataModel = (value as List).map(
      (item) => CategoryModel(
        category_id: item['category_id'],
        category_name: item['category_name'],
        category_code: item['category_code'],
      ),
    ).toList();
    listCategory = dataModel;
    update();
  }
}
