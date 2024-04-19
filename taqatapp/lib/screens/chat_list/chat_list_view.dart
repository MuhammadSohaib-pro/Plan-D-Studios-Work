import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taqat/screens/chat_list/chat_list_viewmodel.dart';
import 'package:taqat/screens/message/message_view.dart';
import 'package:taqat/widgets/loader_view.dart';

class ChatListView extends StatelessWidget {
  ChatListView({super.key});

  final ChatListViewModel viewModel = Get.put(ChatListViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Stack(
        children: [
          listView(),
          LoaderView(),
        ],
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      centerTitle: true,
      elevation: 2,
      title: Text('Chat'.tr),
    );
  }

  Widget listView() {
    return Obx(
      () => (viewModel.chatList.length > 0)
          ? ListView.separated(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              itemCount: viewModel.chatList.length,
              itemBuilder: (context, int index) {
                return listViewItem(index);
              },
              separatorBuilder: (context, int index) {
                return Container(
                  margin: EdgeInsets.only(top: 10, left: 70),
                  child: Divider(
                    height: 0,
                    color: Colors.grey[600],
                  ),
                );
              },
            )
          : noMessagesAvailable(),
    );
  }

  Widget listViewItem(int index) {
    return InkWell(
      onTap: () {
        Get.to(() => MessageView(),
            arguments: {'userId': '${viewModel.chatList[index].id}'});
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(9, 9, 9, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(right: 13),
              height: 50,
              width: 50,
              child: ClipOval(
                child: Image(
                  image: (viewModel.chatList[index].gender == 'Female')
                      ? AssetImage('assets/images/female_user.png')
                      : AssetImage('assets/images/male_user.png'),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.only(top: 7),
                        child: Text(
                          '${viewModel.chatList[index].name ?? 'No Name'}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    (viewModel.chatList[index].lastMessage != null)
                        ? Flexible(
                            child: Container(
                              margin: EdgeInsets.only(top: 2),
                              child: Text(
                                '${viewModel.chatList[index].lastMessage ?? ''}',
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          )
                        : Icon(
                            Icons.image,
                            size: 14,
                          ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  '${viewModel.chatList[index].createdAt ?? ''}',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget noMessagesAvailable() {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('assets/images/messages1.png'),
            height: 100,
            width: 100,
          ),
          Text(
            "No messages yet".tr,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 18,
              color: Color(0xff909090),
            ),
          ),
        ],
      ),
    );
  }
}
