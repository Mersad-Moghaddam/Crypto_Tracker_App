import 'package:crypto_tracker/controller/provider/crypto_data_provider.dart';
import 'package:crypto_tracker/model/crypto_Data_Model.dart';
import 'package:crypto_tracker/utils/colors.dart';
import 'package:crypto_tracker/view/detailScreen/crypto_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CryptoCurrencyListingScreen extends StatefulWidget {
  const CryptoCurrencyListingScreen({super.key});

  @override
  State<CryptoCurrencyListingScreen> createState() =>
      _CryptoCurrencyListingScreenState();
}

class _CryptoCurrencyListingScreenState
    extends State<CryptoCurrencyListingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CryptoDataProvider>(context, listen: false).fetchCryptoData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Crypto Tracker",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white70),
        ),
        backgroundColor: app,
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) {
            return IconButton(
              color: white,
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        backgroundColor: app,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: app,
              ),
              child: Column(
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    'Menu',
                    style: TextStyle(
                      color: white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Profile',
                    style: TextStyle(
                      color: white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.account_circle_rounded,
                    color: white,
                  ),
                ],
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Wallet',
                    style: TextStyle(
                      color: white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.account_balance_wallet_rounded,
                    color: white,
                  ),
                ],
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Search',
                    style: TextStyle(
                      color: white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.search_rounded,
                    color: white,
                  ),
                ],
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Setting',
                    style: TextStyle(
                      color: white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.settings,
                    color: white,
                  ),
                ],
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            const SizedBox(
              height: 330,
            ),
            const Text(
              textAlign: TextAlign.center,
              "Created By Mersad",
              style: TextStyle(
                color: white,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: app,
      body: SafeArea(
        child: Container(
          padding:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(
              //   height: 20,
              // ),
              Expanded(
                child: Consumer<CryptoDataProvider>(
                  builder: (BuildContext context, CryptoDataProvider cryptoList,
                      Widget? child) {
                    if (cryptoList.isLoading == true) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (cryptoList.cryptoDataList.isNotEmpty) {
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          itemCount: cryptoList.cryptoDataList.length,
                          itemBuilder: (BuildContext context, int index) {
                            CryptoDataModel currentCrypto =
                                cryptoList.cryptoDataList[index];
                            return ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CryptoDetailScreen(
                                                symbol: currentCrypto.symbol,
                                                id: currentCrypto.id)));
                              },
                              contentPadding: const EdgeInsets.all(0),
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    NetworkImage(currentCrypto.image!),
                              ),
                              title: Text(
                                currentCrypto.name,
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                currentCrypto.symbol.toUpperCase(),
                                style: const TextStyle(color: Colors.white),
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "\$ ${currentCrypto.current_price!.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Builder(builder: (context) {
                                    double priceChange =
                                        currentCrypto.price_change_24h;
                                    double priceChangePercentage = currentCrypto
                                        .price_change_percentage_24h!;
                                    if (priceChange < 0) {
                                      // negative
                                      return Text(
                                        "${priceChangePercentage.toStringAsFixed(2)}%",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: red,
                                        ),
                                      );
                                    } else {
                                      // positive
                                      return Text(
                                        "${priceChangePercentage.toStringAsFixed(2)}%",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: green,
                                        ),
                                      );
                                    }
                                  })
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return const AlertDialog(
                          title: Text("Data Not Found"),
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
