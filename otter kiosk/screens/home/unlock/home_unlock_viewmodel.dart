import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:kiosk/Model%20Class/organizationmodel.dart';

import '../../../helper/api_base_helper.dart';
import '../../../helper/global_variables.dart';
import '../../../helper/urls.dart';
import 'home_unlock_model.dart';

class HomeUnlockViewModel extends GetxController {
  RxList<bool> obsecure = [true].obs;
  RxBool lockcheck = false.obs;
  RxString showError = ''.obs;
  // RxBool enabledTile = true.obs;
  String enteredValue = '';

  @override
  void onReady() {
    super.onReady();
    gethomedata();
  }

  Data homeunlockmodel = Data();

  gethomedata() async {
    GlobalVariables.showLoader.value = true;
    showError.value = '';
    Map<String, dynamic> param = {
      'input': {
        "pagination": {"pageSize": 100, "pageIndex": 0}
      }
    };
    String query = """
         query waivers(\$input: WaiverOperationInput!) {
    waivers(input: \$input) {
        id
        status
        hideFromDomain
        intensity{
            label,
            value
        }
        slug
        step
        createdAt
        lastUpdatedAt
        title
        smsCode
        smsContent
        signatureContent
        body
        pdfURL
        ageGroup
        includeEmergencyContact
        includeAddress
        addressRequired
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
        creator {
            id
            firstName
            lastName
            email
            photoURL
            role {
                label
                value
            }
        }
    
        event {
            name
            
        }
        activities {
            label
            value
        }
        waiverMember {
            id
            firstName
            lastName
            photoURL
            email
            role {
            value
            label
        }
    }
    invitedUsers {
        id
        firstName
        lastName
        bio
        email
        photoURL
        role {
            label
            value
        }
    }
    organizer {
        id
        photoURL
        name
        location {
            address
            city {
                label
                value
            }
            state {
                label
                value
            }
            country {
                label
                value
            }
        }
    }
    organization{
          id
          title
          photoURL
          mainColor
      }
    additionalFields {
        questionId
        question
        type
        required
        other
        options {
            label
            value
        }
    }
    participants {
        id
        waiverId
        adult {
            id
            firstName
            lastName
            age
            email
            country_code
            phone
        }
        minor {
            fullName
            age
        }
        source
        hasAdditionalFields
        additionalFieldsData {
            questionId
            options {
                label
                value
            }
            answer
        }
        signee {
            date
        }
        type
        emergencyContact {
            fullName
            phone
            country_code
        }
         
        createdAt
        documentId
        documentUrl
        certificateUrl
        timeStamps {
            electronicRecordAndSignatureDisclosure
            confirmedAdultConsent
            rightToUseElectronicSignatureDisclosure
            checkedIn
            timeTrackStart
            timeTrackEnd
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
      for (var res in parsedJson['waivers']) {
        obsecure.add(true);
      }
      homeunlockmodel = Data.fromJson(parsedJson);
      homeunlockmodel.waivers = homeunlockmodel.waivers!
          .where((element) => element.status == "published")
          .toList();
      OrganizationModel organizatiomodel = OrganizationModel(
        id: homeunlockmodel.waivers![0].organization!.id,
        title: homeunlockmodel.waivers![0].organization!.title,
        mainColor: homeunlockmodel.waivers![0].organization!.mainColor,
        photoUrl: homeunlockmodel.waivers![0].organization!.photoUrl,
      );
      GlobalVariables.organization = organizatiomodel;
      GlobalVariables.showLoader.value = false;
    }).catchError((e) {
      showError.value = e.toString();
      GlobalVariables.showLoader.value = false;
      print(e);
    });
  }

  concatPassword(String value) {
    enteredValue += value;
  }

  deletingLastValue() {
    if (enteredValue.isNotEmpty) {
      enteredValue = enteredValue.substring(0, enteredValue.length - 1);
    }
  }
}
