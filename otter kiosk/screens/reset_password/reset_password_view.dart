import '../../libraries.dart';

class ResetPasswordView extends StatelessWidget {
  ResetPasswordView({Key? key}) : super(key: key);
  final ResetPasswordViewModel viewModel = Get.put(ResetPasswordViewModel());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 13),
              child: ScrollableColumn(
                children: [
                  SizedBox(height: 40),
                  image(),
                  SizedBox(height: 40),
                  resetPasswordTxt(),
                  SizedBox(height: 20),
                  emailTxtField(),
                  SizedBox(height: 20),
                  resetBtn(),
                  SizedBox(height: 10),
                  cantLoginTxt(),
                  SizedBox(height: 60),
                  privacyPolicyTxt(),
                  Expanded(child: SizedBox()),
                  poweredByText(),
                  SizedBox(height: 20),
                ],
              ),
            ),
            const LoaderView()
          ],
        ),
      ),
    );
  }

  Widget image() {
    return Padding(
      padding: const EdgeInsets.only(top: 80, bottom: 20),
      child: SvgPicture.asset(
        'assets/svg/logo1.svg',
        height: 80,
      ),
    );
  }

  Widget resetPasswordTxt() {
    return Text(
      'Reset Password',
      style: TextStyle(
        color: ThemeColors.primaryColor,
        fontSize: 18,
      ),
    );
  }

  Widget emailTxtField() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 400
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 4.5
                  : 0),
      child: Form(
        key: viewModel.resetKey,
        child: CustomTextField2(
          hint: 'Email',
          title: "Email",
          fillColor: ThemeColors.white,
          controller: viewModel.emailController,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            return CommonFunctions.validateDefaultTxtField(value);
          },
        ),
      ),
    );
  }

  Widget resetBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 400
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 4.5
                  : 0),
      child: CustomElevatedBtn(
        foregroundColor: Colors.grey,
        backgroundColor: ThemeColors.primaryColor,
        onPressed: () async {
          await viewModel.resetBtn();
        },
        child: const Text(
          'RESET',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget cantLoginTxt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Can't Log in?"),
        SizedBox(width: 10),
        Icon(
          Icons.circle,
          size: 8,
          color: ThemeColors.grey2,
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: () async {
            await launchUrl(
              Uri.parse("https://app.otterwaiver.com/signup"),
              mode: LaunchMode.externalNonBrowserApplication,
            ).onError((error, stackTrace) {
              print("Error Occurred");
              return true;
            });
          },
          child: Text("Sign up for account"),
        )
      ],
    );
  }

  Widget privacyPolicyTxt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Privacy Policy"),
        SizedBox(width: 10),
        Icon(
          Icons.circle,
          size: 8,
          color: ThemeColors.grey2,
        ),
        SizedBox(width: 10),
        Text("User Notice"),
      ],
    );
  }

  Widget poweredByText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Powered By"),
        SizedBox(width: 10),
        SvgPicture.asset(
          'assets/svg/logo1.svg',
          height: 25,
        ),
      ],
    );
  }
}
