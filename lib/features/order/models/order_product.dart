class OrderProductModel {
  int? id;
  int? order_item_id;
  int? formula_id;
  String? formula_name;
  double? formula_price;
  int? amount;
  int? warehouse_id;
  String? consignment;
  String? created_at;
  String? updated_at;
  int? user_created;
  int? user_updated;

  OrderProductModel(
      {required this.amount,
      required this.consignment,
      required this.created_at,
      required this.formula_id,
      required this.formula_name,
      required this.formula_price,
      required this.id,
      required this.order_item_id,
      required this.updated_at,
      required this.user_created,
      required this.user_updated,
      required this.warehouse_id});

  factory OrderProductModel.fromJson(Map<String, dynamic> json) =>
      OrderProductModel(
        amount: json['amount'] ?? null,
        consignment: json['consignment'] ?? null,
        created_at: json['created_at'] ?? null,
        formula_id: json['formula_id'] ?? null,
        formula_name: json['formula_name'] ?? null,
        formula_price: json['formula_price'] ?? null,
        id: json['id'] ?? null,
        order_item_id: json['order_item_id'] ?? null,
        updated_at: json['updated_at'] ?? null,
        user_created: json['user_created'] ?? null,
        user_updated: json['user_updated'] ?? null,
        warehouse_id: json['warehouse_id'] ?? null,
      );
}
