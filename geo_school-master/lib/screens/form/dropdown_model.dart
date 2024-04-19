class RegionDataModel {
  String? id;
  String? name;
  List<DropDownModel>? townships;

  RegionDataModel({this.id, this.name, this.townships});

  RegionDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['townships'] != null) {
      townships = [];
      json['townships'].forEach((v) {
        townships!.add(new DropDownModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.townships != null) {
      data['townships'] = this.townships!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DropDownModel {
  String? id;
  String? name;

  DropDownModel({this.id, this.name});

  DropDownModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}