import 'package:flutter/widgets.dart';
import 'package:mkulima/provider/providerDisposer.dart';
import 'package:mkulima/server/farmerNotifier.dart';
import 'package:mkulima/server/marketNotifier.dart';
import 'package:provider/provider.dart';

class AppProviders {
  static List<DisposableProvider> getDisposableProviders(BuildContext context) {
    return [
      Provider.of<FarmerNotifier>(context, listen: false),
      Provider.of<MarketNotifier>(context, listen: false),
    ];
  }

  static void disposeAllDisposableProviders(BuildContext context) {
    getDisposableProviders(context).forEach((disposableProvider) {
      disposableProvider.disposeValues();
    });
  }
}
