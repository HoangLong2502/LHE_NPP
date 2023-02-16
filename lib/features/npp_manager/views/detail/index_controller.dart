import 'package:get/get.dart';

class DetailNPPController extends GetxController {
  var dataProfile = {}.obs;

  updateDataProfile(value) {
    dataProfile.value = value;
    
    update();
  }
}