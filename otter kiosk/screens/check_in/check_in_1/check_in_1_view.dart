import '../../../libraries.dart';

class CheckIn1View extends StatelessWidget {
  CheckIn1View({super.key});
  final CheckIn1ViewModel viewModel = Get.put(CheckIn1ViewModel());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            imageContainer(),
          ],
        ),
      )),
    );
  }

  Widget imageContainer() {
    return Container(
      height: Get.height,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bullets.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          welcomeTxt(),
          pleaseCheckInTxt(),
          SizedBox(height: 10),
          countryPicker(),
        ],
      ),
    );
  }

  Widget welcomeTxt() {
    return Text(
      "WELCOME",
      style: TextStyle(
        fontSize: 63,
        color: ThemeColors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget pleaseCheckInTxt() {
    return Text(
      "PLEASE CHECKIN",
      style: TextStyle(
        fontSize: 35,
        color: ThemeColors.white,
      ),
    );
  }

  Widget countryPicker() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: countryFlagTextField(
        keyboardType: TextInputType.text,
        initialValue: viewModel.countryCode.value,
        controller: viewModel.nationalityController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return CommonFunctions.validateDefaultTxtField(value!);
        },
        onChanged: (val) {
          viewModel.nationalityController.text = val.toCountryStringOnly();
          Get.to(() => CheckIn2View());
        },
      ),
    );
  }
}
