import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:taqat/helper/api_base_helper.dart';
import 'package:taqat/helper/global_variables.dart';
import 'package:taqat/helper/urls.dart';
import 'package:taqat/screens/filter/occupation_model.dart';
import 'package:taqat/screens/search/search_model.dart';

class SearchViewModel extends GetxController {
  final PagingController<int, SearchModel> pagingController =
      PagingController(firstPageKey: 0);
  RxString listCount = '0'.obs;

  RxBool mostRelevant = true.obs;
  int min = 0;
  int max = 0;
  RxBool filterApplied = false.obs;

  TextEditingController searchController = TextEditingController();

  //List<SearchModel> mainList = <SearchModel>[].obs;
  List<OccupationModel> occupationList = <OccupationModel>[].obs;
  Map<String, dynamic> params = {
    "fullname": "",
    "occupation": "",
    "gender": "",
    "labor_hiring_fees": "",
    "nationality": "",
    "recent": "",
    "min": "",
    "max": "",
    "start": 0,
    "end": 10,
  };

  @override
  void onReady() {

    pagingController.addPageRequestListener((pageNo) {
      getLaborsList(pageNo);
    });

    getOccupations();
    getLaborsList(0);
    getMinMaxFee();
    super.onReady();
  }

  @override
  void onClose() {
    GlobalVariables.showLoader.value = false;
    super.onClose();
  }

  getOccupations() {
    ApiBaseHelper().getMethod(url: Urls.services).then((parsedJson) {
      if (parsedJson['success'] == true) {
        var data = parsedJson['services'] as List;
        occupationList.addAll(data.map((e) => OccupationModel.fromJson(e)));
      }
    }).catchError((e) {
      print(e);
    });
  }

  

  getMinMaxFee() {
    ApiBaseHelper().getMethod(url: Urls.minMax).then((parsedJson) {
      if (parsedJson['success'] == true) {
        min = parsedJson['min'];
        max = parsedJson['max'];
        params['min'] = min;
        params['max'] = max;
      }
    }).catchError((e) {
      print(e);
    });
  }

  resetFiltersParam() {
    params = {
      "fullname": "",
      "occupation": "",
      "gender": "",
      "labor_hiring_fees": "",
      "nationality": "",
      "recent": "",
      "min": min,
      "max": max,
      "start": 0,
      "end": 10
    };
  }

  getLaborsList(int pageNo) {
    if (pageNo == 0) {
      GlobalVariables.showLoader.value = true;
    }

    params['fullname'] = searchController.text;
    params['recent'] = mostRelevant.value ? "asc" : "desc";
    params['start'] = pageNo * 10;

    ApiBaseHelper()
        .postMethod(url: Urls.searchLabor, body: params)
        .then((parsedJson) {
      GlobalVariables.showLoader.value = false;
      if (parsedJson['success'] == true) {
        if (pageNo == 0) {
          pagingController.itemList?.clear();
          listCount.value = (pageNo + 1).toString();
        }

        List<SearchModel> dataList = <SearchModel>[].obs;
        var data = parsedJson['labors'] as List;
        dataList.addAll(data.map((e) => SearchModel.fromJson(e)));

        if (dataList.length < 10) {
          pagingController.appendLastPage(dataList);
        } else if (dataList.length == 10) {
          pagingController.appendPage(dataList, pageNo + 1);
        } else {
          pagingController.appendLastPage([]);
        }
      }else{
        if(params['start']==0){
          pagingController.itemList = [];
        }else{
          pagingController.appendLastPage([]);
        }
      }
    }).catchError((e) {
      pagingController.appendLastPage([]);
      GlobalVariables.showLoader.value = false;
      print(e);
    });

  }
}
