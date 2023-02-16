class ConsignmentModel {
  int consignment_id;
  String created_at;
  String import_from;
  String consignment_code;
  String checker;
  String date_of_manufacture;
  String expiration_date;
  dynamic quantity;
  String amount_type;

  ConsignmentModel({
    required this.consignment_id,
    required this.created_at,
    required this.import_from,
    required this.consignment_code,
    required this.checker,
    required this.date_of_manufacture,
    required this.expiration_date,
    required this.quantity,
    required this.amount_type,
  });

  factory ConsignmentModel.fromJson(Map<String, dynamic> json) =>
      ConsignmentModel(
        consignment_id: json['consignment_id'],
        created_at: json['created_at'],
        import_from: json['import_from'],
        consignment_code: json['consignment_code'],
        checker: json['checker'],
        date_of_manufacture: json['date_of_manufacture'],
        expiration_date: json['expiration_date'],
        quantity: json['quantity'],
        amount_type: json['amount_type'],
      );

  Map<String, dynamic> toJsonCreateRe(String amountTypeCode,int amount) {
    var data = <String, dynamic>{};
    data['consignment_code'] = consignment_code;
    data['amount_type_code'] = amountTypeCode;
    data['amount'] = amount;

    return data;
  } 
}
