import 'package:hive/hive.dart';
part 'local_storage_model.g.dart';

@HiveType(typeId: 0)
class HiveModel {
  @HiveField(0)
  String? waiverid;
  @HiveField(1)
  String? fname;
  @HiveField(2)
  String? lname;
  @HiveField(3)
  String? gender;
  @HiveField(4)
  String? email;
  @HiveField(5)
  String? dob;
  @HiveField(6)
  String? phone;
  @HiveField(7)
  String? countrycode;
  @HiveField(8)
  String? waivertype;
  @HiveField(9)
  String? localcity;
  @HiveField(10)
  String? localcountry;
  @HiveField(11)
  String? localzipcode;
  @HiveField(12)
  String? localstate;
  @HiveField(13)
  String? localstreet;
  @HiveField(14)
  String? emergencyname;
  @HiveField(15)
  String? emergencyphone;
  @HiveField(16)
  String? emergencycode;
  @HiveField(17)
  String? city;
  @HiveField(18)
  String? country;
  @HiveField(19)
  String? zipcode;
  @HiveField(20)
  String? state;
  @HiveField(21)
  String? street;
  @HiveField(22)
  String? identificationType;
  @HiveField(23)
  String? identificationcountry;
  @HiveField(24)
  String? identificationstate;
  @HiveField(25)
  String? identificationid;
  @HiveField(26)
  List? hearaboutus;
  @HiveField(27)
  String? image;
  @HiveField(28)
  String? waivername;
  @HiveField(29)
  String? signeddate;
  @HiveField(30)
  AccidentInsurance? accidentInsurance;
  @HiveField(31)
  SingleLinequestion? singleLinequestion;
  @HiveField(32)
  MultipleLinequestion? multipleLinequestion;
  @HiveField(33)
  Singlechoicequestion? singlechoicequestion;
  @HiveField(34)
  Multiplecheckbox? multiplecheckbox;
  @HiveField(35)
  String? rentalinsurance;
  @HiveField(36)
  List<Map<String, dynamic>>? minorlist;
  @HiveField(37)
  Protective? protective;
  @HiveField(38)
  Wetsuit? wetsuit;
  HiveModel(
      {this.waiverid,
      this.waivername,
      this.fname,
      this.lname,
      this.gender,
      this.dob,
      this.email,
      this.phone,
      this.countrycode,
      this.waivertype,
      this.localcity,
      this.localcountry,
      this.localzipcode,
      this.localstate,
      this.localstreet,
      this.emergencyname,
      this.emergencyphone,
      this.emergencycode,
      this.city,
      this.country,
      this.zipcode,
      this.state,
      this.street,
      this.identificationType,
      this.identificationcountry,
      this.identificationstate,
      this.identificationid,
      this.hearaboutus,
      this.signeddate,
      this.image,
      this.accidentInsurance,
      this.multipleLinequestion,
      this.multiplecheckbox,
      this.singlechoicequestion,
      this.singleLinequestion,
      this.rentalinsurance,
      this.minorlist,
      this.protective,
      this.wetsuit});
}

@HiveType(typeId: 1)
class AccidentInsurance {
  @HiveField(0)
  String? answer1;
  @HiveField(1)
  String? answer2;
  AccidentInsurance({this.answer1, this.answer2});
}

@HiveType(typeId: 2)
class SingleLinequestion {
  @HiveField(0)
  String? answer;
  @HiveField(1)
  List? options;
  @HiveField(2)
  String? questionid;
  SingleLinequestion({this.answer, this.options, this.questionid});
}

@HiveType(typeId: 3)
class MultipleLinequestion {
  @HiveField(0)
  String? answer;
  @HiveField(1)
  List? options;
  @HiveField(2)
  String? questionid;
  MultipleLinequestion({this.answer, this.options, this.questionid});
}

@HiveType(typeId: 4)
class Singlechoicequestion {
  @HiveField(0)
  String? answer;
  @HiveField(1)
  String? label;
  @HiveField(2)
  String? questionid;
  Singlechoicequestion({this.answer, this.label, this.questionid});
}

@HiveType(typeId: 5)
class Multiplecheckbox {
  @HiveField(0)
  String? answer;
  @HiveField(1)
  List? options;
  @HiveField(2)
  String? questionid;
  Multiplecheckbox({this.answer, this.options, this.questionid});
}

@HiveType(typeId: 6)
class Protective {
  @HiveField(0)
  String? answer1;
  @HiveField(1)
  String? answer2;
  @HiveField(2)
  bool? agree;
  Protective({this.answer1, this.answer2, this.agree});
}

@HiveType(typeId: 7)
class Wetsuit {
  @HiveField(0)
  String? answer1;
  @HiveField(1)
  String? answer2;
  @HiveField(2)
  bool? agree;
  Wetsuit({this.answer1, this.answer2, this.agree});
}
