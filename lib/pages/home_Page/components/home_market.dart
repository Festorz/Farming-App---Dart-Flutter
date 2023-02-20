import 'package:flutter/material.dart';
import 'package:mkulima/misc/colors.dart';
import 'package:mkulima/pages/market_page/marketPage.dart';
import 'package:mkulima/pages/market_page/market_product.dart';
import 'package:mkulima/server/marketNotifier.dart';
import 'package:mkulima/widgets/apptext.dart';
import 'package:provider/provider.dart';

class MarketItems extends StatelessWidget {
  const MarketItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final marketNotifier = Provider.of<MarketNotifier>(context);

    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 5, right: 10),
            child: Row(
              children: [
                const AppText(
                    text: 'Market items',
                    size: 14,
                    bold: true,
                    color: Colors.black),
                Expanded(child: Container()),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MarketPage())),
                  child: SizedBox(
                    height: 20,
                    child: Row(
                      children: const [
                        AppText(
                          text: 'See all',
                          size: 13,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 10,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
        SizedBox(
            height: 160,
            width: double.maxFinite,
            child: marketNotifier.dataLoaded
                ? ListView.builder(
                    itemCount: marketNotifier.marketProducts.length > 4
                        ? 4
                        : marketNotifier.marketProducts.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => MarketProduct(
                                    product:
                                        marketNotifier.marketProducts[index]))),
                        child: Container(
                          margin: const EdgeInsets.only(right: 15, top: 10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 200,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: NetworkImage(marketNotifier
                                            .marketProducts[index].imageUrl),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  width: 190,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        AppText(
                                          text: marketNotifier
                                                      .marketProducts[index]
                                                      .title
                                                      .length >
                                                  10
                                              ? "${marketNotifier.marketProducts[index].title.substring(0, 10)} ..."
                                              : marketNotifier
                                                  .marketProducts[index].title,
                                          size: 14,
                                        ),
                                        Expanded(child: Container()),
                                        AppText(
                                          text:
                                              '${marketNotifier.marketProducts[index].price} /=',
                                          size: 13,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                // const SizedBox(height: 5),
                                // SizedBox(
                                //   width: 190,
                                //   child: Padding(
                                //     padding: const EdgeInsets.symmetric(
                                //         horizontal: 5),
                                //     child: AppText(
                                //         text: marketNotifier
                                //             .marketProducts[index].description,
                                //         size: 12),
                                //   ),
                                // )
                              ]),
                        ),
                      );
                    })
                : Center(
                    child:
                        CircularProgressIndicator(color: AppColors.bluetheme),
                  )),
      ],
    );
  }
}
