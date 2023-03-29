import 'package:get/get.dart';

import '../../../../common/services/auth_service.dart';
import '../../../../common/constants/constans.dart';
import '../../../../local storage/app_shared_preference.dart';

class LogoutController extends GetxController {
  Future<void> handleLogout() async {
    var auth = Get.find<AuthService>();
    auth.setIsAuth(false);
    await AppSharedPreference.instance.remove(PrefKeys.TOKEN);
    await AppSharedPreference.instance.remove(PrefKeys.USER);

    // Get.offAndToNamed(Routes.routeHomeScreen);
  }
}