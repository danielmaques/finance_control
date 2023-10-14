class AddTransaction {
  bool? add;
  String? category;
  String? description;
  DateTime? time;
  String? method;
  double? value;
  String? creditCard;
  String? cardID;

  AddTransaction({
    this.add,
    this.category,
    this.description,
    this.time,
    this.method,
    this.value,
    this.creditCard,
    this.cardID,
  }); 

  AddTransaction.fromJson(Map<String, dynamic> json) {
    add = json['add'];
    category = json['category'];
    description = json['description'];
    time = json['time'];
    method = json['method'];
    value = json['value'];
    creditCard = json['creditCard'];
    cardID = json['cardID'];
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
    return data;
  }
}
