class SearchModel {
  int? id;
  String? laborFirstName;
  String? laborLastName;
  String? fullname;
  String? laborPhoto;
  String? passportNo;
  String? passportCopy;
  String? gender;
  String? occupation;
  int? experience;
  String? nationality;
  String? religion;
  String? address;
  String? dob;
  int? monthlySalary;
  String? maritalStatus;
  String? applicationType;
  String? jobType;
  String? education;
  int? laborSponsorshipTransferFee;
  int? laborProfileStatus;
  String? location;
  int? coupleWorker;
  String? userId;
  String? createdAt;
  String? updatedAt;
  String? title;
  int? laborStatus;

  SearchModel(
      {this.id,
      this.laborFirstName,
      this.laborLastName,
      this.fullname,
      this.laborPhoto,
      this.passportNo,
      this.passportCopy,
      this.gender,
      this.occupation,
      this.experience,
      this.nationality,
      this.religion,
      this.address,
      this.dob,
      this.monthlySalary,
      this.maritalStatus,
      this.applicationType,
      this.jobType,
      this.education,
      this.laborSponsorshipTransferFee,
      this.laborProfileStatus,
      this.location,
      this.coupleWorker,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.title,
      this.laborStatus});

  SearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    laborFirstName = json['labor_first_name'];
    laborLastName = json['labor_last_name'];
    fullname = json['fullname'];
    laborPhoto = json['labor_photo'];
    passportNo = json['passport_no'];
    passportCopy = json['passport_copy'];
    gender = json['gender'];
    occupation = json['occupation'];
    experience = json['experience'];
    nationality = json['nationality'];
    religion = json['religion'];
    address = json['address'];
    dob = json['dob'];
    monthlySalary = json['monthly_salary'];
    maritalStatus = json['marital_status'];
    applicationType = json['application_type'];
    jobType = json['job_type'];
    education = json['education'];
    laborSponsorshipTransferFee = json['labor_sponsorship_transfer_fee'];
    laborProfileStatus = json['labor_profile_status'];
    location = json['location'];
    coupleWorker = json['couple_worker'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    title = json['title'];
    laborStatus = json['labor_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['labor_first_name'] = this.laborFirstName;
    data['labor_last_name'] = this.laborLastName;
    data['fullname'] = this.fullname;
    data['labor_photo'] = this.laborPhoto;
    data['passport_no'] = this.passportNo;
    data['passport_copy'] = this.passportCopy;
    data['gender'] = this.gender;
    data['occupation'] = this.occupation;
    data['experience'] = this.experience;
    data['nationality'] = this.nationality;
    data['religion'] = this.religion;
    data['address'] = this.address;
    data['dob'] = this.dob;
    data['monthly_salary'] = this.monthlySalary;
    data['marital_status'] = this.maritalStatus;
    data['application_type'] = this.applicationType;
    data['job_type'] = this.jobType;
    data['education'] = this.education;
    data['labor_sponsorship_transfer_fee'] = this.laborSponsorshipTransferFee;
    data['labor_profile_status'] = this.laborProfileStatus;
    data['location'] = this.location;
    data['couple_worker'] = this.coupleWorker;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['title'] = this.title;
    data['labor_status'] = this.laborStatus;
    return data;
  }
}
