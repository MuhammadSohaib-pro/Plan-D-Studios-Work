class InvoiceModel {
  int? id;
  int? applicationId;
  String? type;
  String? invoiceId;
  int? newSponsorId;
  int? oldSponsorId;
  int? laborId;
  var subtotal;
  var totalAmount;
  var taqatPayment;
  String? invoiceLink;
  String? invoiceDate;
  String? paidDate;
  String? invoiceProof;
  int? paymentStatus;
  String? createdAt;
  String? updatedAt;
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
  String? portal;
  String? sanaddoc;
  String? title;

  InvoiceModel(
      {this.id,
      this.applicationId,
      this.type,
      this.invoiceId,
      this.newSponsorId,
      this.oldSponsorId,
      this.laborId,
      this.subtotal,
      this.totalAmount,
      this.taqatPayment,
      this.invoiceLink,
      this.invoiceDate,
      this.paidDate,
      this.invoiceProof,
      this.paymentStatus,
      this.createdAt,
      this.updatedAt,
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
      this.portal,
      this.sanaddoc,
      this.title});

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    applicationId = json['application_id'];
    type = json['type'];
    invoiceId = json['invoice_id'];
    newSponsorId = json['new_sponsor_id'];
    oldSponsorId = json['old_sponsor_id'];
    laborId = json['labor_id'];
    subtotal = json['subtotal'];
    totalAmount = json['total_amount'];
    taqatPayment = json['taqat_payment'];
    invoiceLink = json['invoice_link'];
    invoiceDate = json['invoice_date'];
    paidDate = json['paid_date'];
    invoiceProof = json['invoice_proof'];
    paymentStatus = json['payment_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    portal = json['portal'];
    sanaddoc = json['sanaddoc'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['application_id'] = this.applicationId;
    data['type'] = this.type;
    data['invoice_id'] = this.invoiceId;
    data['new_sponsor_id'] = this.newSponsorId;
    data['old_sponsor_id'] = this.oldSponsorId;
    data['labor_id'] = this.laborId;
    data['subtotal'] = this.subtotal;
    data['total_amount'] = this.totalAmount;
    data['taqat_payment'] = this.taqatPayment;
    data['invoice_link'] = this.invoiceLink;
    data['invoice_date'] = this.invoiceDate;
    data['paid_date'] = this.paidDate;
    data['invoice_proof'] = this.invoiceProof;
    data['payment_status'] = this.paymentStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
    data['portal'] = this.portal;
    data['sanaddoc'] = this.sanaddoc;
    data['title'] = this.title;
    return data;
  }
}
