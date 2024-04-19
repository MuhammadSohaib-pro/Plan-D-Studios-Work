import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';

import '../Model Class/state_model.dart';

class StateGet {
  static Rx<CountryModel> model = CountryModel().obs;
  static fetchData(String country) async {
    print(country);
    final String data =
        await rootBundle.loadString('assets/States/states.json');

    CountryModel list = countryModelFromJson(data)
        .where((element) => element.native == country)
        .first;
    if (list.states!.isNotEmpty) {
      model.value.states = list.states;
    }
  }
}
