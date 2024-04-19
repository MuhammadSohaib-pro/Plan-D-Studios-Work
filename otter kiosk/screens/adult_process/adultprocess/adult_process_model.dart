class Waiverbyid {
  String? id;
  dynamic nonProfit;
  String? pdfUrl;
  String? body;
  String? title;
  List<String>? ageGroup;
  Event? event;
  List<Activity>? activities;
  PersonSigning? personSigning;
  HasCompanyDetails? hasCompanyDetails;
  dynamic companyDetails;
  bool? includeLocalAddress;
  bool? addresslocalRequired;
  bool? includeTipInsurance;
  bool? tipInsuranceRequired;
  bool? includeShoeSize;
  bool? shoeSizeRequired;
  bool? includeQuestions4473;
  bool? questions4473Required;
  bool? includeHelmetRental;
  bool? helmetRentalRequired;
  bool? includeAccidentInsurance;
  bool? accidentInsuranceRequired;
  bool? includeTripDate;
  bool? tripDateRequired;
  bool? includeHearAboutUs;
  bool? hearAboutUsRequired;
  bool? includeWetsuitRental;
  bool? wetsuitRentalRequired;
  bool? includeShootingExperience;
  bool? shootingExperienceRequired;
  bool? includeRulesOfFirearmSafety;
  bool? rulesOfFirearmSafetyRequired;
  String? signaturePageTextForGuardian;
  String? signatureContent;
  bool? includeEmergencyContact;
  bool? includeAddress;
  bool? addressRequired;
  bool? includeIdentification;
  bool? identificationRequired;
  bool? includeVideo;
  dynamic videoUrl;
  DateTime? createdAt;
  dynamic wavierLocalizations;
  List<AdditionalField>? additionalFields;

  Waiverbyid({
    this.id,
    this.nonProfit,
    this.pdfUrl,
    this.body,
    this.title,
    this.ageGroup,
    this.event,
    this.activities,
    this.personSigning,
    this.hasCompanyDetails,
    this.companyDetails,
    this.includeLocalAddress,
    this.addresslocalRequired,
    this.includeTipInsurance,
    this.tipInsuranceRequired,
    this.includeShoeSize,
    this.shoeSizeRequired,
    this.includeQuestions4473,
    this.questions4473Required,
    this.includeHelmetRental,
    this.helmetRentalRequired,
    this.includeAccidentInsurance,
    this.accidentInsuranceRequired,
    this.includeTripDate,
    this.tripDateRequired,
    this.includeHearAboutUs,
    this.hearAboutUsRequired,
    this.includeWetsuitRental,
    this.wetsuitRentalRequired,
    this.includeShootingExperience,
    this.shootingExperienceRequired,
    this.includeRulesOfFirearmSafety,
    this.rulesOfFirearmSafetyRequired,
    this.signaturePageTextForGuardian,
    this.signatureContent,
    this.includeEmergencyContact,
    this.includeAddress,
    this.addressRequired,
    this.includeIdentification,
    this.identificationRequired,
    this.includeVideo,
    this.videoUrl,
    this.createdAt,
    this.wavierLocalizations,
    this.additionalFields,
  });

  factory Waiverbyid.fromJson(Map<String, dynamic> json) => Waiverbyid(
        id: json["id"],
        nonProfit: json["nonProfit"],
        pdfUrl: json["pdfURL"],
        body: json["body"],
        title: json["title"],
        ageGroup: json["ageGroup"] == null
            ? []
            : List<String>.from(json["ageGroup"]!.map((x) => x)),
        event: json["event"] == null ? null : Event.fromJson(json["event"]),
        activities: json["activities"] == null
            ? []
            : List<Activity>.from(
                json["activities"]!.map((x) => Activity.fromJson(x))),
        personSigning: personSigningValues.map[json["personSigning"]]!,
        hasCompanyDetails:
            hasCompanyDetailsValues.map[json["hasCompanyDetails"]]!,
        companyDetails: json["companyDetails"],
        includeLocalAddress: json["includeLocalAddress"],
        addresslocalRequired: json["addresslocalRequired"],
        includeTipInsurance: json["includeTipInsurance"],
        tipInsuranceRequired: json["tipInsuranceRequired"],
        includeShoeSize: json["includeShoeSize"],
        shoeSizeRequired: json["shoeSizeRequired"],
        includeQuestions4473: json["includeQuestions4473"],
        questions4473Required: json["questions4473Required"],
        includeHelmetRental: json["includeHelmetRental"],
        helmetRentalRequired: json["helmetRentalRequired"],
        includeAccidentInsurance: json["includeAccidentInsurance"],
        accidentInsuranceRequired: json["accidentInsuranceRequired"],
        includeTripDate: json["includeTripDate"],
        tripDateRequired: json["tripDateRequired"],
        includeHearAboutUs: json["includeHearAboutUs"],
        hearAboutUsRequired: json["hearAboutUsRequired"],
        includeWetsuitRental: json["includeWetsuitRental"],
        wetsuitRentalRequired: json["wetsuitRentalRequired"],
        includeShootingExperience: json["includeShootingExperience"],
        shootingExperienceRequired: json["shootingExperienceRequired"],
        includeRulesOfFirearmSafety: json["includeRulesOfFirearmSafety"],
        rulesOfFirearmSafetyRequired: json["rulesOfFirearmSafetyRequired"],
        signaturePageTextForGuardian: json["signaturePageTextForGuardian"],
        signatureContent: json["signatureContent"],
        includeEmergencyContact: json["includeEmergencyContact"],
        includeAddress: json["includeAddress"],
        addressRequired: json["addressRequired"],
        includeIdentification: json["includeIdentification"],
        identificationRequired: json["identificationRequired"],
        includeVideo: json["includeVideo"],
        videoUrl: json["videoUrl"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        wavierLocalizations: json["wavierLocalizations"],
        additionalFields: json["additionalFields"] == null
            ? []
            : List<AdditionalField>.from(json["additionalFields"]!
                .map((x) => AdditionalField.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nonProfit": nonProfit,
        "pdfURL": pdfUrl,
        "body": body,
        "title": title,
        "ageGroup":
            ageGroup == null ? [] : List<dynamic>.from(ageGroup!.map((x) => x)),
        "event": event?.toJson(),
        "activities": activities == null
            ? []
            : List<dynamic>.from(activities!.map((x) => x.toJson())),
        "personSigning": personSigningValues.reverse[personSigning],
        "hasCompanyDetails": hasCompanyDetailsValues.reverse[hasCompanyDetails],
        "companyDetails": companyDetails,
        "includeLocalAddress": includeLocalAddress,
        "addresslocalRequired": addresslocalRequired,
        "includeTipInsurance": includeTipInsurance,
        "tipInsuranceRequired": tipInsuranceRequired,
        "includeShoeSize": includeShoeSize,
        "shoeSizeRequired": shoeSizeRequired,
        "includeQuestions4473": includeQuestions4473,
        "questions4473Required": questions4473Required,
        "includeHelmetRental": includeHelmetRental,
        "helmetRentalRequired": helmetRentalRequired,
        "includeAccidentInsurance": includeAccidentInsurance,
        "accidentInsuranceRequired": accidentInsuranceRequired,
        "includeTripDate": includeTripDate,
        "tripDateRequired": tripDateRequired,
        "includeHearAboutUs": includeHearAboutUs,
        "hearAboutUsRequired": hearAboutUsRequired,
        "includeWetsuitRental": includeWetsuitRental,
        "wetsuitRentalRequired": wetsuitRentalRequired,
        "includeShootingExperience": includeShootingExperience,
        "shootingExperienceRequired": shootingExperienceRequired,
        "includeRulesOfFirearmSafety": includeRulesOfFirearmSafety,
        "rulesOfFirearmSafetyRequired": rulesOfFirearmSafetyRequired,
        "signaturePageTextForGuardian": signaturePageTextForGuardian,
        "signatureContent": signatureContent,
        "includeEmergencyContact": includeEmergencyContact,
        "includeAddress": includeAddress,
        "addressRequired": addressRequired,
        "includeIdentification": includeIdentification,
        "identificationRequired": identificationRequired,
        "includeVideo": includeVideo,
        "videoUrl": videoUrl,
        "createdAt": createdAt?.toIso8601String(),
        "wavierLocalizations": wavierLocalizations,
        "additionalFields": additionalFields == null
            ? []
            : List<dynamic>.from(additionalFields!.map((x) => x.toJson())),
      };
}

class Activity {
  String? label;
  String? value;

  Activity({
    this.label,
    this.value,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        label: json["label"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "value": value,
      };
}

class AdditionalField {
  String? type;
  String? questionId;
  String? question;
  bool? required;
  bool? other;
  List<Option>? options;

  AdditionalField({
    this.type,
    this.questionId,
    this.question,
    this.required,
    this.other,
    this.options,
  });

  factory AdditionalField.fromJson(Map<String, dynamic> json) =>
      AdditionalField(
        type: json["type"],
        questionId: json["questionId"],
        question: json["question"],
        required: json["required"],
        other: json["other"],
        options: json["options"] == null
            ? []
            : List<Option>.from(
                json["options"]!.map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "questionId": questionId,
        "question": question,
        "required": required,
        "other": other,
        "options": options == null
            ? []
            : List<dynamic>.from(options!.map((x) => x.toJson())),
      };
}

class Option {
  String? label;
  String? value;
  Flag? flag;

  Option({
    this.label,
    this.value,
    this.flag,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        label: json["label"],
        value: json["value"],
        flag: json["flag"] == null ? null : Flag.fromJson(json["flag"]),
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "value": value,
        "flag": flag?.toJson(),
      };
}

class Flag {
  bool? isFlagEnabled;
  bool? raiseFlagWhenSelected;

  Flag({
    this.isFlagEnabled,
    this.raiseFlagWhenSelected,
  });

  factory Flag.fromJson(Map<String, dynamic> json) => Flag(
        isFlagEnabled: json["isFlagEnabled"],
        raiseFlagWhenSelected: json["raiseFlagWhenSelected"],
      );

  Map<String, dynamic> toJson() => {
        "isFlagEnabled": isFlagEnabled,
        "raiseFlagWhenSelected": raiseFlagWhenSelected,
      };
}

class Event {
  String? name;
  Activity? type;

  Event({
    this.name,
    this.type,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        name: json["name"],
        type: json["type"] == null ? null : Activity.fromJson(json["type"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type?.toJson(),
      };
}

enum HasCompanyDetails { NO }

final hasCompanyDetailsValues = EnumValues({"No": HasCompanyDetails.NO});

enum PersonSigning { MEMBER, SIGNEE }

final personSigningValues = EnumValues(
    {"Member": PersonSigning.MEMBER, "Signee": PersonSigning.SIGNEE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
