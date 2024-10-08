import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:crypto_tracker/controller/services/api/apiKeys.dart';
import 'package:http/http.dart' as http;

class CryptoServices {
  static fetchCryptoCurrencyList() async {
    try {
      http.Response response = await http.get(
        Uri.parse(cryptoApi),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json"
        },
      ).timeout(
          const Duration(
            seconds: 60,
          ), onTimeout: () {
        throw TimeoutException("Connection Time out");
      });
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        List<dynamic> data = decodedResponse as List<dynamic>;
        return data;
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static getChartData(String cryptoId, int noOfDays) async {
    try {
      http.Response response = await http.get(
        Uri.parse(API.chartAPI(cryptoId, noOfDays)),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json"
        },
      ).timeout(const Duration(seconds: 60), onTimeout: () {
        throw TimeoutException("Connection Timed Out");
      });

      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        List<dynamic> graphData = decodedResponse['prices'];
        return graphData;
      }
      return [];
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
