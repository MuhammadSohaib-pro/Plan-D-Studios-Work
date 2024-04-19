import '../../libraries.dart';

class GroupViewModel extends GetxController {
  TextEditingController groupController = TextEditingController();
  RxString selectedGroup = "".obs;
  List<String> groupList = [
    "--Select--"
        "Nelson Family Raft Group",
    "Clarks Family Renunie",
    "Kenny Smith",
    "YMCA Summer Camp"
  ];
  int groupIndex = 0;

  @override
  void onClose() {
    groupController.dispose();
    selectedGroup.value = '';
    groupIndex = 0;
    super.onClose();
  }
}
