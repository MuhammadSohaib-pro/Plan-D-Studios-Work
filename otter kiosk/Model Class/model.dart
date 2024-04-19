class StorewaiverModel {
  String? waiverid;
  String? waivername;
  String? fname;
  String? lname;
  String? gender;
  String? email;
  String? dob;
  String? phone;
  String? countrycode;
  String? waivertype;
  String? localcity;
  String? localcountry;
  String? localzipcode;
  String? localstate;
  String? localstreet;
  String? emergencyname;
  String? emergencyphone;
  String? emergencycode;
  String? city;
  String? country;
  String? zipcode;
  String? state;
  String? street;
  String? identificationType;
  String? identificationcountry;
  String? identificationstate;
  String? identificationid;
  String? rentalinsurance;
  List? hearaboutus;
  AccidentInsurance? accidentInsurance;
  SingleLinequestion? singleLinequestion;
  MultipleLinequestion? multipleLinequestion;
  Singlechoicequestion? singlechoicequestion;
  Multiplecheckbox? multiplecheckbox;
  List<Map<String, dynamic>>? minorlist;
  Protective? protective;
  Wetsuit? wetsuit;

  // Private constructor for the Singleton pattern
  StorewaiverModel._private();

  // Singleton instance
  static final StorewaiverModel _instance = StorewaiverModel._private();

  // Getter to access the Singleton instance
  static StorewaiverModel get instance => _instance;
  void updateData({
    String? waiverid,
    String? waivername,
    String? fname,
    String? lname,
    String? gender,
    String? email,
    String? dob,
    String? phone,
    String? countrycode,
    String? waivertype,
    String? localcity,
    String? localcountry,
    String? localzipcode,
    String? localstate,
    String? localstreet,
    String? emergencyname,
    String? emergencyphone,
    String? emergencycode,
    String? city,
    String? country,
    String? zipcode,
    String? state,
    String? street,
    String? identificationType,
    String? identificationcountry,
    String? identificationstate,
    String? identificationid,
    String? rentalinsurance,
    List? hearaboutus,
    AccidentInsurance? accidentInsurance,
    SingleLinequestion? singleLinequestion,
    MultipleLinequestion? multipleLinequestion,
    Singlechoicequestion? singlechoicequestion,
    Multiplecheckbox? multiplecheckbox,
    List<Map<String, dynamic>>? minorlist,
    Protective? protective,
    Wetsuit? wetsuit,
  }) {
    this.waiverid = waiverid ?? this.waiverid;
    this.waivername = waivername ?? this.waivername;
    this.fname = fname ?? this.fname;
    this.lname = lname ?? this.lname;
    this.gender = gender ?? this.gender;
    this.email = email ?? this.email;
    this.dob = dob ?? this.dob;
    this.phone = phone ?? this.phone;
    this.countrycode = countrycode ?? this.countrycode;
    this.waivertype = waivertype ?? this.waivertype;
    this.localcity = localcity ?? this.localcity;
    this.localcountry = localcountry ?? this.localcountry;
    this.localstate = localstate ?? this.localstate;
    this.localstreet = localstreet ?? this.localstreet;
    this.localzipcode = localzipcode ?? this.localzipcode;
    this.emergencycode = emergencycode ?? this.emergencycode;
    this.emergencyname = emergencyname ?? this.emergencyname;
    this.emergencyphone = emergencyphone ?? this.emergencyphone;
    this.city = city ?? this.city;
    this.country = country ?? this.country;
    this.state = state ?? this.state;
    this.street = street ?? this.street;
    this.zipcode = zipcode ?? this.zipcode;
    this.identificationType = identificationType ?? this.identificationType;
    this.identificationcountry =
        identificationcountry ?? this.identificationcountry;
    this.identificationid = identificationid ?? this.identificationid;
    this.identificationstate = identificationstate ?? this.identificationstate;
    this.hearaboutus = hearaboutus ?? this.hearaboutus;
    this.accidentInsurance = accidentInsurance ?? this.accidentInsurance;
    this.singleLinequestion = singleLinequestion ?? this.singleLinequestion;
    this.multipleLinequestion =
        multipleLinequestion ?? this.multipleLinequestion;
    this.singlechoicequestion =
        singlechoicequestion ?? this.singlechoicequestion;
    this.multiplecheckbox = multiplecheckbox ?? this.multiplecheckbox;
    this.minorlist = minorlist ?? this.minorlist;
    this.wetsuit = wetsuit ?? this.wetsuit;
    this.rentalinsurance = rentalinsurance ?? this.rentalinsurance;
  }
}

class AccidentInsurance {
  String? answer1;
  String? answer2;
  AccidentInsurance({this.answer1, this.answer2});
}

class SingleLinequestion {
  String? answer;
  List? options;
  String? questionid;
  SingleLinequestion({this.answer, this.options, this.questionid});
}

class MultipleLinequestion {
  String? answer;
  List? options;
  String? questionid;
  MultipleLinequestion({this.answer, this.options, this.questionid});
}

class Singlechoicequestion {
  String? answer;
  String? label;
  String? questionid;
  Singlechoicequestion({this.answer, this.label, this.questionid});
}

class Multiplecheckbox {
  String? answer;
  List? options;
  String? questionid;
  Multiplecheckbox({this.answer, this.options, this.questionid});
}

class Protective {
  String? answer1;
  String? answer2;
  bool? agree;
  Protective({this.answer1, this.answer2, this.agree});
}

class Wetsuit {
  String? answer1;
  String? answer2;
  bool? agree;
  Wetsuit({this.answer1, this.answer2, this.agree});
}
