import 'package:get/get.dart';

class Controller extends GetxController {
  bool loading = false;
  var loading1 = true.obs;

  void loddder(bool value) {
    loading = value;
    update();
  }
}
