import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taqat/helper/common_functions.dart';
import 'package:taqat/helper/global_variables.dart';
import 'package:taqat/helper/theme_helper.dart';
import 'package:taqat/helper/urls.dart';
import 'package:taqat/screens/enlarge_image/enlarge_image_view.dart';
import 'package:taqat/screens/message/message_viewmodel.dart';
import 'package:taqat/widgets/custom_bottom_sheet_item_row.dart';
import 'package:taqat/widgets/loader_view.dart';

class MessageView extends StatelessWidget {
  final MessageViewModel viewModel = Get.put(MessageViewModel());

  MessageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: Brightness.light,
      child: Scaffold(
        appBar: appBar(context),
        body: Stack(
          children: [
            Column(
              children: [
                messageBody(),
                writeMessage(context),
              ],
            ),
            LoaderView(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(65),
      child: SafeArea(
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 3,
          flexibleSpace: Row(
            children: [
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back),
              ),
              Container(
                height: 40,
                child: Obx(
                  () => Image(
                    image: viewModel.messageUserModel.value.gender == 'Female'
                        ? AssetImage('assets/images/female_user.png')
                        : AssetImage('assets/images/male_user.png'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => Text(
                          maxLines: 1,
                          '${viewModel.messageUserModel.value.name ?? 'User Name'}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget messageBody() {
    return Obx(
      () => Flexible(
        child: ListView.builder(
          reverse: true,
          controller: viewModel.scrollController,
          itemCount: viewModel.messagesList.length,
          padding: EdgeInsets.only(top: 8, bottom: 8),
          itemBuilder: (context, index) {
            return messageListViewItem(index);
          },
        ),
      ),
    );
  }

  Widget messageListViewItem(int index) {
    return Container(
      padding: EdgeInsets.only(
          left: viewModel.messagesList[index].fromId ==
                  GlobalVariables.userModel.value.id
              ? 0
              : 14,
          right: viewModel.messagesList[index].fromId ==
                  GlobalVariables.userModel.value.id
              ? 14
              : 0,
          top: 12),
      child: Column(
        crossAxisAlignment: viewModel.messagesList[index].fromId ==
                GlobalVariables.userModel.value.id
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          messageContainer(index),
          dateTimeContainers(index),
        ],
      ),
    );
  }

  Widget messageContainer(int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 6),
      padding: EdgeInsets.only(left: 14, right: 14, bottom: 12, top: 12),
      constraints: BoxConstraints(
        maxWidth: Get.width * 0.65,
        minWidth: Get.width * 0.3,
      ),
      decoration: BoxDecoration(
        color: viewModel.messagesList[index].fromId ==
                GlobalVariables.userModel.value.id
            ? ThemeColors.mainColor
            : Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.only(
          topRight: viewModel.messagesList[index].fromId ==
                  GlobalVariables.userModel.value.id
              ? Radius.zero
              : Radius.circular(18),
          topLeft: viewModel.messagesList[index].fromId ==
                  GlobalVariables.userModel.value.id
              ? Radius.circular(18)
              : Radius.zero,
          bottomRight: Radius.circular(18),
          bottomLeft: Radius.circular(18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (viewModel.messagesList[index].message != null &&
                  viewModel.messagesList[index].message != '')
              ? Text(
                  viewModel.messagesList[index].message ?? '',
                  style: TextStyle(
                    color: viewModel.messagesList[index].fromId ==
                            GlobalVariables.userModel.value.id
                        ? Colors.white
                        : Colors.black,
                  ),
                )
              : SizedBox(),
          (viewModel.messagesList[index].image != null &&
                  viewModel.messagesList[index].image != '')
              ? image(viewModel.messagesList[index].image ?? '')
              : SizedBox()
        ],
      ),
    );
  }

  Widget dateTimeContainers(int index) {
    return Text(
      viewModel.messagesList[index].createdAt ?? '',
      style: TextStyle(
        fontSize: 10.5,
        //fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget image(String imageUrl) {
    return InkWell(
      onTap: () {
        CommonFunctions.closeKeyboard();
        Get.to(() => EnlargeImageView(), arguments: {'imageUrl': imageUrl});
      },
      child: CachedNetworkImage(
          width: 140,
          height: 150,
          imageUrl: Urls.messageImages+imageUrl,
          imageBuilder: (context, imageProvider) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    image: imageProvider,
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover),
              ),
            );
          },
          placeholder: (context, url) {
            return Center(
              child: Container(
                width: 140,
                height: 150,
                margin: const EdgeInsets.all(5),
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    valueColor: AlwaysStoppedAnimation(
                      Color(0xfffafafa),
                    ),
                  ),
                ),
              ),
            );
          },
          errorWidget: (context, url, error) {
            return (imageUrl != null && imageUrl != "")
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: 140,
                    height: 150,
                    child: ClipRRect(
                      // borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : const Image(
                    image: AssetImage('assets/images/default_image.png'),
                  );
          }),
    );
  }

  Widget writeMessage(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
      margin: EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Row(
        children: [
          Obx(
            () => (viewModel.pickedFile.value.path != "")
                ? Image.file(
                    viewModel.pickedFile.value,
                    height: 50,
                    width: 40,
                  )
                : Container(),
          ),
          Expanded(
            child: TextField(
              controller: viewModel.messageController,
              textInputAction: TextInputAction.send,
              maxLines: 2,
              minLines: 1,
              onChanged: (value) {},
              onSubmitted: (txt) async {
                viewModel.sendMessage();
              },
              decoration: InputDecoration(
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintText: "Write message .....",
                hintStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(width: 15),
          ClipOval(
            child: Material(
              shape: CircleBorder(),
              color: Colors.transparent,
              child: IconButton(
                onPressed: () {
                  selectImageBottomSheet(context);
                },
                icon: Icon(Icons.attachment_outlined),
                color: ThemeColors.mainColor,
                iconSize: 28,
              ),
            ),
          ),
          Container(
            width: 45,
            height: 45,
            margin: EdgeInsets.only(right: 5),
            child: FloatingActionButton(
              onPressed: () {
                viewModel.sendMessage();
              },
              child: Transform.rotate(
                angle: -19.5,
                child: Icon(
                  Icons.send,
                  color: ThemeColors.mainColor,
                  size: 30,
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }

  selectImageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Image',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                    InkWell(
                      customBorder: CircleBorder(),
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.all(5.5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 0.5,
                            color: Colors.red,
                          ),
                        ),
                        child: Icon(
                          Icons.close,
                          size: 14.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              BottomSheetItemRow(
                title: 'Photo Library',
                icon: CupertinoIcons.photo_on_rectangle,
                onTap: () {
                  viewModel.imgFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              BottomSheetItemRow(
                title: 'Camera',
                icon: CupertinoIcons.photo_camera,
                onTap: () {
                  viewModel.imgFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
