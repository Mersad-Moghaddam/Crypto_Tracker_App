import 'package:crypto_tracker/controller/provider/crypto_data_provider.dart';
import 'package:crypto_tracker/controller/provider/crypto_graph_data_provider.dart';
import 'package:crypto_tracker/model/crypto_Data_Model.dart';
import 'package:crypto_tracker/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/crypto_graph_model.dart';

class CryptoDetailScreen extends StatefulWidget {
  const CryptoDetailScreen({super.key, required this.symbol, required this.id});
  final String symbol;
  final String id;

  @override
  State<CryptoDetailScreen> createState() => _CryptoDetailScreenState();
}

class _CryptoDetailScreenState extends State<CryptoDetailScreen> {
  TrackballBehavior trackballBehavior = TrackballBehavior(enable: true);
  CrosshairBehavior crosshairBehavior = CrosshairBehavior(enable: true);
  String showGraphFor = '1D';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CryptoGraphProvider>(context, listen: false)
          .fetchGraphPoint(widget.id, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    CryptoDataModel cryptoData = Provider.of<CryptoDataProvider>(context)
        .getSelectedCryptoData(widget.symbol);
    return SafeArea(
        child: Scaffold(
      backgroundColor: app,
      appBar: AppBar(
        backgroundColor: app,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 25,
            color: white,
          ),
        ),
        title: const Row(
          children: [
            // CircleAvatar(
            //   backgroundImage: NetworkImage(cryptoData.image),
            // ),
            SizedBox(
              width: 65,
            ),
            Text(
              "Crypto Tracker",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 3,
          vertical: 2,
        ),
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(cryptoData.image),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                cryptoData.name,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.bookmark_outline_rounded,
                    color: Colors.white,
                  ))
            ],
          ),
          const SizedBox(
            height: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "\$${cryptoData.current_price.toStringAsFixed(2)}",
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: white),
              ),
            ],
          ),
          const SizedBox(
            height: 3,
          ),
          SizedBox(
            height: 30,
            width: double.infinity,
            child: Consumer<CryptoGraphProvider>(
              builder: (context, graphProvider, child) {
                if (graphProvider.cryptoGraphPointList.isNotEmpty) {
                  return const SizedBox();
                } else {
                  return SfCartesianChart(
                    trackballBehavior: trackballBehavior,
                    crosshairBehavior: crosshairBehavior,
                    primaryXAxis: const DateTimeAxis(
                      isVisible: false,
                      borderColor: transparent,
                    ),
                    primaryYAxis: NumericAxis(
                      numberFormat: NumberFormat.compactCurrency(),
                      isVisible: false,
                    ),
                    plotAreaBorderWidth: 0,
                    series: <AreaSeries>[
                      AreaSeries<CryptoGraphModel, dynamic>(
                          enableTooltip: true,
                          color: transparent,
                          borderColor: Colors.amberAccent,
                          borderWidth: 2,
                          dataSource: graphProvider.cryptoGraphPointList,
                          xValueMapper: (CryptoGraphModel graphPoint, index) =>
                              graphPoint.time,
                          yValueMapper: (CryptoGraphModel graphPoint, index) =>
                              graphPoint.price!),
                    ],
                  );
                }
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: teal,
                  ),
                  onPressed: () {},
                  child: const Text(
                    "1D",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: teal,
                  ),
                  onPressed: () {},
                  child: const Text(
                    "1W",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: teal,
                  ),
                  onPressed: () {},
                  child: const Text(
                    "1M",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: teal,
                  ),
                  onPressed: () {},
                  child: const Text(
                    "1Y",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Row(
            children: [
              Text(
                "Performance",
                style: TextStyle(
                    fontSize: 15, color: white, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 3,
              ),
              Icon(
                Icons.info_rounded,
                size: 20,
                color: Colors.grey,
              )
            ],
          ),
          const SizedBox(
            height: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "24 hr Low",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white54,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Text(
                    cryptoData.low_24h.toStringAsFixed(2),
                    style: const TextStyle(
                        fontSize: 17,
                        color: white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "24 hr high",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white54,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Text(
                    cryptoData.high_24h.toStringAsFixed(2),
                    style: const TextStyle(
                        fontSize: 17,
                        color: white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "All Time Low",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white54,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Text(
                    cryptoData.atl.toStringAsFixed(2),
                    style: const TextStyle(
                        fontSize: 17,
                        color: white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "All Time High",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white54,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Text(
                    cryptoData.ath.toStringAsFixed(2),
                    style: const TextStyle(
                        fontSize: 17,
                        color: white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Total Volume",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white54,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 1,
              ),
              Text(
                cryptoData.total_volume.toStringAsFixed(2),
                style: const TextStyle(
                    fontSize: 17, color: white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
