class SanadDataModel {
  String? name;
  String? rate;

  SanadDataModel({this.name, this.rate});

  SanadDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['rate'] = this.rate;
    return data;
  }
}

class SubTotalDataModel {
  int? subtotal;
  String? invoiceLink;

  SubTotalDataModel({this.subtotal, this.invoiceLink});

  SubTotalDataModel.fromJson(Map<String, dynamic> json) {
    subtotal = json['subtotal'];
    invoiceLink = json['invoice_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subtotal'] = this.subtotal;
    data['invoice_link'] = this.invoiceLink;
    return data;
  }
}