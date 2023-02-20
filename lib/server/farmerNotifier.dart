import 'package:mkulima/model/products.dart';
import 'package:mkulima/provider/providerDisposer.dart';
import 'package:mkulima/server/productServer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FarmerNotifier extends DisposableProvider {
  late bool dataLoaded;
  List<ProductsModel> products = [];

  late ProductsProvider server;

  FarmerNotifier() {
    dataLoaded = false;
    server = ProductsProvider();
    getProducts();
  }

  void getProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username') ?? '';

    products = await server.getFarmProducts(username);
    dataLoaded = true;
    notifyListeners();
  }

  void addProduct(data, context) async {
    await server.addProduct(data);
  }

  @override
  void disposeValues() {
    dataLoaded = false;
    products.clear();
    notifyListeners();
  }
}
