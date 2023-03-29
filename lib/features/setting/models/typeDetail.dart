import 'package:lhe_npp/features/setting/models/typeRuleRoom.dart';

class TypeDetailModel {
  int id;
  List<TypeRuleRoomModel> type_rules_room;
  String type_name;
  String type_code;
  int type_level;
  String created_at;
  String updated_at;
  int user_created;
  int user_updated;

  TypeDetailModel(
      {required this.created_at,
      required this.id,
      required this.type_code,
      required this.type_level,
      required this.type_name,
      required this.type_rules_room,
      required this.updated_at,
      required this.user_created,
      required this.user_updated});

  factory TypeDetailModel.fromJson(Map<String, dynamic> json) =>
      TypeDetailModel(
        created_at: json['created_at'],
        id: json['id'],
        type_code: json['type_code'],
        type_level: json['type_level'],
        type_name: json['type_name'],
        type_rules_room: (json['type_rules_room'] as List)
            .map((e) => TypeRuleRoomModel.fromJson(e))
            .toList(),
        updated_at: json['updated_at'],
        user_created: json['user_created'],
        user_updated: json['user_updated'],
      );

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['created_at'] = created_at;
    return data;
  }
}
