import '../../libraries.dart';

class TwoStepVerificationEmailView extends StatelessWidget {
  TwoStepVerificationEmailView({Key? key}) : super(key: key);

  final TwoStepVerificationEmailViewModel viewModel =
      Get.put(TwoStepVerificationEmailViewModel());

  final LoginViewModel viewModelLogin = Get.put(LoginViewModel());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        appBar: appBar(),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 13),
              child: ScrollableColumn(
                children: [
                  Get.context!.isTablet ? SizedBox() : SizedBox(height: 20),
                  image(),
                  SizedBox(height: 20),
                  twoStepverificationTxt(),
                  SizedBox(height: 20),
                  enterTheVerificationTxt(),
                  SizedBox(height: 20),
                  msgText(),
                  SizedBox(height: 20),
                  txtFormField(),
                  SizedBox(height: 30),
                  resendTxt(),
                  SizedBox(height: 20),
                ],
              ),
            ),
            LoaderView()
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: forwardBackBtnRow(),
      toolbarHeight: 80,
      automaticallyImplyLeading: false,
    );
  }

  Widget forwardBackBtnRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            margin: EdgeInsets.all(10),
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ThemeColors.grey2,
            ),
            child: Icon(
              Icons.arrow_back,
              color: ThemeColors.white,
            ),
          ),
        ),
        SizedBox(),
        GestureDetector(
          onTap: () async {
            // Get.to(() => HomeUnlockView());
            // await viewModel.forwardArrowBtn();
          },
          child: Container(
            margin: EdgeInsets.all(10),
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ThemeColors.grey2,
            ),
            child: Icon(
              Icons.arrow_forward,
              color: ThemeColors.white,
            ),
          ),
        )
      ],
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

  Widget twoStepverificationTxt() {
    return const Text(
      '2-Step Verification',
      style: TextStyle(
        color: ThemeColors.primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget enterTheVerificationTxt() {
    return const Text(
      'Enter the verification code we sent\n in your email',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: ThemeColors.primaryColor,
        fontSize: 16,
      ),
    );
  }

  Widget msgText() {
    return Text(
      'A text message with a verification code was just\n sent to ${viewModelLogin.emailController.text}',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: ThemeColors.grey2,
        fontSize: 14,
      ),
    );
  }

  Widget txtFormField() {
    return Form(
      key: viewModel.verificationKey,
      child: Pinput(
        length: 6,
        mainAxisAlignment: MainAxisAlignment.center,
        controller: viewModel.pinController,
        defaultPinTheme: PinTheme(
          width: 50,
          height: 50,
          textStyle: TextStyle(
              fontSize: 20,
              color: Color.fromRGBO(30, 60, 87, 1),
              fontWeight: FontWeight.w600),
          decoration: BoxDecoration(
            color: ThemeColors.white,
            border: Border.all(
              color: ThemeColors.primaryColor,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        focusedPinTheme: PinTheme(
          width: 50,
          height: 50,
          textStyle: TextStyle(
              fontSize: 20,
              color: ThemeColors.primaryColor,
              fontWeight: FontWeight.w600),
          decoration: BoxDecoration(
            border: Border.all(
              color: ThemeColors.primaryColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        submittedPinTheme: PinTheme(
          width: 50,
          height: 50,
          textStyle: TextStyle(
              fontSize: 20,
              color: ThemeColors.primaryColor,
              fontWeight: FontWeight.w600),
          decoration: BoxDecoration(
            color: Color.fromRGBO(234, 239, 243, 1),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        // validator: (s) {
        //   return s == '222222' ? null : 'Pin is incorrect';
        // },
        scrollPadding: EdgeInsets.only(bottom: 60),
        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        showCursor: false,
        pinContentAlignment: Alignment.center,
        onCompleted: (pin) {
          viewModel.forwardArrowBtn();
        },
      ),
    );
  }

  Widget resendTxt() {
    return TextButton(
      onPressed: () {
        viewModel.resendBtn(viewModelLogin.emailController.text,
            viewModelLogin.passwordController.text);
      },
      child: Text('Resend',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ThemeColors.grey2,
            fontSize: 14,
          )),
    );
  }
}
