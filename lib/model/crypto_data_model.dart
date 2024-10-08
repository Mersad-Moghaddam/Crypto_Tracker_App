// ignore_for_file: non_constant_identifier_names

class CryptoDataModel {
  final String id;
  final String symbol;
  final String name;
  final String image;
  final double current_price;
  final int market_cap_rank;
  final int total_volume;
  final double high_24h;
  final double low_24h;
  final double price_change_24h;
  final double price_change_percentage_24h;
  final double ath;
  final double ath_change_percentage;
  final String ath_date;
  final double atl;
  final double atl_change_percentage;
  final String atl_date;

  CryptoDataModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.current_price,
    required this.market_cap_rank,
    required this.total_volume,
    required this.high_24h,
    required this.low_24h,
    required this.price_change_24h,
    required this.price_change_percentage_24h,
    required this.ath,
    required this.ath_change_percentage,
    required this.ath_date,
    required this.atl,
    required this.atl_change_percentage,
    required this.atl_date,
  });

  factory CryptoDataModel.fromMap(Map<String, dynamic> map) => CryptoDataModel(
        current_price: double.parse(map['current_price'].toString()),
        id: map['id'] as String,
        symbol: map["symbol"] as String,
        name: map['name'] as String,
        image: map['image'] as String,
        market_cap_rank: map['market_cap_rank'] as int,
        total_volume: map['total_volume'] as int,
        high_24h: double.parse(map['high_24h'].toString()),
        low_24h: double.parse(map['low_24h'].toString()),
        price_change_24h: double.parse(map['price_change_24h'].toString()),
        price_change_percentage_24h:
            double.parse(map['price_change_percentage_24h'].toString()),
        ath: double.parse(map['ath'].toString()),
        ath_change_percentage:
            double.parse(map['ath_change_percentage'].toString()),
        ath_date: map['ath_date'] as String,
        atl: double.parse(map['atl'].toString()),
        atl_change_percentage:
            double.parse(map['atl_change_percentage'].toString()),
        atl_date: map['atl_date'] as String,
      );
}
