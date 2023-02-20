import 'package:mkulima/model/marketdata.dart';
import 'package:mkulima/model/unverifiedMarket.dart';
import 'package:mkulima/provider/providerDisposer.dart';
import 'package:mkulima/server/productServer.dart';

class UnverifiedNotifier extends DisposableProvider {
  late bool dataLoaded;
  late bool result;
  List<UnverifiedMarket> market = [];

  late ProductsProvider server;

  UnverifiedNotifier() {
    dataLoaded = false;
    result = false;
    server = ProductsProvider();
    getUnverified();
  }

  void getUnverified() async {
    market = await server.getAllMarket();
    dataLoaded = true;
    notifyListeners();
  }

  void setVerified(data, context) async {
    await server.setVerified(data);
    notifyListeners();
  }

  @override
  void disposeValues() {
    dataLoaded = false;
    market.clear();
    notifyListeners();
  }
}
