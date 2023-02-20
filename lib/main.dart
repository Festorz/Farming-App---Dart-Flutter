import 'package:flutter/material.dart';
import 'package:mkulima/authentication/login.dart';
import 'package:mkulima/authentication/signup.dart';
import 'package:mkulima/pages/home_Page/components/farm_products.dart';
import 'package:mkulima/pages/market_page/marketPage.dart';
import 'package:mkulima/pages/records_page/recordsPage.dart';
import 'package:mkulima/provider/navigation_provider.dart';
import 'package:mkulima/server/UnverifiedNotifier.dart';
import 'package:mkulima/server/authentication.dart';
import 'package:mkulima/server/connectivity_service.dart';
import 'package:mkulima/server/farmerNotifier.dart';
import 'package:mkulima/server/marketNotifier.dart';
import 'package:mkulima/server/recordsNotifier.dart';
import 'package:mkulima/server/subscriptionsAPI.dart';
import 'package:provider/provider.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'authentication/wrapper.dart';
import 'enums/connectivity_status.dart';

void main() {
  runApp(Phoenix(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<ConnectivityStatus>(
            create: (context) =>
                ConnectivityService().connectionStatusController.stream,
            initialData: ConnectivityStatus.Offline),
        Provider<Authentication>(create: (_) => Authentication()),
        Provider<SubscriptionsProvider>(create: (_) => SubscriptionsProvider()),
        ChangeNotifierProvider<FarmerNotifier>(create: (_) => FarmerNotifier()),
        ChangeNotifierProvider<MarketNotifier>(create: (_) => MarketNotifier()),
        ChangeNotifierProvider<UnverifiedNotifier>(
            create: (_) => UnverifiedNotifier()),
        ChangeNotifierProvider<RecordsNotifier>(
            create: (_) => RecordsNotifier()),
        ChangeNotifierProvider<NavigationProvider>(
            create: (_) => NavigationProvider()),
      ],
      child: MaterialApp(
        title: 'Mkulima App',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const Wrapper(),
          '/login': (context) => const LoginPage(),
          '/register': (context) => const SignUpPage(),
          '/farm': (context) => const FarmProducts(),
          '/market': (context) => const MarketPage(),
          '/records': (context) => const RecordsPage(),
        },
      ),
    );
  }
}
