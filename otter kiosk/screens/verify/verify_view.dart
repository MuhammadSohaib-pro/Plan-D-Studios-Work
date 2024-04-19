import '../../libraries.dart';

class VerifyView extends StatelessWidget {
  VerifyView({super.key});
  final VerifyViewModel viewModel = Get.put(VerifyViewModel());
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        appBar: appBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              phoneWithProfileContainer(),
              SizedBox(height: 20),
              matchingNumberTxt(),
              SizedBox(height: 20),
              emailWithProfileContainer(),
              SizedBox(height: 20),
              selectProfileTxt(),
              SizedBox(height: 20),
              yesNoUpdateBtnRow()
            ],
          ),
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
          onTap: () {},
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
          onTap: () {},
          child: Container(
            margin: EdgeInsets.all(10),
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ThemeColors.fullLightPrimary,
            ),
            child: Icon(
              Icons.arrow_forward,
              color: ThemeColors.white,
            ),
          ),
        )
      ],
    );
  }

  Widget phoneWithProfileContainer() {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 300 : 10),
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ThemeColors.grey3,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/lady1.png"),
                  radius: 50,
                ),
              ),
            ],
          ),
          Get.context!.isTablet && Get.context!.isLandscape
              ? SizedBox(width: 25)
              : SizedBox(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Elizabeth Payne-Gaposhkin",
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 18,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w500,
                    color: ThemeColors.primaryColor,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Phone: ',
                          style: TextStyle(
                            color: ThemeColors.primaryColor,
                          )),
                      TextSpan(
                          text: '+1 (989) 765-3401',
                          style: const TextStyle(
                              fontSize: 16,
                              color: ThemeColors.primaryColor,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Email: ',
                          style: TextStyle(
                            color: ThemeColors.primaryColor,
                          )),
                      TextSpan(
                          text: 'Lizzy@gmail.com',
                          style: const TextStyle(
                              fontSize: 16,
                              color: ThemeColors.primaryColor,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Birthday: ',
                          style: TextStyle(
                            color: ThemeColors.primaryColor,
                          )),
                      TextSpan(
                          text: '01/10/1992',
                          style: const TextStyle(
                              fontSize: 16,
                              color: ThemeColors.primaryColor,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Radio(
                  activeColor: ThemeColors.fullLightPrimary,
                  value: "",
                  groupValue: "",
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget matchingNumberTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 300 : 10),
      child: Text(
        "Matching phone number profiles",
        style: TextStyle(
          color: ThemeColors.primaryColor,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget emailWithProfileContainer() {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 300 : 10),
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ThemeColors.grey3,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/lady1.png"),
                  radius: 50,
                ),
              ),
            ],
          ),
          Get.context!.isTablet && Get.context!.isLandscape
              ? SizedBox(width: 25)
              : SizedBox(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Elizabeth Payne-Gaposhkin",
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 18,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w500,
                    color: ThemeColors.primaryColor,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Email: ',
                          style: TextStyle(
                            color: ThemeColors.primaryColor,
                          )),
                      TextSpan(
                          text: 'Lizzy@gmail.com',
                          style: const TextStyle(
                              fontSize: 16,
                              color: ThemeColors.primaryColor,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Birthday: ',
                          style: TextStyle(
                            color: ThemeColors.primaryColor,
                          )),
                      TextSpan(
                          text: '01/10/1992',
                          style: const TextStyle(
                              fontSize: 16,
                              color: ThemeColors.primaryColor,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Radio(
                  activeColor: ThemeColors.fullLightPrimary,
                  value: false,
                  groupValue: "",
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget selectProfileTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 300 : 10),
      child: Text(
        "Select profiles to update or choose to continue or select no.",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: ThemeColors.primaryColor,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget yesNoUpdateBtnRow() {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(
            horizontal:
                Get.context!.isTablet && Get.context!.isLandscape ? 300 : 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomElevatedBtn(
              height: 45,
              width: 110,
              child: Text(
                "YES",
                style: TextStyle(
                  color: viewModel.participatingTypeBtn.value == "YES"
                      ? ThemeColors.white
                      : ThemeColors.black1,
                  fontWeight: FontWeight.w600,
                ),
              ),
              backgroundColor: viewModel.participatingTypeBtn.value == "YES"
                  ? ThemeColors.primaryColor
                  : ThemeColors.grey5,
              onPressed: viewModel.participatingTypeBtn.value == "YES"
                  ? () {}
                  : () {
                      viewModel.participatingTypeBtn.value = "YES";
                    },
            ),
            CustomElevatedBtn(
              height: 45,
              width: 110,
              child: Text(
                "NO",
                style: TextStyle(
                  color: viewModel.participatingTypeBtn.value == "NO"
                      ? ThemeColors.white
                      : ThemeColors.black1,
                  fontWeight: FontWeight.w600,
                ),
              ),
              backgroundColor: viewModel.participatingTypeBtn.value == "NO"
                  ? ThemeColors.primaryColor
                  : ThemeColors.grey5,
              onPressed: viewModel.participatingTypeBtn.value == "NO"
                  ? () {}
                  : () {
                      viewModel.participatingTypeBtn.value = "NO";
                    },
            ),
            CustomElevatedBtn(
              height: 45,
              width: 110,
              child: Text(
                "UPDATE",
                style: TextStyle(
                  color: viewModel.participatingTypeBtn.value == "UPDATE"
                      ? ThemeColors.white
                      : ThemeColors.black1,
                  fontWeight: FontWeight.w600,
                ),
              ),
              backgroundColor: viewModel.participatingTypeBtn.value == "UPDATE"
                  ? ThemeColors.primaryColor
                  : ThemeColors.grey5,
              onPressed: viewModel.participatingTypeBtn.value == "UPDATE"
                  ? () {}
                  : () {
                      viewModel.participatingTypeBtn.value = "UPDATE";
                    },
            ),
          ],
        ),
      ),
    );
  }
}
