import '../../../libraries.dart';

class MultipleChoiceCheckBoxBtnViewModel extends GetxController {
  RxBool value = false.obs;
  @override
  void onInit() {
    super.onInit();
    getdata();
  }

  String questid = "";
  String question = "";
  bool required = false;
  List<Option> option = [];

  final singlequestionkey = GlobalKey<FormState>();

  void getdata() {
    GlobalVariables.datamodel.additionalFields!.forEach(
      (element) {
        if (element.type == "checkbox") {
          questid = element.questionId!;
          question = element.question!;
          required = element.required!;
          element.options!.forEach((element) {
            Option options = Option(label: element.value!, value: false.obs);
            option.add(options);
          });
        }
      },
    );
  }

  List lst = [];
  storewaiverModel() {
    option.forEach((e) {
      if (e.value == true) {
        lst.add({"label": e.label, "value": true});
      }
    });

    Multiplecheckbox checkbox =
        Multiplecheckbox(questionid: questid, answer: '', options: lst);

    StorewaiverModel.instance.updateData(multiplecheckbox: checkbox);
  }

  @override
  void onClose() {
    value.close();
    super.onClose();
  }
}

class Option {
  String label = '';
  RxBool value = false.obs;
  Option({required this.label, required this.value});
}
