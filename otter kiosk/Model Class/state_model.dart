// To parse this JSON data, do
//
//     final countryModel = countryModelFromJson(jsonString);

import 'dart:convert';

List<CountryModel> countryModelFromJson(String str) => List<CountryModel>.from(
    json.decode(str).map((x) => CountryModel.fromJson(x)));

String countryModelToJson(List<CountryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountryModel {
  String? name;
  String? iso3;
  String? iso2;
  String? numericCode;
  String? phoneCode;
  String? capital;
  String? currency;
  String? currencyName;
  String? currencySymbol;
  String? tld;
  String? native;
  Region? region;
  String? regionId;
  String? subregion;
  String? subregionId;
  String? nationality;
  String? latitude;
  String? longitude;
  String? emoji;
  String? emojiU;
  List<States>? states;

  CountryModel({
    this.name,
    this.iso3,
    this.iso2,
    this.numericCode,
    this.phoneCode,
    this.capital,
    this.currency,
    this.currencyName,
    this.currencySymbol,
    this.tld,
    this.native,
    this.region,
    this.regionId,
    this.subregion,
    this.subregionId,
    this.nationality,
    this.latitude,
    this.longitude,
    this.emoji,
    this.emojiU,
    this.states,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        name: json["name"],
        iso3: json["iso3"],
        iso2: json["iso2"],
        numericCode: json["numeric_code"],
        phoneCode: json["phone_code"],
        capital: json["capital"],
        currency: json["currency"],
        currencyName: json["currency_name"],
        currencySymbol: json["currency_symbol"],
        tld: json["tld"],
        native: json["native"],
        region: regionValues.map[json["region"]]!,
        regionId: json["region_id"],
        subregion: json["subregion"],
        subregionId: json["subregion_id"],
        nationality: json["nationality"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        emoji: json["emoji"],
        emojiU: json["emojiU"],
        states: json["states"] == null
            ? []
            : List<States>.from(json["states"]!.map((x) => States.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "iso3": iso3,
        "iso2": iso2,
        "numeric_code": numericCode,
        "phone_code": phoneCode,
        "capital": capital,
        "currency": currency,
        "currency_name": currencyName,
        "currency_symbol": currencySymbol,
        "tld": tld,
        "native": native,
        "region": regionValues.reverse[region],
        "region_id": regionId,
        "subregion": subregion,
        "subregion_id": subregionId,
        "nationality": nationality,
        "latitude": latitude,
        "longitude": longitude,
        "emoji": emoji,
        "emojiU": emojiU,
        "states": states == null
            ? []
            : List<dynamic>.from(states!.map((x) => x.toJson())),
      };
}

enum Region { AFRICA, AMERICAS, ASIA, EMPTY, EUROPE, OCEANIA, POLAR }

final regionValues = EnumValues({
  "Africa": Region.AFRICA,
  "Americas": Region.AMERICAS,
  "Asia": Region.ASIA,
  "": Region.EMPTY,
  "Europe": Region.EUROPE,
  "Oceania": Region.OCEANIA,
  "Polar": Region.POLAR
});

class States {
  int? id;
  String? name;
  String? stateCode;
  String? latitude;
  String? longitude;
  String? type;

  States({
    this.id,
    this.name,
    this.stateCode,
    this.latitude,
    this.longitude,
    this.type,
  });

  factory States.fromJson(Map<String, dynamic> json) => States(
        id: json["id"],
        name: json["name"],
        stateCode: json["state_code"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "state_code": stateCode,
        "latitude": latitude,
        "longitude": longitude,
        "type": type,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
