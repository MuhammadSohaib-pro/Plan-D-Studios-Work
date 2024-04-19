import 'package:get/get.dart';
import 'package:taqat/helper/api_base_helper.dart';
import 'package:taqat/helper/global_variables.dart';
import 'package:taqat/helper/urls.dart';
import 'package:taqat/screens/chat_list/chat_list_model.dart';
import 'package:taqat/widgets/loader_view.dart';

class ChatListViewModel extends GetxController {
  List<String> chat = ['1', '2', '3', '4', '5'].obs;
  List<ChatListModel> chatList = <ChatListModel>[].obs;

  @override
  void onReady() {
    getChatList();
    super.onReady();
  }

  getChatList() {
    GlobalVariables.showLoader.value = true;
    ApiBaseHelper().getMethod(url: Urls.chatList).then((parsedJson) {
      GlobalVariables.showLoader.value = false;
      if (parsedJson['success'] == true) {
        var data = parsedJson['data'] as List;
        chatList.addAll(data.map((e) => ChatListModel.fromJson(e)));
      }
    }).catchError((e) {
      GlobalVariables.showLoader.value = false;
    });
  }
}
