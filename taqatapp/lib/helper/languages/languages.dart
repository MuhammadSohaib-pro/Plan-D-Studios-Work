import 'package:get/get.dart';
import 'package:taqat/helper/languages/arabic.dart';
import 'package:taqat/helper/languages/english.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': english,
        'ar_EG': arabic,
        'ar_MA': arabic,
      };
}
