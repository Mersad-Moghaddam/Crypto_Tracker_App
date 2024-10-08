import 'package:crypto_tracker/controller/services/cryptoServices/crypto_services.dart';
import 'package:flutter/widgets.dart';

import '../../model/crypto_graph_model.dart';

class CryptoGraphProvider extends ChangeNotifier {
  List<CryptoGraphModel> cryptoGraphPointList = [];

  fetchGraphPoint(String id, int noOfDays) async {
    cryptoGraphPointList = [];
    notifyListeners();

    List<dynamic> graphData = await CryptoServices.getChartData(id, noOfDays);
    List<CryptoGraphModel> temp = [];
    for (var data in graphData) {
      CryptoGraphModel graphPoint = CryptoGraphModel.fromList(data);
      temp.add(graphPoint);
    }
    cryptoGraphPointList = temp;
    notifyListeners();
  }
}
