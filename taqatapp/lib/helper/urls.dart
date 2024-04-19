import 'package:taqat/helper/global_variables.dart';

class Urls {
  static String baseURL = "https://taqat.plandstudios.com/api/";
  static String imageUrl =
      "https://taqat.plandstudios.com/public/uploads/labor/";

  static String userSponsorId =
      "https://taqat.plandstudios.com/public/uploads/users/";

  static String userSalaryCertificate =
      "https://taqat.plandstudios.com/public/uploads/users/";

  static String userMarriageCertificate =
      "https://taqat.plandstudios.com/public/uploads/users/";
  static String paymentProofsImage =
      "https://taqat.plandstudios.com/public/uploads/payment_proof/";
  static String messageImages =
      "https://taqat.plandstudios.com/public/uploads/messages/";
  static String login = "login";
  static String register = "register";
  static String dashboard = "dashboard";
  static String complete_profile_1 =
      "fandlname/${GlobalVariables.userModel.value.id}";
  static String complete_profile_2 =
      "gsmandid/${GlobalVariables.userModel.value.id}";
  static String complete_profile_3 =
      "dobandaddress/${GlobalVariables.userModel.value.id}";
  static String complete_profile_4 =
      "docs/${GlobalVariables.userModel.value.id}";
  static String add_labor_1 = "laborone";
  static String add_labor_2 = "labortwo/";
  static String add_labor_3 = "laborthree/";
  static String add_labor_4 = "laborfour/";
  static String services = "services";
  static String searchLabor = "searchlabor";
  static String minMax = "minmax";
  static String userApiController = "userapicontroller";
  static String laborHiring = "laborhiring";
  static String notificationList = "notification";
  static String deleteNotification = "deletenotification";
  static String clearNotification = "clearnotification";
  static String updateNotification = "notificationstatus";
  static String receivedRequest = "recievedrequest";
  static String sentRequest = "sentrequest";
  static String updateRequest = "updaterequest";
  static String unreadNotification = "unreadnotification";
  static String laborUserDetail = "laborUserDetail?id=";
  static String uploadDocument =
      "docs_required/${GlobalVariables.userModel.value.id}";
  static String onlySponsorId =
      "onlysponsorid/${GlobalVariables.userModel.value.id}";
  static String paymentProof = "paymentproof";
  static String minSalary = "min_salary";
  static String releaseFromFirstKafeel = "release_from_first_kafeel";
  static String pendingInvoice = "pending_invoice";
  static String sentMessage = "message";
  static String allMessages = "allmessages";
  static String chatList = "messagedusers";
  static String googleLogin = "loginwithgoogle";
  static String sanadPdfLink="https://sanadtaqat.plandstudios.com/public/pdf/laborTransferInvoices/";
  static String forgetPassword = "forgotpassword";
  static String verifyCode = "verifycode";
  static String changePassword = "changepass";

}
