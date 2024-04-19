class NotificationModel {
  int? id;
  String? type;
  String? seen;
  String? isSanad;
  String? createdAt;
  String? toName;
  String? fromName;
  String? fullname;
  String? laborPhoto;
  String? title;
  int? laborId;
  int? sponsorId;
  int? hiringSponsorId;

  NotificationModel(
      {this.id,
        this.type,
        this.seen,
        this.isSanad,
        this.createdAt,
        this.toName,
        this.fromName,
        this.fullname,
        this.laborPhoto,
        this.title,
        this.laborId,
        this.sponsorId,
        this.hiringSponsorId});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    seen = json['seen'];
    isSanad = json['is_sanad'];
    createdAt = json['created_at'];
    toName = json['to_name'];
    fromName = json['from_name'];
    fullname = json['fullname'];
    laborPhoto = json['labor_photo'];
    title = json['title'];
    laborId = json['labor_id'];
    sponsorId = json['sponsor_id'];
    hiringSponsorId = json['hiring_sponsor_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['seen'] = this.seen;
    data['is_sanad'] = this.isSanad;
    data['created_at'] = this.createdAt;
    data['to_name'] = this.toName;
    data['from_name'] = this.fromName;
    data['fullname'] = this.fullname;
    data['labor_photo'] = this.laborPhoto;
    data['title'] = this.title;
    data['labor_id'] = this.laborId;
    data['sponsor_id'] = this.sponsorId;
    data['hiring_sponsor_id'] = this.hiringSponsorId;
    return data;
  }
}
