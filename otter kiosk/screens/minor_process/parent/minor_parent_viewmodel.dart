import '../../../helper/get_state.dart';
import '../../../libraries.dart';

class MinorParentViewModel extends GetxController {
  TextEditingController genderController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  String birthdate = "";
  RxString countryCode = 'US'.obs;
  PhoneNumber number = PhoneNumber(isoCode: 'US');
  RxBool isFormValid = false.obs;
  RxBool confirmGuardianCheckBox = false.obs;
  RxBool receivesTextMessageCheckBox = false.obs;
  RxBool receivesEmailsCheckBox = false.obs;
  List<String> genderList = ["--Select--", "Male", "Female"];
  RxString dropdownValue = ''.obs;

  int genderIndex = 0;
  // @override
  // void onInit() {
  //   super.onInit();
  //   initCamera();
  // }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    initCamera();
    getstate();
  }

  getstate() async {
    StateGet.fetchData("United States");
    await Future.delayed(Duration(milliseconds: 500));
    dropdownValue.value = StateGet.model.value.states![0].stateCode!;
  }

  CameraController photocontroller =
      CameraController(GlobalVariables.camera[1], ResolutionPreset.medium);

  Future<void> initCamera() async {
    try {
      final cameras =
          await availableCameras(); // Get a list of available cameras
      final camera =
          cameras[1]; // Choose the desired camera (adjust index as needed)
      print(camera);
      photocontroller = CameraController(camera, ResolutionPreset.medium);
      await photocontroller.initialize();
      if (!photocontroller.value.isInitialized) {
        // Handle initialization failure here, e.g., display an error message.
        debugPrint("Camera initialization failed");
      }
    } on CameraException catch (e) {
      // Handle camera exception, display an error message.
      debugPrint("Camera error: $e");
    }
  }

  void validateForm() {
    if (FnameandLnamekey.currentState?.validate() == true) {
      isFormValid.value = true;
    } else {
      isFormValid.value = false;
    }
  }

  storewaivermodel() {
    StorewaiverModel.instance.updateData(
      fname: fNameController.text,
      lname: lNameController.text,
      email: emailController.text,
      phone: phoneController.text,
      gender: genderController.text,
      countrycode: countryCode.value,
      dob: birthdate,
      country: countryController.text,
      city: cityController.text,
      zipcode: zipCodeController.text,
      state: stateController.text,
      street: addressController.text,
    );
  }

  GlobalKey<CSCPickerState> cscPickerKey = GlobalKey();
  RxString country = ''.obs;
  RxString state = ''.obs;
  RxString city = ''.obs;
  final FnameandLnamekey = GlobalKey<FormState>();
  // RxBool legalguardiancheck = false.obs;
  // RxBool messagecheck = false.obs;
  // RxBool subscribecheck = false.obs;

  Future<void> disposeCamera() async {
    print("hello world");
    await photocontroller.dispose();
  }

  @override
  void onClose() {
    photocontroller.dispose();
    genderController.dispose();
    lNameController.dispose();
    fNameController.dispose();
    dateController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    countryController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipCodeController.dispose();
    countryCode.value = '+1';
    confirmGuardianCheckBox.value = false;
    receivesTextMessageCheckBox.value = false;
    receivesEmailsCheckBox.value = false;
    genderIndex = 0;
    super.onClose();
  }
}
