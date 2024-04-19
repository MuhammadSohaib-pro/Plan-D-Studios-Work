
import 'package:get/get.dart';
import 'package:taqat/helper/global_variables.dart';


class AddLabor5ViewModel extends GetxController {
  @override
  void onClose() {
    GlobalVariables.showLoader.value = false;
    super.onClose();
  }
}
