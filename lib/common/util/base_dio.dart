import 'package:dio/dio.dart';

import '../../constants/constans.dart';
import '../../local storage/app_shared_preference.dart';

class BaseDio {
  Dio dio = Dio(
    BaseOptions(
      headers: {
        "authorization":
            "Bearer ${AppSharedPreference.instance.getValue(PrefKeys.TOKEN)}",
        "content-Type": "application/json",
        "accept": "application/json",
      },
    ),
  );
}
