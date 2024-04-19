import 'package:graphql_flutter/graphql_flutter.dart';

class Urls {
  //development
  static String baseURL = "https://api.dev.otterwaiver.com/graphql";
  //Live
  // static String baseURL = "https://api.otterwaiver.com/graphql";

  static String imageUrl =
      "https://taqat.plandstudios.com/public/images/labors/labors_profile_photo/";

  static String add_labor_4 = "laborfour/";
  static String services = "services";
  static String searchLabor = "searchlabor";
  static String minMax = "minmax";
  static String userApiController = "userapicontroller";
  static String laborHiring = "laborhiring";
  HttpLink httpLink =
      HttpLink("http://books-demo-apollo-server.herokuapp.com/");
}
