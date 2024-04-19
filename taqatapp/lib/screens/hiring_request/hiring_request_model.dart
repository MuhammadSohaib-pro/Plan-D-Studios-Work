class HiringRequestModel {
  String? firstName;
  String? lastName;
  int? id;
  String? createdAt;
  String? laborStatus;
  String? nationality;
  int? laborSponsorshipTransferFee;
  String? laborPhoto;
  String? fullname;
  String? title;

  HiringRequestModel(
      {this.firstName,
        this.lastName,
        this.id,
        this.createdAt,
        this.laborStatus,
        this.nationality,
        this.laborSponsorshipTransferFee,
        this.laborPhoto,
        this.fullname,
        this.title});

  HiringRequestModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    id = json['id'];
    createdAt = json['created_at'];
    laborStatus = json['labor_status'];
    nationality = json['nationality'];
    laborSponsorshipTransferFee = json['labor_sponsorship_transfer_fee'];
    laborPhoto = json['labor_photo'];
    fullname = json['fullname'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['labor_status'] = this.laborStatus;
    data['nationality'] = this.nationality;
    data['labor_sponsorship_transfer_fee'] = this.laborSponsorshipTransferFee;
    data['labor_photo'] = this.laborPhoto;
    data['fullname'] = this.fullname;
    data['title'] = this.title;
    return data;
  }
}
