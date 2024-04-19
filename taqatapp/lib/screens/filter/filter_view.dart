import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taqat/helper/common_functions.dart';
import 'package:taqat/screens/filter/filter_viewmodel.dart';
import 'package:taqat/screens/filter/gender_model.dart';
import 'package:taqat/screens/filter/occupation_model.dart';
import 'package:taqat/widgets/custom_buttons.dart';
import 'package:taqat/widgets/custom_chips.dart';
import 'package:taqat/widgets/custom_textfields.dart';

class FilterView extends StatelessWidget {
  final FilterViewModel viewModel = Get.put(FilterViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      appBar: appBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              experienced(),
              heading1('Gender'.tr),
              genderList(),
              divider(),
              occupation(),
              heading1('Labor Hiring Fees'.tr),
              sliderMinMax(),
              priceSlider(),
              divider(),
              heading1('Nationality'.tr),
              nationalityTxtField(),
              const SizedBox(height: 40),
              applyFiltersBtn(),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      title: Text(
        "Filters".tr,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Color(0xff1A1D1E),
        ),
      ),
      backgroundColor: const Color(0xffF9F9F9),
      iconTheme: IconThemeData(color: Color(0xff28303F)),
    );
  }

  Widget experienced() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          heading1('Experienced'.tr, padding: EdgeInsets.zero),
          Obx(
            () => CupertinoSwitch(
              activeColor: const Color(0xff0C8A7B),
              value: viewModel.experiencedBtn.value,
              onChanged: (value) {
                viewModel.experiencedBtn.value = value;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget genderList() {
    return Obx(
      () => SizedBox(
        height: 35,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 10),
          itemCount: viewModel.genderList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return genderViewItem(index);
          },
        ),
      ),
    );
  }

  Widget genderViewItem(int index) {
    return CustomFilterChip1(
      label: viewModel.genderList[index].title,
      selected: viewModel.selectedGender == viewModel.genderList[index].id
          ? viewModel.genderList[index].isSelected
          : false,
      onSelected: (value) {
        viewModel.selectedGender = viewModel.genderList[index].id;
        GenderModel model = viewModel.genderList[index];
        model.isSelected = value;
        viewModel.genderList[index] = model;
      },
    );
  }

  Widget occupation() {
    return Obx(
      () => viewModel.occupationList.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heading1('Occupation'.tr),
                SizedBox(
                  height: 35,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    itemCount: viewModel.occupationList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return occupationViewItem(index);
                    },
                  ),
                ),
                divider(),
              ],
            )
          : SizedBox(height: 0),
    );
  }

  Widget occupationViewItem(int index) {
    return CustomFilterChip1(
      label: viewModel.occupationList[index].occupationModel?.title ?? 'N/A',
      selected: viewModel.occupationList[index].isSelected,
      onSelected: (value) {
        OccupationModelSelection model = viewModel.occupationList[index];
        model.isSelected = value;
        viewModel.occupationList[index] = model;
      },
    );
  }

  Widget sliderMinMax() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(
            () => Text(
              "OMR ${viewModel.minFee.value}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xff1A1D1E),
              ),
            ),
          ),
          Obx(
            () => Text(
              "OMR ${viewModel.maxFee.value}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xff1A1D1E),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget priceSlider() {
    return Obx(
      () => RangeSlider(
        activeColor: const Color(0xff0C8A7B),
        values: viewModel.rangeValues.value,
        max: viewModel.searchViewModel.max.toDouble() == 0
            ? 1
            : viewModel.searchViewModel.max.toDouble(),
        min: viewModel.searchViewModel.min.toDouble(),
        onChanged: (value) {
          print(value);
          if (value.start >= viewModel.searchViewModel.min &&
              value.end <= viewModel.searchViewModel.max)
            viewModel.rangeValues.value = value;
          viewModel.minFee.value = value.start.toInt();
          viewModel.maxFee.value = value.end.toInt();
        },
      ),
    );
  }

  Widget nationalityTxtField() {
    return Container(
      margin: EdgeInsets.only(top: 0, left: 10, right: 20),
      child: countryFlagTextField(
        keyboardType: TextInputType.text,
        controller: viewModel.nationalityController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return CommonFunctions.validateDefaultTxtField(value!);
        },
        onChanged: (val) {
          viewModel.nationalityController.text = val.toCountryStringOnly();
        },
      ),
    );
  }

  Widget applyFiltersBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: CustomButton8(
        backgroundColor: const Color(0xff0C8A7B),
        text: "Apply Filters".tr,
        onPressed: () {
          viewModel.applyFilterBtn();
        },
      ),
    );
  }

  Widget heading1(
    String heading, {
    EdgeInsetsGeometry padding =
        const EdgeInsets.only(left: 15, bottom: 18, top: 10, right: 15),
  }) {
    return Padding(
      padding: padding,
      child: Text(
        heading,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Color(0xff101817),
        ),
      ),
    );
  }

  Widget divider() {
    return const Divider(
      thickness: 1,
      indent: 20,
      endIndent: 20,
      color: Color(0xffF0F0F2),
      height: 30,
    );
  }
}
