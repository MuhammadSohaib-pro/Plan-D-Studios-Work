import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../libraries.dart';

class AdultProcessViewModel extends GetxController {
  RxString participatingTypeBtn = "".obs;
  RxString selectedMinorBtn = "".obs;
  RxString showerror = ''.obs;
  List<String> list = <String>[
    'United States - English',
    'Espana - Epanol',
    'Espagne - Francais'
  ];
  RxString dropdownValue = 'United States - English'.obs;
  @override
  void onReady() {
    super.onReady();
    getadultprocessdata;
  }

  @override
  void onClose() {
    participatingTypeBtn.value = '';
    selectedMinorBtn.value = '';
    super.onClose();
  }

  getadultprocessdata(id, name) async {
    //save waiver id in waivermodel
    // To update data
    StorewaiverModel.instance.updateData(waiverid: id);
    StorewaiverModel.instance.updateData(waivername: name);

    print("id>>>>" + id);
    showerror.value = '';
    participatingTypeBtn.value = "";
    selectedMinorBtn.value = "";
    GlobalVariables.showLoader.value = true;
    Map<String, dynamic> param = {"id": id};
    String query = """
       query waiver(\$id: String!) {
    waiver(id: \$id)  {
 id
      nonProfit
      pdfURL
      body
      title
      ageGroup
      event {
        name
        type { 
          label 
          value 
        }
      }
      activities {
        label 
        value
      }
      
      personSigning
      hasCompanyDetails
      companyDetails
      includeLocalAddress
      addresslocalRequired
      includeTipInsurance
      tipInsuranceRequired
      includeShoeSize
      shoeSizeRequired
      includeQuestions4473
      questions4473Required
      includeHelmetRental
      helmetRentalRequired
      includeAccidentInsurance
      accidentInsuranceRequired
      includeTripDate
      tripDateRequired
      includeHearAboutUs
      hearAboutUsRequired
      includeWetsuitRental
      wetsuitRentalRequired
      includeShootingExperience
      shootingExperienceRequired
      includeRulesOfFirearmSafety
      rulesOfFirearmSafetyRequired
      signaturePageTextForGuardian
      signatureContent
      includeEmergencyContact
      includeAddress
      addressRequired
      includeIdentification
      identificationRequired
      includeVideo
      videoUrl
      createdAt
      wavierLocalizations{
        title
        body
        signatureContent
        hasCompanyDetails
        signaturePageTextForGuardian
        companyDetails
        language
        wetsuitRefusal
        refusalAgreement
        headerRefusal
      }
      additionalFields {
        type
        questionId
        question
        required
        other
        options {
          label
          value
          flag {
            isFlagEnabled
            raiseFlagWhenSelected
          }
        }
      }
}
}
      """;

    await ApiBaseHelper()
        .postMethod(
      httpLink: HttpLink(Urls.baseURL),
      documentNode: query,
      inputVariable: param,
    )
        .then((parsedJson) {
      GlobalVariables.showLoader.value = false;
      GlobalVariables.datamodel = Waiverbyid.fromJson(parsedJson['waiver']);
      if (GlobalVariables.datamodel.additionalFields!.isEmpty) {
        GlobalVariables.includeshortanswer = false;
        GlobalVariables.includeparagraph = false;
        GlobalVariables.includeradiobutton = false;
        GlobalVariables.includecheckbox = false;
      } else {
        GlobalVariables.datamodel.additionalFields!.forEach((ele) {
          ele.type == "shortAnswer"
              ? GlobalVariables.includeshortanswer = true
              : false;
          ele.type == "paragraph"
              ? GlobalVariables.includeparagraph = true
              : false;
          ele.type == "radioButton"
              ? GlobalVariables.includeradiobutton = true
              : false;
          ele.type == "checkbox"
              ? GlobalVariables.includecheckbox = true
              : false;
        });
      }
    }).catchError((e) {
      showerror.value = e.toString();
      GlobalVariables.showLoader.value = false;
      print(e);
    });
  }
}
