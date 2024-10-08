import 'dart:developer';

import 'package:crypto_tracker/controller/services/cryptoServices/crypto_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/crypto_Data_Model.dart';

class CryptoDataProvider extends ChangeNotifier {
  bool isLoading = true;
  List<CryptoDataModel> cryptoDataList = [];

  CryptoDataProvider() {
    fetchCryptoData();
  }

  void fetchCryptoData() async {
    List<dynamic> cryptoData = await CryptoServices.fetchCryptoCurrencyList();
    List<CryptoDataModel> tempList = [];

    for (var data in cryptoData) {
      CryptoDataModel currentData = CryptoDataModel.fromMap(data);
      tempList.add(currentData);
    }
    cryptoDataList = tempList;
    isLoading = false;
    notifyListeners();
    log(cryptoDataList.length.toString());
  }

  CryptoDataModel getSelectedCryptoData(String symbol) {
    CryptoDataModel data =
        cryptoDataList.firstWhere((cryptoData) => cryptoData.symbol == symbol);
    return data;
  }
}
