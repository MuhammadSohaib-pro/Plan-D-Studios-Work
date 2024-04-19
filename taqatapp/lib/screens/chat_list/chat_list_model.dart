class ChatListModel {
  String? name;
  int? id;
  String? gender;
  String? createdAt;
  String? lastMessage;

  ChatListModel(
      {this.name, this.id, this.gender, this.createdAt, this.lastMessage});

  ChatListModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    gender = json['gender'];
    createdAt = json['created_at'];
    lastMessage = json['last_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['gender'] = this.gender;
    data['created_at'] = this.createdAt;
    data['last_message'] = this.lastMessage;
    return data;
  }
}
