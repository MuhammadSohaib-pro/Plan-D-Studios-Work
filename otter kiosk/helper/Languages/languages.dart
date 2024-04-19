import 'package:kiosk/helper/Languages/english.dart';
import 'package:kiosk/helper/Languages/epanol.dart';
import 'package:kiosk/helper/Languages/francais.dart';
import 'package:kiosk/libraries.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys =>
      {'en_US': english, 'es_ESP': spanish, 'fr_FRA': french};
}
