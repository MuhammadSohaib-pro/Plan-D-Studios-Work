import '../../libraries.dart';

class ScreenSaverViewModel extends GetxController {
  TextEditingController timeController = TextEditingController();
  List<String> timeList = ["5", "10", "15", "20", "30", "40", "50", "60"];
  int timeIndex = 0;
}
