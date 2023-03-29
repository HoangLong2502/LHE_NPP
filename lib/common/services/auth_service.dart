import 'package:get/get.dart';

import '../constants/constans.dart';
import '../../local storage/app_shared_preference.dart';

class AuthService extends GetxService {
  Future<AuthService> init() async => this;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    var token = AppSharedPreference.instance.getValue(PrefKeys.TOKEN);
    if (token != null) setIsAuth(true);
    else setIsAuth(false);
  }

  final RxBool isAuth = false.obs;

  void setIsAuth(bool newValue) {
    isAuth.value = newValue;
  }
}