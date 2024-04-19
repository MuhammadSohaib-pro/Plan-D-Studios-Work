class OccupationModelSelection {
  OccupationModel? occupationModel;
  bool isSelected;

  OccupationModelSelection({this.isSelected = false, this.occupationModel});
}

class OccupationModel {
  int? id;
  String? title;
  String? slug;
  String? createdAt;
  String? updatedAt;

  OccupationModel({
    this.id,
    this.title,
    this.slug,
    this.createdAt,
    this.updatedAt,
  });

  OccupationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
