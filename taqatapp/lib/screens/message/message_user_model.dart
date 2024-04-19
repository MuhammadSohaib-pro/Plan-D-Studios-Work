class MessageUserModel {
  String? name;
  String? gender;

  MessageUserModel({this.name, this.gender});

  MessageUserModel.fromJson(Map<String, dynamic> json) {
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
