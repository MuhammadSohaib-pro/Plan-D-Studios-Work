import 'package:hive/hive.dart';

import '../../Model Class/local_storage_model.dart';
import '../../libraries.dart';

class OfflineWaiversView extends StatelessWidget {
  OfflineWaiversView({super.key});

  final OfflineWaiversViewModel viewModel = Get.put(OfflineWaiversViewModel());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        appBar: appBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Get.context!.isLandscape ? 30 : 0),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 22),
                  offlineBtn(),
                  SizedBox(width: 6),
                  syncBtn(),
                ],
              ),
              SizedBox(height: 30),
              statusNameDateTxtRow(),
              SizedBox(height: 10),
              Divider(thickness: 1.5, color: ThemeColors.grey8, height: 0),
              waiversListView()
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: Text(
        "Offline Waivers",
        style: TextStyle(
          fontSize: 16,
          color: ThemeColors.primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget offlineBtn() {
    return Obx(
      () => CustomElevatedBtn(
        height: 32,
        width: 78,
        child: Text(
          "Offline",
          style: TextStyle(
            color: viewModel.offlineSyncBtn.value == "Offline"
                ? ThemeColors.white
                : ThemeColors.black1,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: viewModel.offlineSyncBtn.value == "Offline"
            ? ThemeColors.primaryColor
            : ThemeColors.grey5,
        onPressed: viewModel.offlineSyncBtn.value == "Offline"
            ? () {}
            : () {
                viewModel.offlineSyncBtn.value = "Offline";
              },
      ),
    );
  }

  Widget syncBtn() {
    return Obx(
      () => CustomElevatedBtn(
        height: 32,
        width: 53,
        child: Text(
          "Sync",
          style: TextStyle(
            color: viewModel.offlineSyncBtn.value == "Sync"
                ? ThemeColors.white
                : ThemeColors.black1,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: viewModel.offlineSyncBtn.value == "Sync"
            ? ThemeColors.primaryColor
            : ThemeColors.grey5,
        onPressed: viewModel.offlineSyncBtn.value == "Sync"
            ? () {}
            : () {
                viewModel.offlineSyncBtn.value = "Sync";
              },
      ),
    );
  }

  Widget statusNameDateTxtRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "Status",
              style: TextStyle(
                fontSize: 12,
                color: ThemeColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              "Name",
              style: TextStyle(
                fontSize: 12,
                color: ThemeColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              "Waiver",
              style: TextStyle(
                fontSize: 12,
                color: ThemeColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              "Date Signed",
              style: TextStyle(
                fontSize: 12,
                color: ThemeColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget waiversListView() {
    final box = Hive.box<HiveModel>('myBox');
    return Expanded(
      child: SizedBox(
        child: ListView.builder(
          itemCount: box.length,
          itemBuilder: (context, index) {
            final item = box.getAt(index);
            return waiversListViewItems(item);
          },
        ),
      ),
    );
  }

  Widget waiversListViewItems(HiveModel? item) {
    return Column(
      children: [
        Container(
          height: 40,
          width: double.infinity,
          color: ThemeColors.grey3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "Offline",
                    style: TextStyle(
                      fontSize: 12,
                      color: ThemeColors.primaryColor,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    "${item?.fname} ${item?.lname}",
                    style: TextStyle(
                      fontSize: 12,
                      color: ThemeColors.primaryColor,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    item!.waivername!,
                    style: TextStyle(
                      fontSize: 12,
                      color: ThemeColors.primaryColor,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    item.signeddate!,
                    style: TextStyle(
                      fontSize: 12,
                      color: ThemeColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 5),
      ],
    );
  }
}
