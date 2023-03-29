import 'package:lhe_npp/common/util/enum/status_type_order.dart';

class TypeModel {
  int? id;
  String? type_name;
  String? type_code;
  int? type_level;
  String? created_at;
  String? updated_at;
  int? user_created;
  int? user_updated;
  StatusTypeUse? isUse;

  TypeModel({
    required this.created_at,
    required this.id,
    required this.type_code,
    required this.type_level,
    required this.type_name,
    required this.updated_at,
    required this.user_created,
    required this.user_updated,
    required this.isUse,
  });

  bool check() {
    return true;
  }

  factory TypeModel.fromJson(Map<String, dynamic> json) => TypeModel(
        created_at: json['created_at'],
        id: json['id'],
        type_code: json['type_code'],
        type_level: json['type_level'],
        type_name: json['type_name'],
        updated_at: json['updated_at'],
        user_created: json['user_created'],
        user_updated: json['user_updated'],
        isUse: json['isUse'],
      );
}
