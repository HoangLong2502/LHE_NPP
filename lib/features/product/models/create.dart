class CreateProductModel {
  int? account_id;
  int? category_id;
  List<Map<String, dynamic>>? formula;
  String? product_description;
  List? product_image;
  String? product_name;
  String? system_key;
  int? user_id;

  CreateProductModel({
    required this.account_id,
    required this.category_id,
    required this.formula,
    required this.product_description,
    required this.product_image,
    required this.product_name,
    required this.system_key,
    required this.user_id,
  });

  CreateProductModel.fromJson(Map<String, dynamic> json) {
    this.account_id = json['account_id'];
    this.category_id = json['category_id'];
    this.formula = json['formula'];
    this.product_description = json['product_description'];
    this.product_image = json['product_image'];
    this.product_name = json['product_name'];
    this.system_key = json['system_key'];
    this.user_id = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['account_id'] = this.account_id;
    data['category_id'] = this.category_id;
    data['formula'] = this.formula;
    data['account_id'] = this.account_id;
    data['account_id'] = this.account_id;
    data['account_id'] = this.account_id;
    data['account_id'] = this.account_id;
    data['account_id'] = this.account_id;

    return data;
  }
}