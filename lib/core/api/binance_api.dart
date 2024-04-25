import 'package:binance_api_test/core/api/core/http.dart';
import 'package:binance_api_test/core/models/ticker_24h_response.dart';

class BinanceApi {
  final Http _http;
  BinanceApi(this._http);

  Future<Object> getTicker24h() {
    return _http.requestList(
      '/api/v3/ticker/24hr',
      method: 'GET',
      parser: (data) {
        return Ticker24hResponse.fromList(data);
      },
    );
  }
}
