import 'package:flutter/material.dart';
import 'package:mkulima/pages/market_page/animalMarket.dart';
import 'package:mkulima/pages/market_page/greenMarket.dart';
import 'package:mkulima/pages/market_page/otherMarket.dart';
import 'package:mkulima/server/marketNotifier.dart';
import 'package:provider/provider.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  _MarketPageState createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  TextEditingController searchController = TextEditingController();
  String query = '';
  String searchOption = '';
  String location = '';
  bool searching = false;
  List results = [];
  List pages = [const GreenMarket(), const AnimalMarket(), const OtherMarket()];

  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final market = Provider.of<MarketNotifier>(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    double w1 = (w - 30) / 2;
    // print(searchOption);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Offstage(
            offstage: currentIndex != 0,
            child: pages[0],
          ),
          Offstage(
            offstage: currentIndex != 1,
            child: pages[1],
          ),
          Offstage(
            offstage: currentIndex != 2,
            child: pages[2],
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey[500],
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            label: "Crop products",
            icon: Icon(Icons.business_center),
          ),
          BottomNavigationBarItem(
            label: "Animal products",
            icon: Icon(Icons.business_center),
          ),
          BottomNavigationBarItem(
            label: "Other",
            icon: Icon(Icons.business_center),
          ),
        ],
      ),
    );
  }
}
