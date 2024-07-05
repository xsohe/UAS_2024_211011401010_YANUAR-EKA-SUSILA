import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/crypto.dart';

class CryptoProvider with ChangeNotifier {
  List<Crypto> _cryptos = [];
  bool _isLoading = false;

  List<Crypto> get cryptos => _cryptos;
  bool get isLoading => _isLoading;

  Future<void> fetchCryptos() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response =
          await http.get(Uri.parse('https://api.coinlore.net/api/tickers/'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> cryptoList = data['data'];
        _cryptos = cryptoList.map((item) => Crypto.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load cryptos');
      }
    } catch (e) {
      print('Error fetching cryptos: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
