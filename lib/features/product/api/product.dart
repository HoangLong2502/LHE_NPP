import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/util/api.dart';
import '../../../common/util/base_dio.dart';
import '../../../common/constants/constans.dart';
import '../../../local storage/app_shared_preference.dart';

class ProductService {
  final _dio = BaseDio();
  Future<List> getAllProduct() async {
    try {
      var user = json.decode(AppSharedPreference.instance.getValue(PrefKeys.USER));

      var payload = {
        "page": "0",
        "page_size": "10",
        "system_key": Api.KEY,
        "account_id": user['id'].toString()
      };
      var res = await _dio.dio().post(Api.product, data: payload);
      List product = res.data['data']['results'];

      return product;
    } catch (err) {
      return [];
    }
  }

  Future<bool> createproduct(
    int category_id,
    List formula,
    String product_description,
    List<XFile> product_image,
    String product_name,
  ) async {
    try {
      var user =
          json.decode(AppSharedPreference.instance.getValue(PrefKeys.USER));

      var formula_convert = formula.map((e) {
        return {
          'formula_label': e['formula_label'],
          'formula_name': e['formula_name'],
          'formula_price': [
            {"type_code": "RETAIL", "price": e['formula_price_retail'].text},
            {"type_code": "BIN", "price": e['formula_price_per_box'].text}
          ],
          // 'formula_price_per_box': e['formula_price_per_box'].text,
          // 'formula_price_retail': e['formula_price_retail'].text,
          'isChosed': e['isChosed'],
          'isError': e['isError'],
          'number_in_box': e['number_in_box'].text,
          'options': e['options']
        };
      }).toList();

      var data = {
        'account_id': user['id'],
        'category': [category_id],
        'description': product_description,
        'product_image': "ádsdsadsadsadasds",
        // product_image.map((e) => File(e.path).path).toList()
        'product_name': product_name,
        'system_key': PrefKeys.KEY,
        'user_id': user['id'],
        'formula': formula_convert,
      };

      print(data);

      var res = await _dio.dio().post(Api.product_create, data: data);
      print(res);
      if (res.data['code'] == 200) {
        return true;
      } else
        return false;
    } catch (err) {
      debugPrint('err : $err');
      return false;
    }
  }
}
