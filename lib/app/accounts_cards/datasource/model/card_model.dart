class CardModel {
  double? limit;
  double? availableLimit;
  String? cardName;
  String? flag;
  DateTime? close;
  dynamic id;

  CardModel({
    this.limit,
    this.availableLimit,
    this.cardName,
    this.flag,
    this.close,
    this.id,
  });

  CardModel.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    availableLimit = json['availableLimit'];
    cardName = json['cardName'];
    flag = json['flag'];
    close = json['close'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['limit'] = limit;
    data['availableLimit'] = availableLimit;
    data['cardName'] = cardName;
    data['flag'] = flag;
    data['close'] = close;
    data['id'] = id;
    return data;
  }
}
