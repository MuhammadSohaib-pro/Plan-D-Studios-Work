import '../../../libraries.dart';

class HearAboutUsViewModel extends GetxController {
  RxBool searchSEngineheckBox = false.obs;
  RxBool familyCheckBox = false.obs;
  RxBool socialMediaCheckBox = false.obs;
  RxBool blogCheckBox = false.obs;
  RxBool radioCheckBox = false.obs;
  RxBool televisionCheckBox = false.obs;
  RxBool streamingCheckBox = false.obs;
  RxBool billBoardCheckBox = false.obs;
  RxBool emailCheckBox = false.obs;
  RxBool otherCheckBox = false.obs;

  @override
  void onClose() {
    searchSEngineheckBox.value = false;
    familyCheckBox.value = false;
    socialMediaCheckBox.value = false;
    blogCheckBox.value = false;
    radioCheckBox.value = false;
    televisionCheckBox.value = false;
    streamingCheckBox.value = false;
    billBoardCheckBox.value = false;
    emailCheckBox.value = false;
    otherCheckBox.value = false;
    super.onClose();
  }

  List all = [];
  storewaiverModel() {
    searchSEngineheckBox.value
        ? all.add('Search Engine (Google, Bing, etc)')
        : null;
    familyCheckBox.value ? all.add('Family / Friend / Coworker') : null;
    socialMediaCheckBox.value ? all.add('Social Media') : null;
    blogCheckBox.value ? all.add('Blog or publication') : null;
    radioCheckBox.value ? all.add('Radio') : null;
    televisionCheckBox.value ? all.add('Television') : null;
    streamingCheckBox.value ? all.add('Streaming Service Ad') : null;
    billBoardCheckBox.value ? all.add('Billboard') : null;
    emailCheckBox.value ? all.add('Email') : null;
    otherCheckBox.value ? all.add('Other') : null;
    StorewaiverModel.instance.updateData(hearaboutus: all);
  }
}
