class BankInfoModel {
  String? taqatBankAccount;
  String? taqatWhatsapp;
  String? taqatBankName;

  BankInfoModel({this.taqatBankAccount, this.taqatWhatsapp});

  BankInfoModel.fromJson(Map<String, dynamic> json) {
    taqatBankAccount = json['taqat_bank_account'];
    taqatWhatsapp = json['taqat_whatsapp'];
    taqatBankName = json['taqat_bank_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taqat_bank_account'] = this.taqatBankAccount;
    data['taqat_whatsapp'] = this.taqatWhatsapp;
    data['taqat_bank_name'] = this.taqatBankName;
    return data;
  }
}