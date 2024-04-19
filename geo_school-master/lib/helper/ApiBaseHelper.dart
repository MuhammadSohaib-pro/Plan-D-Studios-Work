import 'dart:convert';
import 'dart:io';
import 'package:geo_school/helper/errors.dart';
import 'package:geo_school/helper/urls.dart';
import 'package:geo_school/widgets/Loader.dart';
import 'package:geo_school/widgets/getx_helper.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiBaseHelper {
  final String _baseUrl = Urls.baseURL;

  Future<dynamic> post({required String url, dynamic body, required bool isFormData}) async {
    var _header;
    _header = {
      'Content-Type': (!isFormData)
          ? 'application/json'
          : 'application/x-www-form-urlencoded'
    };

    if (!isFormData) {
      body = json.encode(body);
    }

    try {
      final response = await http.post(Uri.parse(_baseUrl + url),
          headers: _header, body: body);
      print(response.body);
      return response.body;
    } on SocketException {
      Loader.loader.value = false;
      GetxHelper.showSnackBar1(
          title: 'error'.tr, message: Errors.noInternetError);
      //  Get.offAll(() => NoInternetView());
    } catch (e) {
      Loader.loader.value = false;
      GetxHelper.showSnackBar1(title: 'error'.tr, message: e.toString());
    }
  }


  Future<dynamic> get({required String url, dynamic body, required bool isFormData}) async {
    var _header;

    _header = {
      'Content-Type': (!isFormData)
          ? 'application/json'
          : 'application/x-www-form-urlencoded'
    };

    if (isFormData != true) {
      body = json.encode(body);
    }
    try {
      final response =
          await http.get(Uri.parse(_baseUrl + url), headers: _header);
      print(response.body);
      return response.body;
    } on SocketException catch(e) {
      Loader.loader.value = false;
      GetxHelper.showSnackBar1(
          title: 'error'.tr, message: e.toString());
      // Get.offAll(() => NoInternetView());
    } catch (e) {
      Loader.loader.value = false;
      GetxHelper.showSnackBar1(title: 'error'.tr, message: e.toString());
    }
  }
}
