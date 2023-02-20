import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mkulima/misc/colors.dart';
import 'package:mkulima/pages/market_page/market_product.dart';
import 'package:mkulima/server/marketNotifier.dart';
import 'package:mkulima/widgets/apptext.dart';
import 'package:mkulima/widgets/headertext.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnimalMarket extends StatefulWidget {
  const AnimalMarket({Key? key}) : super(key: key);

  @override
  _AnimalMarketState createState() => _AnimalMarketState();
}

class _AnimalMarketState extends State<AnimalMarket> {
  TextEditingController searchController = TextEditingController();
  String query = '';
  String searchOption = '';
  String location = '';
  String productsType = 'Animal product';
  bool searching = false;
  List results = [];
  List animalproducts = [];

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    setState(() {
      location = user.getString('town') ?? '';
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final market = Provider.of<MarketNotifier>(context);

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    double w1 = (w - 30) / 2;
    animalproducts.clear();

    for (var element in market.marketProducts) {
      if (element.type == productsType) {
        setState(() {
          animalproducts.add(element);
        });
      }
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
              size: 22,
            )),
        backgroundColor: AppColors.bluetheme,
        centerTitle: true,
        title: const BoldText(
            text: "Animal products", size: 20, color: Colors.white),
        elevation: 0,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: Container(
          height: h,
          width: w,
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // search bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                width: w,
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          labelText: 'Search animal products',
                          labelStyle: const TextStyle(color: Colors.black54),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.grey.shade400, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.grey.shade400, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.black54, width: 1.0)),
                          fillColor: Colors.white,
                          filled: true,
                          isDense: true,
                          contentPadding: const EdgeInsets.all(5),
                          prefixIcon: Icon(Icons.search,
                              color: Colors.grey[600], size: 20),
                          suffixIcon: searching == true
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      searching = false;
                                      FocusScope.of(context).unfocus();
                                      searchController.clear();
                                    });
                                  },
                                  icon: const Icon(Icons.close_rounded,
                                      color: Colors.black, size: 20))
                              : null,
                        ),
                        onChanged: (text) {
                          setState(() {
                            searching = true;
                            query = text;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showPopupMenu();
                      },
                      child: Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: Colors.cyan[900],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: SvgPicture.asset(
                            "images/svg/setting-lines.svg",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                    padding: const EdgeInsets.only(bottom: 10, top: 10),
                    child: market.dataLoaded
                        ? GridView.extent(
                            scrollDirection: Axis.vertical,
                            maxCrossAxisExtent: 200.0,
                            childAspectRatio: (2 / 2),
                            shrinkWrap: true,
                            mainAxisSpacing: 5.0,
                            crossAxisSpacing: 10.0,
                            children: searching == false
                                ? List.generate(animalproducts.length, (index) {
                                    return GestureDetector(
                                      onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MarketProduct(
                                                      product: animalproducts[
                                                          index]))),
                                      child: Column(children: [
                                        Container(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          height: 120,
                                          width: w1,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    animalproducts[index]
                                                        .imageUrl),
                                                fit: BoxFit.cover,
                                              ),
                                              color: Colors.white),
                                        ),
                                        const SizedBox(height: 3),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              AppText(
                                                  text: animalproducts[index]
                                                              .title
                                                              .length >
                                                          7
                                                      ? "${animalproducts[index].title.substring(0, 7)} ..."
                                                      : animalproducts[index]
                                                          .title,
                                                  size: 16,
                                                  bold: true),
                                              Expanded(child: Container()),
                                              AppText(
                                                  text:
                                                      'Ksh ${animalproducts[index].price}',
                                                  size: 13,
                                                  bold: true),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        SizedBox(
                                          width: 190,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: AppText(
                                                text: animalproducts[index]
                                                    .description,
                                                size: 14),
                                          ),
                                        )
                                      ]),
                                    );
                                  })
                                : List.generate(_filterProducts(query).length,
                                    (index) {
                                    return GestureDetector(
                                      onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MarketProduct(
                                                      product:
                                                          results[index]))),
                                      child: Column(children: [
                                        Container(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          height: 120,
                                          width: w1,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    results[index].imageUrl),
                                                fit: BoxFit.cover,
                                              ),
                                              color: Colors.white),
                                        ),
                                        const SizedBox(height: 3),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              AppText(
                                                  text: results[index]
                                                              .title
                                                              .length >
                                                          7
                                                      ? "${results[index].title.substring(0, 7)} ..."
                                                      : results[index].title,
                                                  size: 16,
                                                  bold: true),
                                              Expanded(child: Container()),
                                              AppText(
                                                  text:
                                                      'Ksh ${results[index].price}',
                                                  size: 13,
                                                  bold: true)
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        SizedBox(
                                          width: 190,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: AppText(
                                                text:
                                                    results[index].description,
                                                size: 14),
                                          ),
                                        )
                                      ]),
                                    );
                                  }),
                          )
                        : Center(
                            child: CircularProgressIndicator(
                              color: AppColors.bluetheme,
                            ),
                          )),
              )
            ],
          ),
        ),
      ),
    );
  }

  _filterProducts(String title) {
    results.clear();
    if (title.isNotEmpty) {
      for (var element in animalproducts) {
        if (element.title.toLowerCase().contains(title.toLowerCase()) ||
            element.description.contains(title.toLowerCase())) {
          results.add(element);
          if (searchOption.isNotEmpty) {
            switch (searchOption) {
              case '1':
                results.sort(((a, b) => a.price.compareTo(b.price)));
                break;
              case '11':
                results.removeWhere((element) =>
                    !element.location.contains(location) ||
                    element.country.contains());
                break;
              default:
                break;
            }
          }
        }
      }
      return results;
    }
    return results = [];
  }

  Future<void> _pullRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    final market = Provider.of<MarketNotifier>(context, listen: false);
    market.disposeValues();
    animalproducts.clear();
    market.getMarket();
  }

  _showPopupMenu() {
    showMenu<String>(
            context: context,
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            position: const RelativeRect.fromLTRB(25, 80, 0, 0),
            items: [
              const PopupMenuItem<String>(
                  value: '1', child: Text('Order by Price')),
              // const PopupMenuItem<String>(
              //     child: Text('Order by Quantity'), value: '11'),
              const PopupMenuItem<String>(
                  value: '11', child: Text('Search by your location')),
            ],
            elevation: 8.0)
        .then((value) {
      switch (value) {
        case null:
          return null;
        case '1':
          setState(() {
            searchOption = '1';
          });
          return 'price';
        case '11':
          setState(() {
            searchOption = '11';
          });
          return 'area';
        default:
          break;
      }
    });
  }
}
