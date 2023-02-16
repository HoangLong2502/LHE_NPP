import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  var step = 1.obs;

  changeStep({required RxInt value}) {
    step = value;
    update();
  }
}