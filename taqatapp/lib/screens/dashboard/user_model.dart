class UserModel {
  int? id;
  String? name;
  String? firstName;
  String? googleid;
  String? emailtype;
  String? lastName;
  String? email;
  String? emailVerifiedAt;
  String? gsmNo;
  String? countrycode;
  String? idNo;
  String? address;
  String? dob;
  String? gender;
  String? idPhotoFront;
  String? idPhotoBack;
  String? sponsorId;
  String? salaryCertificate;
  String? marriageCertificate;
  String? userType;
  int? profileStatus;
  int? hireLaborStatus;
  int? addLaborStatus;
  int? status;
  String? createdAt;
  String? updatedAt;

  UserModel(
      {this.id,
      this.googleid,
        this.name,
        this.firstName,
        this.lastName,
        this.email,
        this.emailtype,
        this.emailVerifiedAt,
        this.gsmNo,
        this.countrycode,
        this.idNo,
        this.address,
        this.dob,
        this.gender,
        this.idPhotoFront,
        this.idPhotoBack,
        this.sponsorId,
        this.salaryCertificate,
        this.marriageCertificate,
        this.userType,
        this.profileStatus,
        this.hireLaborStatus,
        this.addLaborStatus,
        this.status,
        this.createdAt,
        this.updatedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    googleid = json['googleid'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    emailtype = json['emailtype'];
    emailVerifiedAt = json['email_verified_at'];
    gsmNo = json['gsm_no'];
    countrycode = json['countrycode'];
    idNo = json['id_no'];
    address = json['address'];
    dob = json['dob'];
    gender = json['gender'];
    idPhotoFront = json['id_photo_front'];
    idPhotoBack = json['id_photo_back'];
    sponsorId = json['sponsor_id'];
    salaryCertificate = json['salary_certificate'];
    marriageCertificate = json['marriage_certificate'];
    userType = json['user_type'];
    profileStatus = json['profile_status'];
    hireLaborStatus = json['hire_labor_status'];
    addLaborStatus = json['add_labor_status'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['gsm_no'] = this.gsmNo;
    data['countrycode'] = this.countrycode;
    data['id_no'] = this.idNo;
    data['address'] = this.address;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['id_photo_front'] = this.idPhotoFront;
    data['id_photo_back'] = this.idPhotoBack;
    data['sponsor_id'] = this.sponsorId;
    data['salary_certificate'] = this.salaryCertificate;
    data['marriage_certificate'] = this.marriageCertificate;
    data['user_type'] = this.userType;
    data['profile_status'] = this.profileStatus;
    data['hire_labor_status'] = this.hireLaborStatus;
    data['add_labor_status'] = this.addLaborStatus;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
