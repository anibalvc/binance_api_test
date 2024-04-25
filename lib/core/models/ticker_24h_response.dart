import 'dart:convert';

Ticker24hResponse ticker24hFromJson(String str) =>
    Ticker24hResponse.fromList(json.decode(str));

class Ticker24hResponse {
  Ticker24hResponse({required this.data});

  List<Ticker24hData> data;

  factory Ticker24hResponse.fromList(List<dynamic> list) => Ticker24hResponse(
        data:
            list.map<Ticker24hData>((e) => Ticker24hData.fromJson(e)).toList(),
      );
}

class Ticker24hData {
  final String symbol;
  final double lastPrice;
  final double highPrice;
  final double lowPrice;
  final double volume;

  Ticker24hData({
    required this.symbol,
    required this.lastPrice,
    required this.highPrice,
    required this.lowPrice,
    required this.volume,
  });

  factory Ticker24hData.fromJson(Map<String, dynamic> json) {
    return Ticker24hData(
      symbol: json['symbol'],
      lastPrice: double.parse(json['lastPrice']),
      highPrice: double.parse(json['highPrice']),
      lowPrice: double.parse(json['lowPrice']),
      volume: double.parse(json['volume']),
    );
  }
}
