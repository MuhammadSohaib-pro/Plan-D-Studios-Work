import 'package:graphql_flutter/graphql_flutter.dart';

import '../../libraries.dart';

class LoginViewModel extends GetxController {
  GlobalKey<FormState> LogInKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool obsecurePassword = true.obs;

  // @override
  // void onClose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.onClose();
  // }

  loginBtn() async {
    if (LogInKey.currentState!.validate()) {
      CommonFunctions.closeKeyboard();
      GlobalVariables.showLoader.value = true;
      Map<String, dynamic> param = {
        'input': {
          'email': emailController.text,
          'password': passwordController.text
        }
      };
      String query = """
          mutation basicLogin(\$input: LoginInput!) {
            basicLogin(input: \$input) {
              token
              account {
                id
                email
                firstName
                lastName
                phone
                profileCompleted
                provider
                createdById
                permission {
                    module
                    show
                    access {
                      create
                      update
                      delete
                    }
                    features {
                      name
                      enabled
                    }
                }
            }
         }
      }
      """;
      await ApiBaseHelper()
          .postMethod(
        httpLink: HttpLink(
          Urls.baseURL,
        ),
        documentNode: query,
        inputVariable: param,
      )
          .then((parsedJson) async {
        GlobalVariables.showLoader.value = false;
        if (parsedJson['message'] == "Invalid login credentials" ||
            parsedJson['message'].toString().contains("incorrect")) {
          GetxHelper.showSnackBar(
              title: "Error", message: "Invalid Login Credentials");
          errorDialog();
        } else if (parsedJson['message'] == "Bad Request Exception") {
          GetxHelper.showSnackBar(
              title: "Error",
              message: "Password characters must be atleast 6 characters");
        } else {
          GlobalVariables.token = parsedJson['basicLogin']['token'] ?? '';
          GlobalVariables.userModel.value =
              UserModel.fromJson(parsedJson['basicLogin']['account']);
          GetStorage().write('token', parsedJson['basicLogin']['token'] ?? '');
          GetStorage().write('user', parsedJson['basicLogin']['account']);
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('checklogin', true);
          if (GlobalVariables.token == "") {
            Get.to(() => TwoStepVerificationEmailView());
          } else {
            Get.to(() => HomeUnlockView());
          }
        }
      }).catchError((e) {
        GlobalVariables.showLoader.value = false;
        print(e);
      });
    }
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
            // height: 295,
            // width: 315,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
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
                SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
