class SchoolListModel {
  String? id;
  String? userId;
  String? schoolId;
  String? level;
  String? status;
  String? zone;
  String? cycle;
  String? buildingMaterial;
  String? altitude;
  String? accuracy;
  String? address;
  String? lat;
  String? lng;
  String? electricity;
  String? water;
  String? internet;
  String? toilet;
  String? connectionSpeed;
  String? mobileNetwork;
  String? fencing;
  String? totalStudents;
  String? girls;
  String? boys;
  String? teachingStaff;
  String? library;
  String? computerRoom;
  String? phoneNo;
  String? description;
  String? image;
  String? approved;
  String? modified;
  String? reason;
  String? approvedBy;
  String? createdAt;
  String? approvedAt;
  String? updatedAt;
  String? name;
  String? regionId;
  String? townshipId;
  String? departmentId;
  String? regionName;
  String? townshipName;
  String? departmentName;
  String? recordUploaded;

  SchoolListModel(
      {this.id,
        this.userId,
        this.schoolId,
        this.level,
        this.status,
        this.zone,
        this.cycle,
        this.buildingMaterial,
        this.altitude,
        this.accuracy,
        this.address,
        this.lat,
        this.lng,
        this.electricity,
        this.water,
        this.internet,
        this.toilet,
        this.connectionSpeed,
        this.mobileNetwork,
        this.fencing,
        this.totalStudents,
        this.girls,
        this.boys,
        this.teachingStaff,
        this.library,
        this.computerRoom,
        this.phoneNo,
        this.description,
        this.image,
        this.approved,
        this.modified,
        this.reason,
        this.approvedBy,
        this.createdAt,
        this.approvedAt,
        this.updatedAt,
        this.name,
        this.regionId,
        this.townshipId,
        this.departmentId,
        this.regionName,
        this.townshipName,
        this.departmentName,
        this.recordUploaded
      });

  SchoolListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    schoolId = json['school_id'];
    level = json['level'];
    status = json['status'];
    zone = json['zone'];
    cycle = json['cycle'];
    buildingMaterial = json['building_material'];
    altitude = json['altitude'];
    accuracy = json['accuracy'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    electricity = json['electricity'];
    water = json['water'];
    internet = json['internet'];
    toilet = json['toilet'];
    connectionSpeed = json['connection_speed'];
    mobileNetwork = json['mobile_network'];
    fencing = json['fencing'];
    totalStudents = json['total_students'];
    girls = json['girls'];
    boys = json['boys'];
    teachingStaff = json['teaching_staff'];
    library = json['library'];
    computerRoom = json['computer_room'];
    phoneNo = json['phone_no'];
    description = json['description'];
    image = json['image'];
    approved = json['approved'];
    modified = json['modified'];
    reason = json['reason'];
    approvedBy = json['approved_by'];
    createdAt = json['created_at'];
    approvedAt = json['approved_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    regionId = json['region_id'];
    townshipId = json['township_id'];
    departmentId = json['department_id'];
    regionName = json['region_name'];
    townshipName = json['township_name'];
    departmentName = json['department_name'];
    recordUploaded = json['recordUploaded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['school_id'] = this.schoolId;
    data['level'] = this.level;
    data['status'] = this.status;
    data['zone'] = this.zone;
    data['cycle'] = this.cycle;
    data['building_material'] = this.buildingMaterial;
    data['altitude'] = this.altitude;
    data['accuracy'] = this.accuracy;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['electricity'] = this.electricity;
    data['water'] = this.water;
    data['internet'] = this.internet;
    data['toilet'] = this.toilet;
    data['connection_speed'] = this.connectionSpeed;
    data['mobile_network'] = this.mobileNetwork;
    data['fencing'] = this.fencing;
    data['total_students'] = this.totalStudents;
    data['girls'] = this.girls;
    data['boys'] = this.boys;
    data['teaching_staff'] = this.teachingStaff;
    data['library'] = this.library;
    data['computer_room'] = this.computerRoom;
    data['phone_no'] = this.phoneNo;
    data['description'] = this.description;
    data['image'] = this.image;
    data['approved'] = this.approved;
    data['modified'] = this.modified;
    data['reason'] = this.reason;
    data['approved_by'] = this.approvedBy;
    data['created_at'] = this.createdAt;
    data['approved_at'] = this.approvedAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['region_id'] = this.regionId;
    data['township_id'] = this.townshipId;
    data['department_id'] = this.departmentId;
    data['region_name'] = this.regionName;
    data['township_name'] = this.townshipName;
    data['department_name'] = this.departmentName;
    data['recordUploaded'] = this.recordUploaded;
    return data;
  }
}
