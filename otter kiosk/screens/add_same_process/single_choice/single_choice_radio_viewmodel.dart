import '../../../libraries.dart';

class SingleChoiceRadioBtnViewModel extends GetxController {
  RxString groupValue = "".obs;
  @override
  void onInit() {
    super.onInit();
    getdata();
  }

  String questid = "";
  String question = "";
  bool required = false;
  final singlequestionkey = GlobalKey<FormState>();
  List option = [];
  void getdata() {
    GlobalVariables.datamodel.additionalFields!.forEach(
      (element) {
        if (element.type == "radioButton") {
          questid = element.questionId!;
          question = element.question!;
          required = element.required!;
          element.options!.forEach((element) {
            option.add(element.value);
          });
        }
      },
    );
  }

  storewaiverModel() {
    Singlechoicequestion singlechoice = Singlechoicequestion(
      questionid: questid,
      answer: '',
      label: groupValue.value,
    );
    StorewaiverModel.instance.updateData(singlechoicequestion: singlechoice);
  }

  @override
  void onClose() {
    groupValue.value = "";
    super.onClose();
  }
}
