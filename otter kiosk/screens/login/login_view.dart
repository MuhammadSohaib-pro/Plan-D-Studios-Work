import '../../libraries.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final LoginViewModel viewModel = Get.put(LoginViewModel());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: ScrollableColumn(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 150, bottom: 20),
                    child: SvgPicture.asset(
                      'assets/svg/logo1.svg',
                      height: 80,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Form(
                    key: viewModel.LogInKey,
                    child: Column(
                      children: [
                        emailTextField(),
                        passwordTextField(),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment:
                        Get.context!.isTablet && Get.context!.isLandscape
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.end,
                    children: [
                      resetPassword(),
                    ],
                  ),
                  SizedBox(height: 12),
                  loginButton(),
                  SizedBox(height: 12),
                  privacyPolicyText(),
                  SizedBox(height: 25),
                  SizedBox(
                    width: 94.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: doNotHaveAccount()),
                        SizedBox(width: 15),
                        Flexible(child: signUpForFree()),
                      ],
                    ),
                  ),
                  Expanded(
                      child: SizedBox(
                    height: 30,
                  )),
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

  Widget emailTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 200
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 4.5
                  : Get.context!.isPhone && Get.context!.isLandscape
                      ? 30
                      : 0),
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
    );
  }

  Widget passwordTextField() {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 200
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 4.5
                  : Get.context!.isPhone && Get.context!.isLandscape
                      ? 30
                      : 0,
        ),
        child: CustomTextField2(
          hint: 'Password',
          title: "Password",
          fillColor: ThemeColors.white,
          controller: viewModel.passwordController,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          obscureText: viewModel.obsecurePassword.value,
          keyboardType: TextInputType.text,
          suffixIcon: InkWell(
            onTap: () {
              viewModel.obsecurePassword.value =
                  !viewModel.obsecurePassword.value;
            },
            child: Icon(
              (viewModel.obsecurePassword.value)
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: ThemeColors.grey2,
            ),
          ),
          validator: (value) {
            return CommonFunctions.validateDefaultTxtField(value);
          },
        ),
      ),
    );
  }

  Widget resetPassword() {
    return Padding(
      padding: Get.context!.isTablet && Get.context!.isLandscape
          ? EdgeInsets.only(left: Get.width / 4)
          : Get.context!.isTablet && Get.context!.isPortrait
              ? EdgeInsets.only(right: Get.width / 4.5)
              : Get.context!.isPhone && Get.context!.isLandscape
                  ? EdgeInsets.only(right: 30.0)
                  : EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: () async {
          Get.to(() => ResetPasswordView());
        },
        child: Text(
          "Reset Password",
          style: TextStyle(
            fontSize: 14,
            color: ThemeColors.primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget loginButton() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 300
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 4.5
                  : Get.context!.isPhone && Get.context!.isLandscape
                      ? 30
                      : 0),
      child: CustomElevatedBtn(
        foregroundColor: Colors.grey,
        backgroundColor: ThemeColors.primaryColor,
        onPressed: () async {
          await viewModel.loginBtn();

          // Get.to(() => HomeUnlockView());
        },
        child: const Text(
          'LOGIN',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Future<dynamic> errorDialog() {
    return showDialog(
      context: Get.context!,
      builder: (context) {
        return Dialog(
          shape: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            height: 240,
            width: 315,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  child: Text(
                    "This email is not associated\nwith an account. Please signup\nonline or reach out to your\norganization to add you to\ntheir team.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      color: ThemeColors.primaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                CustomElevatedBtn(
                  height: 50,
                  width: 278,
                  foregroundColor: Colors.grey,
                  backgroundColor: ThemeColors.primaryColor,
                  onPressed: () async {
                    await launchUrl(
                      Uri.parse("https://app.otterwaiver.com/signup"),
                      mode: LaunchMode.externalNonBrowserApplication,
                    ).onError((error, stackTrace) {
                      print("Error Occured");
                      return true;
                    });
                  },
                  child: const Text(
                    'ACCOUNT SETUP',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget privacyPolicyText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Privacy Policy"),
        SizedBox(width: 5),
        Icon(
          Icons.circle,
          size: 10,
          color: ThemeColors.grey2,
        ),
        SizedBox(width: 5),
        Text("Terms of Service"),
      ],
    );
  }

  Widget doNotHaveAccount() {
    return Text(
      "Don’t Have An Account?",
      style: TextStyle(
        fontSize: 14,
        color: Color(0xff828A89),
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget signUpForFree() {
    return GestureDetector(
      onTap: () async {
        await launchUrl(
          Uri.parse("https://app.otterwaiver.com/signup"),
          mode: LaunchMode.externalNonBrowserApplication,
        ).onError((error, stackTrace) {
          print("Error Occured");
          return true;
        });
      },
      child: Text(
        "Sign Up for free",
        maxLines: 2,
        style: TextStyle(
          fontSize: 14,
          color: ThemeColors.primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
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
