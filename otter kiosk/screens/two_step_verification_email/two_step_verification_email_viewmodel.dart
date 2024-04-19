import 'package:graphql_flutter/graphql_flutter.dart';

import '../../libraries.dart';

class TwoStepVerificationEmailViewModel extends GetxController {
  GlobalKey<FormState> verificationKey = GlobalKey<FormState>();
  TextEditingController pinController = TextEditingController();

  forwardArrowBtn() async {
    if (verificationKey.currentState!.validate()) {
      CommonFunctions.closeKeyboard();
      GlobalVariables.showLoader.value = true;
      Map<String, dynamic> param = {
        'input': {
          'email': GlobalVariables.userModel.value.email,
          'code': pinController.text,
          'provider': GlobalVariables.userModel.value.provider,
        }
      };
      String query = """
          mutation processEmailOTPLogin(\$input: TokenInput!) {
        processEmailOTPLogin(input: \$input) {
        token,
        account {
            id,
            firstName,
            lastName,
            email,
            phone,
            provider,
            createdById,
            profileCompleted,
            permission {
              module,
              show,
              access {
                create,
                update,
                delete,
              },
              features {
                name,
                enabled,
              }
            }
          }
        }
      }
      """;
      await ApiBaseHelper()
          .postMethod(
        httpLink: HttpLink(Urls.baseURL),
        documentNode: query,
        inputVariable: param,
      )
          .then((parsedJson) {
        GlobalVariables.showLoader.value = false;
        if (parsedJson['message'].toString().contains('not found')) {
          GetxHelper.showSnackBar(
              title: "Error", message: "Verification Code Is Incorrect");
        } else if (parsedJson['message'] == "Invalid OTP provided") {
          GetxHelper.showSnackBar(
              title: "Error", message: "Invalid OTP provided");
        } else {
          GlobalVariables.token =
              parsedJson['processEmailOTPLogin']['token'] ?? '';
          GetStorage().write(
              'token', parsedJson['processEmailOTPLogin']['token'] ?? '');

          Get.to(() => HomeUnlockView());
          GetxHelper.showSnackBar(
              title: "Success", message: "Verification Successfully");
        }
      }).catchError((e) {
        GlobalVariables.showLoader.value = false;
        print(e);
      });
    }
  }

  resendBtn(email, password) async {
    GlobalVariables.showLoader.value = true;
    Map<String, dynamic> param = {
      'input': {'email': email, 'password': password}
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
      GetxHelper.showSnackBar(
          title: 'Verification',
          message: 'Verification code has been resend to $email');
    });
  }
}
