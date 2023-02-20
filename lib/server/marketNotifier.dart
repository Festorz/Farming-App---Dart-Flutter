import 'package:mkulima/model/marketdata.dart';
import 'package:mkulima/provider/providerDisposer.dart';
import 'package:mkulima/server/productServer.dart';

class MarketNotifier extends DisposableProvider {
  late bool dataLoaded;
  late bool result;
  List<MarketModel> marketProducts = [];

  late ProductsProvider server;

  MarketNotifier() {
    dataLoaded = false;
    result = false;
    server = ProductsProvider();
    getMarket();
    // notifyListeners();
  }

  void getMarket() async {
    marketProducts = await server.getMarketProducts();
    dataLoaded = true;
    notifyListeners();
  }

  void setMarket(data, context) async {
    await server.setMarket(data);
    notifyListeners();
  }

  void setPremium(data, context) async {
    await server.setPremium(data);
    notifyListeners();
  }

  @override
  void disposeValues() {
    dataLoaded = false;
    marketProducts.clear();
    notifyListeners();
  }
}
