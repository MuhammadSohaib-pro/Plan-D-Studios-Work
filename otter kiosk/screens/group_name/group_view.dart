import 'package:flutter/cupertino.dart';

import '../../libraries.dart';

class GroupView extends StatelessWidget {
  GroupView({super.key});

  final GroupViewModel viewModel = Get.put(GroupViewModel());
  final AdultProcessViewModel adultviewModel =
      Get.find<AdultProcessViewModel>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        appBar: appBar(),
        body: ScrollableColumn(
          crossAxisAlignment: Get.context!.isTablet && Get.context!.isLandscape
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                groupNameTxtField(),
                SizedBox(height: 20),
                nextBtn(),
              ],
            )
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: forwardBackBtnRow(),
      toolbarHeight: 80,
      automaticallyImplyLeading: false,
    );
  }

  Widget forwardBackBtnRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            margin: EdgeInsets.all(10),
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ThemeColors.grey2,
            ),
            child: Icon(
              Icons.arrow_back,
              color: ThemeColors.white,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            // GlobalVariables.datamodel.ageGroup!.contains("adult") &&
            //     GlobalVariables.datamodel.ageGroup!.contains("minor") ||
            // GlobalVariables.datamodel.ageGroup!.contains("minor")
            adultviewModel.participatingTypeBtn.value == "Minor(s)" ||
                    adultviewModel.participatingTypeBtn.value ==
                        "Adult + Minor(s)"
                ? Get.to(() => MinorParticipantView())
                : Get.to(() => AdultParticipantView());
          },
          child: Obx(() => Container(
                margin: EdgeInsets.all(10),
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: viewModel.selectedGroup == ""
                      ? ThemeColors.grey2
                      : ThemeColors.fullLightPrimary,
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: ThemeColors.white,
                ),
              )),
        )
      ],
    );
  }

  Widget groupNameTxtField() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 250
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 5.5
                  : Get.context!.isLandscape && Get.context!.isPhone
                      ? 14.w
                      : 20.0),
      child: CustomTextField13(
        controller: viewModel.groupController,
        title: "Group Name",
        hintText: "Select Group",
        textColor: ThemeColors.primaryColor,
        fillColor: ThemeColors.grey2.withOpacity(.1),
        sufixIcon: const Icon(
          Icons.arrow_drop_down,
          color: const Color(0xff828A89),
        ),
        readOnly: true,
        onTap: () {
          groupNameBottomSheet();
        },
      ),
    );
  }

  Future<dynamic> groupNameBottomSheet() {
    return showModalBottomSheet(
      context: Get.context!,
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          height: 200,
          padding: EdgeInsets.fromLTRB(1, 0, 12, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextBtn3(
                radius: 4,
                height: 30,
                width: double.minPositive,
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: ThemeColors.primaryColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              Expanded(
                child: CupertinoPicker(
                  scrollController: new FixedExtentScrollController(
                    initialItem: viewModel.groupIndex,
                  ),
                  itemExtent: 35,
                  onSelectedItemChanged: (int index) {
                    viewModel.groupIndex = index;
                    viewModel.selectedGroup.value =
                        viewModel.groupList[viewModel.groupIndex];
                    viewModel.groupController.text =
                        viewModel.groupList[viewModel.groupIndex];
                  },
                  children: List.generate(
                    viewModel.groupList.length,
                    (int index) {
                      return Center(
                        child: Text(
                          viewModel.groupList[index],
                          style: TextStyle(
                            color: Color(0xff1A1D1E),
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              CustomTextBtn3(
                radius: 4,
                height: 30,
                width: double.minPositive,
                child: Text(
                  'Done',
                  style: TextStyle(
                    color: ThemeColors.primaryColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget nextBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 250
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 5.5
                  : 20.0),
      child: Obx(() => CustomElevatedBtn(
            height: 45,
            width: 120,
            backgroundColor: viewModel.selectedGroup.value == ""
                ? ThemeColors.grey2
                : ThemeColors.fullLightPrimary,
            child: Text(
              "Next",
              style: TextStyle(
                fontSize: 18,
                color: ThemeColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              print(StorewaiverModel.instance.waiverid);
              // final AdultProcessViewModel processViewModel = Get.find();
              adultviewModel.participatingTypeBtn.value == "Minor(s)" ||
                      adultviewModel.participatingTypeBtn.value ==
                          "Adult + Minor(s)"
                  ? Get.to(() => MinorParticipantView())
                  : Get.to(() => AdultParticipantView());
            },
          )),
    );
  }
}
