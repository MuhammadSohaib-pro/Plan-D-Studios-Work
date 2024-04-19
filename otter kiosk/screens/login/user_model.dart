class UserModel {
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? phone;
  bool? profileCompleted;
  String? provider;
  String? createdById;
  List<dynamic>? permission;

  UserModel(
      {this.id,
        this.email,
        this.firstName,
        this.lastName,
        this.phone,
        this.profileCompleted,
        this.provider,
        this.createdById,
        this.permission});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    profileCompleted = json['profileCompleted'];
    provider = json['provider'];
    createdById = json['createdById'];
    permission = json['permission'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['phone'] = this.phone;
    data['profileCompleted'] = this.profileCompleted;
    data['provider'] = this.provider;
    data['createdById'] = this.createdById;
    data['permission'] = this.permission;
    return data;
  }
}
