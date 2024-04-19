import '../Model Class/organizationmodel.dart';
import '../libraries.dart';

class GlobalVariables {
  static RxBool showLoader = false.obs;
  static RxBool photocapture = false.obs;
  static List<CameraDescription> camera = [];
  static String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFuZHJlYWIuMTcyNkBnbWFpbC5jb20iLCJpZCI6IjZiNGRkMTQ3LWFmMWEtNDQwYy04ZGIxLTllYjkxYThhYTJjZiIsInByb3ZpZGVyIjoibG9jYWwiLCJyb2xlIjp7ImxhYmVsIjoiT3JnYW5pemF0aW9uIEFkbWluIiwidmFsdWUiOiJPUkdBTklaQVRJT05fQURNSU4ifSwib3JnYW5pemF0aW9uSWQiOiI0OTlmNTZiMy1iMGNkLTRmNjYtYWEzNC05ODE5MDJmMjIxZGEiLCJpYXQiOjE2OTMyMzU2NjAsImV4cCI6MTcyNDc5MzI2MH0.jfp5c4Fimfbo0zVOdKkoag0J8vEL09tVy2OAjqC4tRU';
  static Rx<UserModel> userModel = UserModel().obs;
  static OrganizationModel organization = OrganizationModel();
  static Waiverbyid datamodel = Waiverbyid();
  // static StorewaiverModel waivermodel = StorewaiverModel();
  static bool includeshortanswer = false;
  static bool includeparagraph = false;
  static bool includeradiobutton = false;
  static bool includecheckbox = false;
}
