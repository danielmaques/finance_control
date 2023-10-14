class AddTransactionCard {
  bool? add;
  String? category;
  String? description;
  DateTime? time;
  String? method;
  double? value;
  String? creditCard;
  String? cardID;
  bool? isInstallment;
  double? installmentMonths;

  AddTransactionCard({
    this.description,
    this.time,
    this.value,
    this.creditCard,
    this.cardID,
    this.isInstallment,
    this.installmentMonths,
  });

  AddTransactionCard.fromJson(Map<String, dynamic> json) {
    add = json['add'];
    category = json['category'];
    description = json['description'];
    time = json['time'];
    method = json['method'];
    value = json['value'];
    creditCard = json['creditCard'];
    cardID = json['cardID'];
    isInstallment = json['isInstallment'];
    installmentMonths = json['installmentMonths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (add != null) data['add'] = add;
    if (category != null) data['category'] = category;
    if (description != null) data['description'] = description;
    if (time != null) data['time'] = time;
    if (method != null) data['method'] = method;
    if (value != null) data['value'] = value;
    if (creditCard != null) data['creditCard'] = creditCard;
    if (cardID != null) data['cardID'] = cardID;
    if (isInstallment != null) data['isInstallment'] = isInstallment;
    if (installmentMonths != null) {
      data['installmentMonths'] = installmentMonths;
    }
    return data;
  }
}
