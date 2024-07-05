import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/crypto_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<CryptoProvider>(context, listen: false).fetchCryptos());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<CryptoProvider>(
          builder: (context, cryptoProvider, child) {
            if (cryptoProvider.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://avatar.iran.liara.run/public/boy'),
                          ),
                          SizedBox(width: 8),
                          Text('Yanuar Eka Susila',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          // Icon(Icons.chevron_right),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.notifications_none),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Coins Crypto',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: cryptoProvider.cryptos.length,
                    itemBuilder: (context, index) {
                      final crypto = cryptoProvider.cryptos[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(crypto.symbol[0]),
                          backgroundColor: Colors.blue,
                        ),
                        title: Text(crypto.name),
                        subtitle: Text(
                            '${crypto.symbol} ${crypto.percentChange24h.toStringAsFixed(2)}%'),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('\$${crypto.price.toStringAsFixed(2)}'),
                            Text(
                                '${crypto.symbol} ${(1000 / crypto.price).toStringAsFixed(5)}',
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
