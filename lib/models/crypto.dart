class Crypto {
  final String id;
  final String name;
  final String symbol;
  final double price;
  final double percentChange24h;

  Crypto({
    required this.id,
    required this.name,
    required this.symbol,
    required this.price,
    required this.percentChange24h,
  });

  factory Crypto.fromJson(Map<String, dynamic> json) {
    return Crypto(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      price: double.parse(json['price_usd']),
      percentChange24h: double.parse(json['percent_change_24h']),
    );
  }
}
