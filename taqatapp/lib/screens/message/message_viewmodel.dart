import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taqat/helper/api_base_helper.dart';
import 'package:taqat/helper/errors.dart';
import 'package:taqat/helper/getx_helper.dart';
import 'package:taqat/helper/global_variables.dart';
import 'package:taqat/helper/urls.dart';
import 'package:taqat/screens/chat_list/chat_list_viewmodel.dart';
import 'package:taqat/screens/message/message_model.dart';
import 'package:taqat/screens/message/message_user_model.dart';

class MessageViewModel extends GetxController {
  Rx<File> pickedFile = File('').obs;
  String userId = '55';
  ScrollController scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();
  TextEditingController messageTemplateController = TextEditingController();
  List<MessageModel> messagesList = <MessageModel>[].obs;
  Rx<MessageUserModel> messageUserModel = MessageUserModel().obs;

  @override
  void onInit() {
    userId = Get.arguments['userId'];
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getMessages();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      try {
        String newUserid = message.data['from_id'] ?? '-1';
        print(message.data);
        if (newUserid == userId.toString()) {
          MessageModel model = MessageModel();
          model.message = message.notification?.body;
          model.createdAt =
              DateFormat('MM/dd/yyyy hh:mm a').format(DateTime.now());
          model.image = message.data['image'] ?? '';
          model.fromId = int.parse(message.data['from_id'] ?? 0);
          messagesList.insert(0, model);
        }
      } catch (e) {
        print(e.toString());
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
    messageController.dispose();
    messageTemplateController.dispose();
    ChatListViewModel model=Get.find();
    model.chatList.clear();
    model.getChatList();
  }

  imgFromCamera() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      pickedFile.value = File(image.path);
    }
  }

  imgFromGallery() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedFile.value = File(image.path);
    }
  }

  getMessages() {
    GlobalVariables.showLoader.value = true;
    Map<String, dynamic> params = {'user_id': userId};
    ApiBaseHelper()
        .postMethod(url: Urls.allMessages, body: params)
        .then((parsedJson) {
      GlobalVariables.showLoader.value = false;
      if (parsedJson['success'] == true) {
        var data = parsedJson['data'] as List;
        messageUserModel.value =
            MessageUserModel.fromJson(parsedJson['nameandgender']);
        data = data.reversed.toList();
        messagesList.addAll(data.map((e) => MessageModel.fromJson(e)));
      }
    }).catchError((e) {
      print(e);
    });
  }

  getMessagesWithoutLoader() {
    Map<String, dynamic> params = {'user_id': userId};
    ApiBaseHelper()
        .postMethod(url: Urls.allMessages, body: params)
        .then((parsedJson) {
      GlobalVariables.showLoader.value = false;
      var data = parsedJson['data'] as List;
      data = data.reversed.toList();
      messagesList.clear();
      messagesList.addAll(data.map((e) => MessageModel.fromJson(e)));
    }).catchError((e) {
      print(e);
    });
  }

  sendMessage() async {
    if (messageController.text.isNotEmpty || pickedFile.value.path != '') {
      Map<String, String> param = {
        'message': messageController.text,
        'to_user': userId,
      };

      http.MultipartFile? imgFile;
      if (pickedFile.value.path != '') {
        imgFile =
            await http.MultipartFile.fromPath('image', pickedFile.value.path);
      }

      print('****************** path ******************');
      print(pickedFile.value.path);
      print('****************** path ******************');

      MessageModel model = MessageModel();
      model.message = messageController.text;
      model.createdAt = DateFormat('MM/dd/yyyy hh:mm a').format(DateTime.now());
      model.image = pickedFile.value.path;
      model.fromId = GlobalVariables.userModel.value.id;
      messagesList.insert(0, model);

      messageController.text = '';
      pickedFile.value = File('');

      scrollController.animateTo(0,
          duration: Duration(milliseconds: 0), curve: Curves.ease);

      ApiBaseHelper()
          .postMethodFormData(
              url: Urls.sentMessage, fields: param, imgFile: imgFile)
          .then((parsedJson) {
        GlobalVariables.showLoader.value = false;
        if (parsedJson['success'] == true) {
          getMessagesWithoutLoader();
        } else {
          GetxHelper.showSnackBar(title: 'Error', message: parsedJson['error']);
          messagesList.removeAt(0);
        }
        print(parsedJson);
      }).catchError((e) {
        print(e.toString());

        messagesList.removeAt(0);
        if (e == Errors.noInternetError) {
          GetxHelper.showSnackBar(
              title: 'Error', message: Errors.noInternetError);
        }
      }).catchError((error) {
        print(error);
      });
    } else {
      print('please write message');
    }
  }
}
