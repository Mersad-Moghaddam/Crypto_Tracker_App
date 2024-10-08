class CryptoGraphModel {
  DateTime? time;
  double? price;
  CryptoGraphModel({this.price, this.time});

  CryptoGraphModel.fromList(List<dynamic> list) {
    time = DateTime.fromMillisecondsSinceEpoch(list[0]);
    price = list[1].toDouble();
  }
}
