import '../../category/models/category.dart';

class ProductModel {
  int? product_id;
  String? img;
  String? product_name;
  String? product_code;
  String? system_key;
  List<CategoryModel>? category;
  

  ProductModel({
    required this.product_id,
    required this.img,
    required this.product_name,
    required this.product_code,
    required this.system_key,
    required this.category,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    this.product_id = json['product_id'];
  }
}