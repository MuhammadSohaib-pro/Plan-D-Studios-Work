import '../../libraries.dart';

class TripDateViewModel extends GetxController {
  TextEditingController dateController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  RxString selectedDate = "".obs;

  @override
  void onClose() {
    dateController.dispose();
    selectedDate.value = '';
    super.onClose();
  }
}
