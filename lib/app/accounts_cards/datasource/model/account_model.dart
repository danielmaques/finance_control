class AccountModel {
  String? bank;
  String? accountType;
  String? use;
  double? balance;
  dynamic id;
  dynamic color;

  AccountModel({
    this.bank,
    this.accountType,
    this.use,
    this.balance,
    this.id,
    this.color,
  });

  AccountModel.fromJson(Map<String, dynamic> json) {
    bank = json['bank'];
    accountType = json['accountType'];
    use = json['use'];
    balance = json['balance'];
    id = json['id'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bank'] = bank;
    data['accountType'] = accountType;
    data['use'] = use;
    data['balance'] = balance;
    data['id'] = id;
    data['color'] = color;
    return data;
  }
}
