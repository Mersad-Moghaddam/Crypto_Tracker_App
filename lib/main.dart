import 'package:crypto_tracker/controller/provider/crypto_data_provider.dart';
import 'package:crypto_tracker/controller/provider/crypto_graph_data_provider.dart';
import 'package:crypto_tracker/view/listCryptoCurrencyScreen/cryptoCurrencyListing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const CryptoTracker());
}

class CryptoTracker extends StatelessWidget {
  const CryptoTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, _, __) {
      return MultiProvider(
          providers: [
            ChangeNotifierProvider<CryptoDataProvider>(
                create: (context) => CryptoDataProvider()),
            ChangeNotifierProvider<CryptoGraphProvider>(
                create: (context) => CryptoGraphProvider())
          ],
          child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: CryptoCurrencyListingScreen(),
          ));
    });
  }
}
