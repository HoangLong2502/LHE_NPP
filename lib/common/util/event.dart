import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

bool checkValidate(GlobalKey<FormState> key) {
  var err = key.currentState!.validate();
  if (err) {
    return true;
  }
  return false;
}

bool isValidEmail(String value) {
  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
}

String get getEEE {
  var eee = DateFormat('EEE').format(DateTime.now());
  switch (eee) {
    case 'Mon':
      return 'Thứ 2';
    case 'Tue':
      return 'Thứ 3';
    case 'Wed':
      return 'Thứ 4';
    case 'Thu':
      return 'Thứ 5';
    case 'Fri':
      return 'Thứ 6';
    case 'Sat':
      return 'Thứ 7';
    case 'Sun':
      return 'Chủ Nhật';
    default:
      return 'Thứ 2';
  }
}

String FormatCurrency(value) {
  final oCcy = NumberFormat("#,##0", "en_US");
  return oCcy.format(value);
}