import '../../../libraries.dart';

class SingleLineQuestionViewModel extends GetxController {
  TextEditingController questionController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    getdata();
  }

  String questid = "";
  String question = "";
  bool required = false;
  RxString value = ''.obs;

  final singlequestionkey = GlobalKey<FormState>();
  void getdata() {
    GlobalVariables.datamodel.additionalFields!.forEach(
      (element) {
        if (element.type == "shortAnswer") {
          questid = element.questionId!;
          question = element.question!;
          required = element.required!;
        }
      },
    );
  }

  storewaiverModel() {
    SingleLinequestion singleline = SingleLinequestion(
      questionid: questid,
      answer: questionController.text,
      options: [],
    );
    StorewaiverModel.instance.updateData(singleLinequestion: singleline);
  }

  @override
  void onClose() {
    questionController.dispose();
    super.onClose();
  }
}
