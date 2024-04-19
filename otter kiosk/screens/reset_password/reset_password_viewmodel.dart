import 'package:graphql_flutter/graphql_flutter.dart';

import '../../libraries.dart';

class ResetPasswordViewModel extends GetxController {
  GlobalKey<FormState> resetKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  resetBtn() async {
    if (resetKey.currentState!.validate()) {
      CommonFunctions.closeKeyboard();
      GlobalVariables.showLoader.value = true;
      Map<String, dynamic> param = {
        'input': emailController.text,
      };
      String query = """
          mutation sendPasswordResetCode(\$input: String!)  {
            sendPasswordResetCode(input: \$input) {
              sent
              message
            }
          }
      """;
      await ApiBaseHelper()
          .postMethod(
              httpLink: HttpLink(Urls.baseURL),
              documentNode: query,
              inputVariable: param)
          .then((parsedJson) {
        GlobalVariables.showLoader.value = false;
        if (parsedJson['message'] == "Account does not exist") {
          GetxHelper.showSnackBar(
              title: "Error", message: "Account does not exist");
        } else {
          Get.back();
          GetxHelper.showSnackBar(
              title: "Success",
              message: "Password reset successfully! Check your email.");
        }
      }).catchError((e) {
        GlobalVariables.showLoader.value = false;
        print(e);
      });
    }
  }
}
