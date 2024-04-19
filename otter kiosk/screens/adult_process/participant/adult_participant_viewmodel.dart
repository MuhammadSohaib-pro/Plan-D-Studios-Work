import 'package:kiosk/helper/get_state.dart';

import '../../../libraries.dart';

class AdultParticipantViewModel extends GetxController {
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
  TextEditingController identificationTypeController = TextEditingController();
  TextEditingController identificationCountryController =
      TextEditingController();
  TextEditingController idStateController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();

  bool isNumberValid = false;

  // RxString countryCode = '+1'.obs;
  // RxString country = ''.obs;
  // RxString state = ''.obs;
  // RxString city = ''.obs;
  RxString countryCode = 'US'.obs;

  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'US');
  List<String> genderList = [
    "--Select--".tr,
    "Male".tr,
    "Female".tr,
  ];
  String birthdate = "";
  var selectedImage = Rx<ImageProvider?>(null);

  GlobalKey<CSCPickerState> cscPickerKey = GlobalKey();

  int genderIndex = 0;
  RxBool receiveTxtMessges = true.obs;
  RxBool receiveEmails = true.obs;
  RxString FLnamecheck = "".obs;

  final addressformkey = GlobalKey<FormState>();
  final identificationformkey = GlobalKey<FormState>();
  final firstlastnameformkey = GlobalKey<FormState>();
  final emailformkey = GlobalKey<FormState>();
  final phoneformkey = GlobalKey<FormState>();
  final RxBool isFormValid = false.obs;
  final RxBool isaddressFormValid = false.obs;
  final RxBool isidentificationFormValid = false.obs;
  RxString dropdownValue = ''.obs;
  RxString idstatedropdown = ''.obs;
  String selectedName = '';
  List idlist = [
    'Valid Driver\'s License',
    'State-issued Identification Card',
    'Military Identification Card',
    'Passport or Passport Card'
  ];
  RxString iddropdown = 'Valid Driver\'s License'.obs;
  @override
  void onInit() {
    super.onInit();
    //initCamera();
    getstate();
  }

  getstate() async {
    StateGet.fetchData("United States");
    await Future.delayed(Duration(milliseconds: 500));
    dropdownValue.value = StateGet.model.value.states![0].stateCode!;
    idstatedropdown.value = StateGet.model.value.states![0].stateCode!;
  }

  @override
  void onReady() {
    super.onReady();
    initCamera();
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
    print(phoneformkey.currentState?.validate());
    if (firstlastnameformkey.currentState?.validate() == true &&
        emailformkey.currentState?.validate() == true &&
        isNumberValid) {
      isFormValid.value = true;
    } else {
      isFormValid.value = false;
    }
  }

  void validateaddressForm() {
    // if (GlobalVariables.datamodel.addressRequired == true) {
    if (addressformkey.currentState?.validate() == true) {
      isaddressFormValid.value = true;
    } else {
      isaddressFormValid.value = false;
    }
    // }
  }

  void validateidentificationForm() {
    // if (GlobalVariables.datamodel.identificationRequired == true) {
    if (identificationformkey.currentState?.validate() == true) {
      isidentificationFormValid.value = true;
    } else {
      isidentificationFormValid.value = false;
    }
    // }
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
        state: dropdownValue.value,
        street: addressController.text,
        identificationType: iddropdown.value,
        identificationcountry: identificationCountryController.text,
        identificationid: idNumberController.text,
        identificationstate: idstatedropdown.value);
  }

  Future<void> disposeCamera() async {
    print("hello world");
    await photocontroller.dispose();
  }

  @override
  void onClose() {
    photocontroller.dispose();
    selectedImage.close();
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
    identificationTypeController.dispose();
    identificationCountryController.dispose();
    idStateController.dispose();
    idNumberController.dispose();
    receiveEmails.value = false;
    receiveTxtMessges.value = false;
    // countryCode.value = '+1';
    genderIndex = 0;
    super.onClose();
  }
}
