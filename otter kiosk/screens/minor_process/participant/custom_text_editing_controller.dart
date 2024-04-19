import '../../../libraries.dart';

class CustomTextEditingController {
  TextEditingController genderController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String dob = "";
  List<String> genderList = [];
  int genderIndex = 0;

  CustomTextEditingController({
    required this.dateController,
    required this.fNameController,
    required this.lNameController,
    required this.genderController,
    required this.dob,
    required this.genderList,
    required this.genderIndex,
  });
}
