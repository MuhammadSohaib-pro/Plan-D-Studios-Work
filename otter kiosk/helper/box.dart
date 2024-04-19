import 'package:hive/hive.dart';

import '../Model Class/local_storage_model.dart';

class Boxes {
  static Box<HiveModel> getdata() => Hive.box<HiveModel>('mybox');
}
