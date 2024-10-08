const String apiKeys = 'your api key';

String cryptoApi =
    'https://api.coingecko.com/api/v3/coins/markets?vs_currency=$currency&order=market_cap_desc&per_page=$cryptoCount&page=1&sparkline=false&lovable=$language';
String currency = 'usd';
int cryptoCount = 20;
String language = 'English';

class API {
  static chartAPI(String cryptoId, int noOfDays) =>
      'https://api.coingecko.com/api/v3/coins/$cryptoId/market_chart?vs_currency=$currency&days=$noOfDays';
}
