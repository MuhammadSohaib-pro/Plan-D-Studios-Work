class MapModel {
  String? name;
  double? lat;
  double? lng;

  MapModel.name(this.name, this.lat, this.lng);

  MapModel.fromJson(Map<String, dynamic> json) {
    lat = double.parse(json['lat']);
    lng = double.parse(json['lng']);
    name = json['name'] == null ? 'unkown' : json['name'];
  }
}