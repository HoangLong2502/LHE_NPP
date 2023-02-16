import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common/routes/app_pages.dart';
import 'common/routes/app_routes.dart';
import 'common/services/auth_service.dart';
import 'common/services/notification/notification.dart';
import 'constants/app_colors.dart';
import 'constants/app_typography.dart';
import 'constants/constans.dart';
import 'features/authentication/presentation/login/login_binding.dart';
import 'local storage/app_shared_preference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPreference.instance.initSharedPreferences();
  await Get.putAsync(() => AuthService().init());

  // config firebase FCM noti
  await NotiService.intinializeNotiService();
  FirebaseMessaging.onBackgroundMessage(NotiService.firebaseMessagingBackroundHandler);
  await NotiService.getDeviceToken();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final authService = Get.find<AuthService>();

  get getToken {
    final dynamic token =
        AppSharedPreference.instance.getValue(PrefKeys.TOKEN);
    return token;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // translations: LocaleString(),
      // locale: LocaleString.locale,
      // locale: LocaleString.locale,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.whiteColor,
        fontFamily: 'Helvetica',
        primaryColor: const Color.fromRGBO(0, 174, 239, 1),
        buttonTheme: const ButtonThemeData(
          buttonColor: AppColors.mainColor,
        ),
        appBarTheme: AppBarTheme(
          elevation: 2,
          backgroundColor: AppColors.whiteColor,
          iconTheme: const IconThemeData(
            color: AppColors.blackColor,
          ),
          titleTextStyle: AppTypography.h4.copyWith(
            color: AppColors.blackColor,
          ),
        ),
      ),
      initialBinding: LoginBinding(),
      // home: authService.isAuth.value ? HomeScreen() : LoginScreen(),
      initialRoute: Routes.routeHomeScreen,
      getPages: AppPages.routes,
      onGenerateRoute: (RouteSettings settings) {
        if (!authService.isAuth.value) {
          return Get.offNamed(Routes.routeLogin) as Route;
        } 
        return settings.name as Route;
      },
      
    );
  }
}
