import 'package:get/get.dart';
import 'package:taqat/helper/global_variables.dart';

class EnlargeImageViewModel extends GetxController {
  String imageUrl = "";

  @override
  void onInit() {
    super.onInit();
    imageUrl = Get.arguments["imageUrl"];
    print(imageUrl);
  }

  @override
  void onClose() {
    super.onClose();
    GlobalVariables.showLoader.value = false;
  }
}
