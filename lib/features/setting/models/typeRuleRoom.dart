import 'package:lhe_npp/features/setting/models/room.dart';

class TypeRuleRoomModel {
  String system_key;
  String roles_code;
  Map<String, dynamic>? type_rules_room;
  int step;
  List<RoomModel>? listSelect;

  TypeRuleRoomModel({
    required this.roles_code,
    required this.step,
    required this.system_key,
    required this.type_rules_room,
  });

  factory TypeRuleRoomModel.fromJson(Map<String, dynamic> json) =>
      TypeRuleRoomModel(
        roles_code: json['roles_code'],
        step: json['step'],
        system_key: json['system_key'],
        type_rules_room: json['type_rules_room'],
      );
}
