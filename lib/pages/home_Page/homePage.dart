import 'package:flutter/material.dart';
import 'package:mkulima/data/data.dart';
import 'package:mkulima/misc/colors.dart';
import 'package:mkulima/model/pages_model.dart';
import 'package:mkulima/pages/admin_pages/unverifiedProducts.dart';
import 'package:mkulima/pages/home_Page/components/explore.dart';
import 'package:mkulima/pages/home_Page/components/farm_products.dart';
import 'package:mkulima/pages/home_Page/components/home_market.dart';
import 'package:mkulima/pages/home_Page/components/home_records.dart';
import 'package:mkulima/pages/home_Page/components/lands_list.dart';
import 'package:mkulima/server/farmerNotifier.dart';
import 'package:mkulima/server/marketNotifier.dart';
import 'package:mkulima/server/recordsNotifier.dart';
import 'package:mkulima/widgets/headertext.dart';
import 'package:mkulima/widgets/side_bar_navigation.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  String newuser = '';

  var images = {
    "image1": 'images/plantation1.jpeg',
    "image2": 'images/plantation2.jpeg',
    "image3": 'images/plantation3.jpeg',
    "image4": 'images/plantation4.jpeg'
  };
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String shareMessage =
        "Let me recommend you this application\n\nhttps://play.google.com/store/apps/details?id=com.jordandevs.apps.mkulima\n";

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => _key.currentState!.openDrawer(),
            icon: const Icon(
              Icons.menu_outlined,
              color: Colors.black,
              size: 22,
            )),
        actions: [
          IconButton(
              onPressed: () {
                Share.share(shareMessage);
              },
              icon: const Icon(
                Icons.share,
                size: 22,
                color: Colors.black,
              ))
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
        title: BoldText(
            text: "Mkulima Business", size: 20, color: AppColors.bluetheme),
        elevation: 0,
      ),
      key: _key,
      drawer: DrawerNavigationBar(),
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: Container(
          color: Colors.white,
          height: double.maxFinite,
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                LandList(),
                SizedBox(height: 10),

                //  explore more
                Explore(),
                SizedBox(height: 15),

                // market items
                MarketItems(),
                SizedBox(height: 10),

                // my products
                FarmProducts(),
                SizedBox(height: 10),

                // record items
                RecordItems(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pullRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    final farmProducts = Provider.of<FarmerNotifier>(context, listen: false);
    final market = Provider.of<MarketNotifier>(context, listen: false);
    final records = Provider.of<RecordsNotifier>(context, listen: false);
    // // get market
    if (market.dataLoaded && market.marketProducts.isEmpty) {
      market.disposeValues();
      market.getMarket();
    }
    // get farmproducts
    if (farmProducts.dataLoaded && farmProducts.products.isEmpty) {
      farmProducts.disposeValues();
      farmProducts.getProducts();
    }
    if (records.dataLoaded && records.records.isEmpty) {
      records.disposeValues();
      records.getRecords();
    }
  }
}
