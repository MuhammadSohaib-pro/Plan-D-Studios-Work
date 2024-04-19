import '../libraries.dart';

final AdultProcessViewModel adultviewModel = Get.find<AdultProcessViewModel>();

class Navigation {
  static checknavigation() {
    GlobalVariables.datamodel.includeHearAboutUs!
        ? Get.to(() => HearAboutUsView())
        : GlobalVariables.datamodel.includeWetsuitRental!
            ? Get.to(() => WetSuitRentalView())
            : GlobalVariables.datamodel.includeHelmetRental!
                ? Get.to(() => HelmetRentalView())
                : GlobalVariables.datamodel.includeAccidentInsurance!
                    ? Get.to(() => AccidentalInsuranceView())
                    : GlobalVariables.datamodel.includeShootingExperience!
                        ? Get.to(() => ShootingExperienceView())
                        : GlobalVariables.datamodel.includeRulesOfFirearmSafety!
                            ? Get.to(() => FirearmSafetyView())
                            : adultviewModel.participatingTypeBtn.value ==
                                        "Adult" ||
                                    adultviewModel.participatingTypeBtn.value ==
                                        "Adult + Minor(s)"
                                ? GlobalVariables
                                        .datamodel.includeQuestions4473!
                                    ? Get.to(() => EligiablityRequirementView())
                                    : Get.to(() => WaiverView())
                                : Get.to(() => WaiverView());
  }
}
