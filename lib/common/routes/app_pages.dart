import 'package:get/route_manager.dart';
import 'package:lhe_npp/features/order/views/create_export/view.dart';
import 'package:lhe_npp/features/order/views/create_import/view.dart';

import '../../views/Account/index.dart';
import '../../views/Auth/LoginScreen.dart';
import '../../views/Home/HomeScreen.dart';
import '../../views/Map/index.dart';
import '../../views/NPP/detail.dart';
import '../../views/NPP/index.dart';
import '../../views/Order/Detail/index.dart';
import '../../views/Order/index.dart';
import '../../views/Product/CreateProduct/index.dart';
import '../../views/Product/index.dart';
import '../../views/User/create/index.dart';
import '../../views/User/index.dart';
import '../../views/User/type_create/index.dart';
import '../middlewares/middlewares.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.routeHomeScreen;

  static final routes = [

    // HOME SCREEN
    GetPage(
      name: Routes.routeHomeScreen,
      page: () => const HomeScreen(),
      middlewares: [RouteMiddleware()],
    ),

    // LOGIN SCREEN
    GetPage(
      name: Routes.routeLogin,
      page: () => const LoginScreen(),
    ),

    // ORDER
    GetPage(
      name: Routes.routeOrder,
      page: () => const OrderScreen(),
      middlewares: [RouteMiddleware()],
    ),
    GetPage(
      name: Routes.routeOrderDetail,
      page: () => const OrderDetailScreen(),
      middlewares: [RouteMiddleware()],
    ),
    GetPage(
      name: Routes.routeCreateOrderImport,
      page: () => const CreateImportOrder(),
      middlewares: [RouteMiddleware()],
    ),
    GetPage(
      name: Routes.routeCreateOrderExport,
      page: () => const CreateExportOrder(),
      middlewares: [RouteMiddleware()],
    ),

    // ACCOUNT
    GetPage(
      name: Routes.routeAccount,
      page: () => const AccountScreen(),
      middlewares: [RouteMiddleware()],
    ),

    // PRODUCT
    GetPage(
      name: Routes.routeProduct,
      page: () => const ProductScreen(),
      middlewares: [RouteMiddleware()],
    ),
    GetPage(
      name: Routes.routeProductCreate,
      page: () => CreateProductScreen(),
      middlewares: [RouteMiddleware()],
    ),

    // NPP
    GetPage(
      name: Routes.routeNPP,
      page: () => const NppScreen(),
      middlewares: [RouteMiddleware()],
    ),
    GetPage(
      name: Routes.routeDetailNPP,
      page: () => const DetailNPPScreen(),
      middlewares: [RouteMiddleware()],
    ),

    // USER
    GetPage(
      name: Routes.routeUserManager,
      page: () => const UserManagerScreen(),
      middlewares: [RouteMiddleware()],
    ),
    GetPage(
      name: Routes.routeCreateUser,
      page: () => const CreateUserScreen(),
      middlewares: [RouteMiddleware()],
    ),
    // GetPage(
    //   name: Routes.routeCreateUserMapNPP,
    //   page: () => MapPickerNPP(comfirmPosition: null,),
    //   middlewares: [RouteMiddleware()],
    // ),
    GetPage(
      name: Routes.routeTypeCreateUser,
      page: () => const TypeCreateUserScreen(),
      middlewares: [RouteMiddleware()],
    ),

    // GOOGLE MAP
    GetPage(
      name: Routes.routeGoogleMapScreen,
      page: () => const GoogleMapScreen(),
      middlewares: [RouteMiddleware()],
    ),
  ];
}
