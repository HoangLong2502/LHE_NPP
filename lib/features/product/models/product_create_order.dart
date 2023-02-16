class ProductPurchaseModel {
  int id;
  String image;
  String title;
  String subtitle;
  String SKU;
  String unit_price;
  String unit_quantity;
  int price;
  int quantity;
  int product_id;

  ProductPurchaseModel({
    required this.SKU,
    required this.id,
    required this.image,
    required this.price,
    this.quantity = 1,
    required this.subtitle,
    required this.title,
    required this.unit_price,
    required this.unit_quantity,
    required this.product_id,
  });

  factory ProductPurchaseModel.fromJson(Map<String, dynamic> json) =>
      ProductPurchaseModel(
        SKU: '23391293743',
        id: json['formula_id'],
        image: 'https://thachlonghai.com.vn/FileManager/Thachlonghai/Sanpham/Thach_rau_cau_uong_KIMIKO/Kimiko_tui_450g/Thach-KIMIKO-tui-xe-Thach-rau-cau-Nhat-Ban-01.jpg',
        price: (json['formula_price'][0]['price']).toInt(),
        subtitle: json['product_name'],
        title: json['formula_name'],
        unit_price: json['formula_price'][0]['currency_code'],
        unit_quantity: 'gói',
        product_id: json['product_id'],
      );

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['SKU'] = this.SKU;
    data['id'] = this.id;
    data['image'] = this.image;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['subtitle'] = this.subtitle;
    data['title'] = this.title;
    data['unit_price'] = this.unit_price;
    data['unit_quantity'] = this.unit_quantity;

    return data;
  }
}