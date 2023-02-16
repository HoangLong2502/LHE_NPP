class Api {
  static String KEY = 'NPP';

  static String baseURL = 'https://api.thachlonghai.co';
  static String login = '$baseURL/micro-account-test/account/api/login';
  static String customer = '$baseURL/v1/api/ot/';

  static String product = '$baseURL/micro-product-test/product/api';
  static String product_create = '$baseURL/micro-product/product/api/create_product';

  static String category = '$baseURL/micro-product/categories/api/get_categories';
  static String category_create = '$baseURL/micro-product/categories/api/create_categories';

  static String order = '$baseURL/micro-order-test/order/api';
  static String order_detail = '$baseURL/micro-order-test/order/api/detail_order';
  static String order_confirm = '$baseURL/micro-order-test/order/api/confirm_order';
  
  // account_service
  static String user = '$baseURL/micro-account/account/api/get_all';
  static String user_by_admin = '$baseURL/micro-account/account/api/get_account_by_admin';
  static String profile_by_system = '$baseURL/micro-account/account/api/get_profile_by_system';
  static String register = '$baseURL/micro-account/account/api/register';

  static String group = '$baseURL/micro-account/room/api/get_room_by_system';
  static String group_create = '$baseURL/micro-account/room/api/create_room';

  // Warehouse
  static String warehouse = '$baseURL/micro-warehouse-test';
}


