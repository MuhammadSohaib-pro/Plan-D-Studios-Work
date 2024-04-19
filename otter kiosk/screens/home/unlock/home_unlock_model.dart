class Data {
  List<Waiver>? waivers;

  Data({
    this.waivers,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        waivers: json["waivers"] == null
            ? []
            : List<Waiver>.from(
                json["waivers"]!.map((x) => Waiver.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "waivers": waivers == null
            ? []
            : List<dynamic>.from(waivers!.map((x) => x.toJson())),
      };
}

class Waiver {
  String? id;
  String? status;
  String? slug;
  bool? hideFromDomain;
  int? step;
  DateTime? createdAt;
  DateTime? lastUpdatedAt;
  String? title;
  dynamic smsCode;
  dynamic smsContent;
  String? signatureContent;
  String? body;
  String? pdfUrl;
  bool? includeEmergencyContact;
  bool? includeAddress;
  bool? addressRequired;
  String? creatorId;
  Organization? organization;
  List<dynamic>? invitedUsers;
  Event? event;

  Waiver({
    this.id,
    this.status,
    this.hideFromDomain,
    this.slug,
    this.step,
    this.createdAt,
    this.lastUpdatedAt,
    this.title,
    this.smsCode,
    this.smsContent,
    this.signatureContent,
    this.body,
    this.pdfUrl,
    this.includeEmergencyContact,
    this.includeAddress,
    this.addressRequired,
    this.creatorId,
    this.invitedUsers,
    this.organization,
    this.event,
  });

  factory Waiver.fromJson(Map<String, dynamic> json) => Waiver(
        id: json["id"],
        status: json["status"],
        slug: json["slug"],
        step: json["step"],
        hideFromDomain: json["hideFromDomain"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        lastUpdatedAt: json["lastUpdatedAt"] == null
            ? null
            : DateTime.parse(json["lastUpdatedAt"]),
        title: json["title"],
        smsCode: json["smsCode"],
        smsContent: json["smsContent"],
        signatureContent: json["signatureContent"],
        body: json["body"],
        pdfUrl: json["pdfURL"],
        includeEmergencyContact: json["includeEmergencyContact"],
        includeAddress: json["includeAddress"],
        addressRequired: json["addressRequired"],
        creatorId: json["creatorId"],
        organization: json["organization"] == null
            ? null
            : Organization.fromJson(json["organization"]),
        invitedUsers: json["invitedUsers"] == null
            ? []
            : List<dynamic>.from(json["invitedUsers"]!.map((x) => x)),
        event: json["event"] == null ? null : Event.fromJson(json["event"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "hideFromDomain": hideFromDomain,
        "slug": slug,
        "step": step,
        "createdAt": createdAt?.toIso8601String(),
        "lastUpdatedAt": lastUpdatedAt?.toIso8601String(),
        "title": title,
        "smsCode": smsCode,
        "smsContent": smsContent,
        "signatureContent": signatureContent,
        "body": body,
        "pdfURL": pdfUrl,
        "includeEmergencyContact": includeEmergencyContact,
        "includeAddress": includeAddress,
        "organization": organization?.toJson(),
        "event": event?.toJson(),
        "addressRequired": addressRequired,
        "creatorId": creatorId,
        "invitedUsers": invitedUsers == null
            ? []
            : List<dynamic>.from(invitedUsers!.map((x) => x)),
      };
}

class Event {
  String? name;

  Event({
    this.name,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class Organization {
  String? id;
  String? title;
  String? photoUrl;
  String? mainColor;

  Organization({
    this.id,
    this.title,
    this.photoUrl,
    this.mainColor,
  });

  factory Organization.fromJson(Map<String, dynamic> json) => Organization(
        id: json["id"],
        title: json["title"]!,
        photoUrl: json["photoURL"],
        mainColor: json["mainColor"]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "photoURL": photoUrl,
        "mainColor": mainColor,
      };
}
