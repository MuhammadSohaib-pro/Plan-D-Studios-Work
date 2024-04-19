import 'dart:async';
import 'dart:io';

import 'package:kiosk/helper/errors.dart';
import 'package:kiosk/helper/getx_helper.dart';
import 'package:kiosk/helper/global_variables.dart';
import 'package:kiosk/helper/urls.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ApiBaseHelper {
  final String baseUrl = Urls.baseURL;
  final AuthLink authLink = AuthLink(
    getToken: () async => 'Bearer ${GlobalVariables.token}',
  );
  Future<dynamic> getMethod(
      {required HttpLink httpLink,
      required String documentNode,
      required Map<String, dynamic> inputVariable}) async {
    try {
      GraphQLClient graphQLClient =
          GraphQLClient(link: httpLink, cache: GraphQLCache());
      print('*********************** Request ********************************');
      print(documentNode);
      print(inputVariable);

      QueryResult result = await graphQLClient.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql(documentNode),
          variables: inputVariable,
        ),
      );
      print(
          '*********************** Response **********************************');
      print(httpLink.uri);
      print(
          '*********************** Response **********************************');
      if (result.hasException) {
        print(result.exception!.raw);
        print(
            '&&&&&&&&&&&&&&&&&&&&&&& End of Response &&&&&&&&&&&&&&&&&&&&&&\n');

        return result.exception!.raw;
      } else {
        print(result.data);
        print(
            '&&&&&&&&&&&&&&&&&&&&&&& End of Response &&&&&&&&&&&&&&&&&&&&&&\n');
        return result.data;
      }
    } on SocketException catch (_) {
      GlobalVariables.showLoader.value = false;
      GetxHelper.showSnackBar(title: 'Error', message: Errors.noInternetError);
      throw Errors.noInternetError;
    } on TimeoutException catch (_) {
      GlobalVariables.showLoader.value = false;
      GetxHelper.showSnackBar(title: 'Error', message: Errors.timeOutException);
      throw Errors.timeOutException;
    } on FormatException catch (e) {
      print(e);
      GlobalVariables.showLoader.value = false;
      GetxHelper.showSnackBar(title: 'Error', message: Errors.formatException);
      throw Errors.formatException;
    } catch (e) {
      GlobalVariables.showLoader.value = false;
      GetxHelper.showSnackBar(title: 'Error', message: Errors.generalApiError);
      throw e.toString();
    }
  }

  Future<dynamic> postMethod(
      {required HttpLink httpLink,
      required String documentNode,
      required Map<String, dynamic> inputVariable}) async {
    try {
      print(inputVariable);
      Link link = authLink.concat(httpLink);
      GraphQLClient graphQLClient = GraphQLClient(
          link: GlobalVariables.token.isEmpty ? httpLink : link,
          cache: GraphQLCache());

      print(httpLink.uri);
      QueryResult result = await graphQLClient.mutate(
        MutationOptions(
            fetchPolicy: FetchPolicy.noCache,
            document: gql(documentNode),
            variables: inputVariable),
      );
      print(
          '*********************** Response **********************************');
      if (result.hasException) {
        print(result.exception!.raw);
        print(
            '&&&&&&&&&&&&&&&&&&&&&&& End of Response &&&&&&&&&&&&&&&&&&&&&&\n');

        return result.exception!.raw![0];
      } else {
        print(result.data);
        print(
            '&&&&&&&&&&&&&&&&&&&&&&& End of Response &&&&&&&&&&&&&&&&&&&&&&\n');
        return result.data;
      }
    } on SocketException catch (_) {
      GlobalVariables.showLoader.value = false;
      GetxHelper.showSnackBar(title: 'Error', message: Errors.noInternetError);
      throw Errors.noInternetError;
    } on TimeoutException catch (_) {
      GlobalVariables.showLoader.value = false;
      GetxHelper.showSnackBar(title: 'Error', message: Errors.timeOutException);
      throw Errors.timeOutException + httpLink.toString();
    } on FormatException catch (_) {
      // print(e);
      GlobalVariables.showLoader.value = false;
      GetxHelper.showSnackBar(title: 'Error', message: Errors.formatException);
      throw Errors.formatException;
    } catch (e) {
      GlobalVariables.showLoader.value = false;
      GetxHelper.showSnackBar(title: 'Error', message: Errors.generalApiError);
      throw e.toString();
    }
  }
}
