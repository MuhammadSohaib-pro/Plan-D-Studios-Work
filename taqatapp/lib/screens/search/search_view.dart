import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:taqat/helper/theme_helper.dart';
import 'package:taqat/helper/urls.dart';
import 'package:taqat/screens/filter/filter_view.dart';
import 'package:taqat/screens/labor_details/labor_details_view.dart';
import 'package:taqat/screens/search/search_model.dart';
import 'package:taqat/screens/search/search_viewmodel.dart';
import 'package:taqat/widgets/custom_chips.dart';
import 'package:taqat/widgets/loader_view.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});

  final SearchViewModel viewModel = Get.put(SearchViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                searchTextField(),
                mostRecentAndRelevant(),
                listView()
              ],
            ),
            LoaderView(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(title: Text("Search".tr));
  }

  Widget searchTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          searchTxtField(),
          const SizedBox(width: 15),
          filterBtn(),
        ],
      ),
    );
  }

  Widget searchTxtField() {
    return Expanded(
      child: TextFormField(
        textInputAction: TextInputAction.search,
        controller: viewModel.searchController,
        onChanged: (value)  {
          viewModel.filterApplied.value = false;
          viewModel.resetFiltersParam();
          viewModel.getLaborsList(0);
        },
        style: TextStyle(
          fontSize: 16,
        ),
        onFieldSubmitted: (value) {
          viewModel.filterApplied.value = false;
          viewModel.resetFiltersParam();
          viewModel.getLaborsList(0);
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
              borderRadius: BorderRadius.circular(7)),
          hintText: "Search".tr,
          hintStyle: const TextStyle(
            color: ThemeColors.grey1,
            fontSize: 16,
          ),
          isDense: true,
          fillColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.fromLTRB(15, 17, 0, 17),
        ),
      ),
    );
  }

  Widget filterBtn() {
    return InkWell(
      onTap: () async {
        Map<String, dynamic>? param = await Get.to(() => FilterView());
        if (param != null) {
          viewModel.params = param;
          viewModel.filterApplied.value = true;
          viewModel.getLaborsList(0);
        }
      },
      child: Obx(
        () => Container(
          height: 52,
          width: 52,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: viewModel.filterApplied.value
                ? ThemeColors.mainColor
                : Colors.white,
            borderRadius: BorderRadius.circular(7),
          ),
          child: SvgPicture.asset('assets/svg/filter.svg',
              color:
                  viewModel.filterApplied.value ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget listView() {
    return Expanded(
      child: Obx(
        () => viewModel.listCount.value == '0'
            ? Container(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                alignment: Alignment.center,
                child: const Text(''),
              )
            : PagedListView<int, SearchModel>(
                physics: const BouncingScrollPhysics(),
                pagingController: viewModel.pagingController,
                builderDelegate: PagedChildBuilderDelegate<SearchModel>(
                    itemBuilder: (context, model, index) {
                  return listViewItem(model);
                },
                    noMoreItemsIndicatorBuilder: (context) {
                  return Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    alignment: Alignment.center,
                    child: Text('No More Item'.tr),
                  );
                }, noItemsFoundIndicatorBuilder: (context) {
                  return Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    alignment: Alignment.center,
                    child: Text('No Item Found'.tr),
                  );
                }, newPageProgressIndicatorBuilder: (context) {
                  return Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 20),
                        Text('Loading items....'.tr)
                      ],
                    ),
                  );
                }),
              ),
      ),
    );
  }

  Widget mostRecentAndRelevant() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 4),
      child: Row(
        children: [
          Obx(
            () => CustomFilterChip2(
              label: 'Most Relevant'.tr,
              selected: viewModel.mostRelevant.value,
              onSelected: (value) {
                print(value);
                if (value == true) {
                  viewModel.mostRelevant.value = true;
                  viewModel.getLaborsList(0);
                }
              },
            ),
          ),
          Obx(
            () => CustomFilterChip2(
              label: 'Most Recent'.tr,
              selected: !viewModel.mostRelevant.value,
              onSelected: (value) {
                print(value);
                if (value == true) {
                  viewModel.mostRelevant.value = false;
                  viewModel.getLaborsList(0);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget listViewItem(SearchModel model) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 9, 20, 9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 3.5,
            blurRadius: 10,
            offset: Offset(1, 1), // changes position of shadow
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Get.to(
              () => LaborDetailsView(),
              arguments: {
                'data': model,
                'hireBtnFalg':false,
              },
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 15, 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                imageContainer(model),
                const SizedBox(width: 13),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.title ?? "",
                        style: TextStyle(
                          fontSize: 12,
                          color: ThemeColors.grey2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 12),
                        child: Text(
                          model.fullname ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.black1,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "${'OMR'.tr} ${model.monthlySalary ?? ""}/${'m'.tr}",
                            style: TextStyle(
                              fontSize: 12,
                              color: ThemeColors.grey2,
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                model.nationality ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: ThemeColors.grey2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget imageContainer(SearchModel model) {
    return CachedNetworkImage(
      height: 84,
      width: 84,
      imageUrl: Urls.imageUrl + model.laborPhoto.toString(),
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            image: DecorationImage(
              image: AssetImage('assets/images/default_image.png'),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      placeholder: (context, url) {
        return const Center(
          child: CircularProgressIndicator(strokeWidth: 2.0),
        );
      },
    );
  }
}
