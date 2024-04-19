class DbImageModel {
  int? imageId;
  String? schoolId;
  String? imagePath;

  DbImageModel({
    this.imageId,
    this.schoolId,
    this.imagePath,
  });

  DbImageModel.fromJson(dynamic json) {
    imageId = json['image_id'];
    schoolId = json['school_id'];
    imagePath = json['image_path'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image_id'] = imageId;
    map['school_id'] = schoolId;
    map['image_path'] = imagePath;
    return map;
  }
}
