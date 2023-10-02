class AccountModel {
  String? bank;
  String? accountType;
  String? use;
  double? balance;

  AccountModel({this.bank, this.accountType, this.use, this.balance});

  AccountModel.fromJson(Map<String, dynamic> json) {
    bank = json['bank'];
    accountType = json['accountType'];
    use = json['use'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bank'] = bank;
    data['accountType'] = accountType;
    data['use'] = use;
    data['balance'] = balance;
    return data;
  }
}
