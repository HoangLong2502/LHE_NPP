class CategoryModel {
  int? category_id;
  String? category_name;
  String? category_code;

  CategoryModel({
    required this.category_id,
    required this.category_name,
    required this.category_code,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    this.category_id = json['category_id'];
    this.category_name = json['category_name'];
    this.category_code = json['category_code'];
  }
}