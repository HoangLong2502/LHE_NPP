class Api {
  static String KEY = 'NPP';
  static String ENV = 'test'; //prod || test

  static String baseURL = 'https://api.thachlonghai.co';
  static String login = '$baseURL/micro-account-$ENV/account/api/login';
  static String refresh_token = '$baseURL/micro-account-$ENV/account/api/refresh_token';
  static String customer = '$baseURL/v1/api/ot/';

  static String product = '$baseURL/micro-product-$ENV/product/api';
  static String product_create = '$baseURL/micro-product-$ENV/product/api/create_product';

  static String category = '$baseURL/micro-product-$ENV/categories/api/get_categories';
  static String category_create = '$baseURL/micro-product-$ENV/categories/api/create_categories';

  static String order = '$baseURL/micro-order-$ENV/order/api';
  static String order_detail = '$baseURL/micro-order-$ENV/order/api/detail_order';
  static String order_confirm = '$baseURL/micro-order-$ENV/order/api/confirm_order';
  static String type = '$baseURL/micro-order-$ENV/type/api';
  
  // account_service
  static String user = '$baseURL/micro-account-$ENV/account/api/get_all';
  static String user_by_admin = '$baseURL/micro-accoun-$ENV/account/api/get_account_by_admin';
  static String profile_by_system = '$baseURL/micro-account-$ENV/account/api/get_profile_by_system';
  static String register = '$baseURL/micro-account-$ENV/account/api/register';
  static String all_system = '$baseURL/micro-account-$ENV/system/api';

  static String group = '$baseURL/micro-account-$ENV/room/api/get_room_by_system';
  static String group_create = '$baseURL/micro-account-$ENV/room/api/create_room';

  // Warehouse
  static String warehouse = '$baseURL/micro-warehouse-$ENV';

  //Room
  static String room = '$baseURL/micro-account-$ENV/room/api';
}


