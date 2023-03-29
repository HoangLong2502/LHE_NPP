import 'package:lhe_npp/common/util/convert/selectItem.dart';

class RoomModel with ConvertSelectItem {
  int id;
  String room_name;
  String system_key;

  RoomModel({
    required this.id,
    required this.room_name,
    required this.system_key,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) => RoomModel(
        id: json['id'],
        room_name: json['room_name'],
        system_key: json['system_key'],
      );

  @override
  Map<String, dynamic> toJsonSelectItem() {
    var json = {
      'category_name' : room_name,
      'value' : id
    };

    return json;
  }
}
