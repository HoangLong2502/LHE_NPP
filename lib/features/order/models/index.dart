class OrderModel {
  int? order_id;
  int? account_from;
  int? transport_id;
  String? account_name;
  String? account_system;
  bool? transport_status;
  int? type_rules_id;
  String? created_at;
  int? system_accept;
  int? system_order_id;
  String? order_code;
  double? order_price;
  String? address_from;
  String? address_to;
  String? order_note;
  int? customer_id;
  int? status_id;
  String? status_code;
  String? status_name;
  int? room_to;
  String? system_key;
  String? type_name;
  int? type_level;
  String? roles_name;
  String? roles_code;
  dynamic? total_order_item;

  OrderModel({
    required this.order_id,
    required this.account_from,
    required this.transport_id,
    required this.account_name,
    required this.account_system,
    required this.address_from,
    required this.address_to,
    required this.created_at,
    required this.customer_id,
    required this.order_code,
    required this.order_note,
    required this.order_price,
    required this.roles_code,
    required this.roles_name,
    required this.room_to,
    required this.status_code,
    required this.status_id,
    required this.status_name,
    required this.system_accept,
    required this.system_key,
    required this.system_order_id,
    required this.total_order_item,
    required this.transport_status,
    required this.type_level,
    required this.type_name,
    required this.type_rules_id,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        order_id: json['order_id'],
        account_from: json['account_from'],
        transport_id: json['transport_id'],
        account_name: json['account_name'],
        account_system: json['account_system'],
        address_from: json['address_from'],
        address_to: json['address_to'],
        created_at: json['created_at'],
        customer_id: json['customer_id'],
        order_code: json['order_code'],
        order_note: json['order_note'],
        order_price: json['order_price'],
        roles_code: json['roles_code'],
        roles_name: json['roles_name'],
        room_to: json['room_to'],
        status_code: json['status_code'],
        status_id: json['status_id'],
        status_name: json['status_name'],
        system_accept: json['system_accept'],
        system_key: json['system_key'],
        system_order_id: json['system_order_id'],
        total_order_item: json['total_order_item'],
        transport_status: json['transport_status'],
        type_level: json['type_level'],
        type_name: json['type_name'],
        type_rules_id: json['type_rules_id'],
      );
}
