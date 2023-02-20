import 'package:flutter/material.dart';
import 'package:mkulima/misc/colors.dart';
import 'package:mkulima/pages/productPage/productsPage.dart';
import 'package:mkulima/pages/productPage/viewProduct.dart';
import 'package:mkulima/server/farmerNotifier.dart';
import 'package:mkulima/widgets/apptext.dart';
import 'package:provider/provider.dart';

class FarmProducts extends StatelessWidget {
  const FarmProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataNotifier = Provider.of<FarmerNotifier>(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 10),
          child: Row(
            children: [
              const AppText(
                  text: 'Farm Products',
                  size: 14,
                  bold: true,
                  color: Colors.black),
              Expanded(child: Container()),
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProductsPage())),
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
          ),
        ),
        SizedBox(
            height: 155,
            width: double.maxFinite,
            child: dataNotifier.dataLoaded
                ? ListView.builder(
                    itemCount: dataNotifier.products.length > 4
                        ? 4
                        : dataNotifier.products.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ViewProduct(
                                product: dataNotifier.products[index]),
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(right: 15, top: 10),
                          child: Column(children: [
                            Container(
                              width: 200,
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        dataNotifier.products[index].imageUrl),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              width: 190,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: AppText(
                                  text: dataNotifier
                                              .products[index].title.length >
                                          15
                                      ? "${dataNotifier.products[index].title.substring(0, 15)} ..."
                                      : dataNotifier.products[index].title,
                                  size: 14,
                                ),
                              ),
                            )
                          ]),
                        ),
                      );
                    })
                : Center(
                    child:
                        CircularProgressIndicator(color: AppColors.bluetheme),
                  ))
      ],
    );
  }
}
