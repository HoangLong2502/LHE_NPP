class UserModel {
  int? id;
  String? fullname;
  String? username;
  String? email;
  String? account_code;
  String? system_key;

  UserModel({
    required this.id,
    required this.fullname,
    required this.username,
    required this.email,
    required this.account_code,
    required this.system_key,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.fullname = json['fullname'];
    this.username = json['username'];
    this.email = json['email'];
    this.account_code = json['account_code'];
    this.system_key = json['system_key'];
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['id'] = this.id;
    data['fullname'] = this.fullname;
    data['username'] = this.username;
    data['email'] = this.email;
    data['account_code'] = this.account_code;
    data['system_key'] = this.system_key;

    return data;
  }
}