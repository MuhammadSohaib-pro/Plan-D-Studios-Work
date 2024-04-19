import '../../../libraries.dart';

class ParagraphQuestionViewModel extends GetxController {
  TextEditingController questionController = TextEditingController();
  RxString value = ''.obs;
  @override
  void onInit() {
    super.onInit();
    getdata();
  }

  String questid = "";
  String question = "";
  bool required = false;
  final validatekey = GlobalKey<FormState>();
  final singlequestionkey = GlobalKey<FormState>();

  void getdata() {
    GlobalVariables.datamodel.additionalFields!.forEach(
      (element) {
        if (element.type == "paragraph") {
          questid = element.questionId!;
          question = element.question!;
          required = element.required!;
        }
      },
    );
  }

  storewaiverModel() {
    MultipleLinequestion multipleline = MultipleLinequestion(
      questionid: questid,
      answer: questionController.text,
      options: [],
    );
    StorewaiverModel.instance.updateData(multipleLinequestion: multipleline);
  }

  @override
  void onClose() {
    questionController.dispose();

    super.onClose();
  }
}
