import 'package:mkulima/model/recordData.dart';
import 'package:mkulima/provider/providerDisposer.dart';
import 'package:mkulima/server/productServer.dart';

class RecordsNotifier extends DisposableProvider {
  late bool dataLoaded;
  List<RecordModel> records = [];

  late ProductsProvider server;

  RecordsNotifier() {
    dataLoaded = false;
    server = ProductsProvider();
    getRecords();
  }

  void getRecords() async {
    records = await server.getRecords();
    dataLoaded = true;
    notifyListeners();
  }

  void addRecord(data, context) async {
    await server.addRecords(data);
  }

  void deleteRecord(data) async {
    await server.deleteRecord(data);
  }

  @override
  void disposeValues() {
    dataLoaded = false;
    records.clear();
    notifyListeners();
  }
}
