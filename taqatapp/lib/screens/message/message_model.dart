class MessageModel {
  String? message;
  String? createdAt;
  int? fromId;
  String? image;

  MessageModel({this.message, this.createdAt, this.fromId, this.image});

  MessageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    createdAt = json['created_at'];
    fromId = json['from_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['message'] = message;
    data['created_at'] = createdAt;
    data['from_id'] = fromId;
    data['image'] = image;
    return data;
  }
}

class UserModel {
  String? name;
  String? gender;

  UserModel({this.name, this.gender});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['gender'] = this.gender;
    return data;
  }
}

