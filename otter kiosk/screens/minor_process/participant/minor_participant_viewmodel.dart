import '../../../libraries.dart';

class MinorParticipantViewModel extends GetxController {
  List<CustomTextEditingController> controllerList = [];
  int totalMinors = 0;
  RxBool isFormValid = false.obs;
  @override
  void onInit() {
    final AdultProcessViewModel viewModel = Get.find();
    if (viewModel.selectedMinorBtn.value != "") {
      totalMinors = int.parse(viewModel.selectedMinorBtn.value);
      for (int i = 0; i < totalMinors; i++) {
        controllerList.add(CustomTextEditingController(
          dateController: TextEditingController(),
          fNameController: TextEditingController(),
          lNameController: TextEditingController(),
          genderController: TextEditingController(),
          dob: "",
          genderList: ["--Select--", "Male", "Female"],
          genderIndex: 0,
        ));
      }
    }
    super.onInit();
  }

  void validateForm() {
    if (FnameandLnameformkey.currentState?.validate() == true) {
      isFormValid.value = true;
    } else {
      isFormValid.value = false;
    }
  }

  List<Map<String, String>> list = [];
  storewaivermodel() {
    list.clear();
    controllerList.forEach((element) {
      Map<String, String> minorparticpant = {
        "firstName": element.fNameController.text,
        "lastName": element.lNameController.text,
        "dob": element.dob,
        "gender": element.genderController.text,
      };

      list.add(minorparticpant);
    });
    StorewaiverModel.instance.updateData(minorlist: list);
  }

  RxString fnamecheckfields = "".obs;
  RxString lnamecheckfields = "".obs;
  RxString gendercheckfields = "".obs;
  RxString dobcheckfields = "".obs;
  GlobalKey<FormState> FnameandLnameformkey = GlobalKey<FormState>();
  @override
  void onClose() {
    for (int i = 0; i < totalMinors; i++) {
      controllerList[i].genderController.dispose();
      controllerList[i].lNameController.dispose();
      controllerList[i].fNameController.dispose();
      controllerList[i].dateController.dispose();
      controllerList[i].genderIndex = 0;
    }
    super.onClose();
  }
}
