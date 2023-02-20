import 'package:flutter/material.dart';
import 'package:mkulima/pages/admin_pages/vefiryProduct.dart';
import 'package:mkulima/server/UnverifiedNotifier.dart';
import 'package:mkulima/widgets/apptext.dart';
import 'package:mkulima/widgets/headertext.dart';
import 'package:provider/provider.dart';

import '../../misc/colors.dart';

class VerifyProducts extends StatefulWidget {
  const VerifyProducts({Key? key}) : super(key: key);

  @override
  State<VerifyProducts> createState() => _VerifyProductsState();
}

class _VerifyProductsState extends State<VerifyProducts> {
  @override
  Widget build(BuildContext context) {
    final unverifieds = Provider.of<UnverifiedNotifier>(context);

    double w = MediaQuery.of(context).size.width;
    double w1 = (w - 30) / 2;

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
            text: "Unverified Products", size: 20, color: Colors.white),
        elevation: 0,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: Container(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                    padding: const EdgeInsets.only(bottom: 10, top: 10),
                    child: unverifieds.dataLoaded
                        ? GridView.extent(
                            scrollDirection: Axis.vertical,
                            mainAxisSpacing: 5.0,
                            shrinkWrap: true,
                            childAspectRatio: (2 / 2),
                            crossAxisSpacing: 10.0,
                            maxCrossAxisExtent: 200.0,
                            children: List.generate(unverifieds.market.length,
                                (index) {
                              return unverifieds.market[index].verified == false
                                  ? GestureDetector(
                                      onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  VerifyProduct(
                                                      unverifiedProduct:
                                                          unverifieds
                                                              .market[index]))),
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
                                              image: NetworkImage(unverifieds
                                                  .market[index].imageUrl),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
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
                                                  text: unverifieds
                                                              .market[index]
                                                              .title
                                                              .length >
                                                          7
                                                      ? "${unverifieds.market[index].title.substring(0, 7)} ..."
                                                      : unverifieds
                                                          .market[index].title,
                                                  size: 16,
                                                  bold: true),
                                              Expanded(child: Container()),
                                              AppText(
                                                  text:
                                                      'Ksh ${unverifieds.market[index].price}',
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
                                                text: unverifieds
                                                    .market[index].description,
                                                size: 14),
                                          ),
                                        )
                                      ]),
                                    )
                                  : const SizedBox.shrink();
                            }),
                          )
                        : Center(
                            child: CircularProgressIndicator(
                                color: AppColors.bluetheme))),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pullRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    final unverifieds = Provider.of<UnverifiedNotifier>(context, listen: false);
    unverifieds.disposeValues();
    unverifieds.getUnverified();
  }
}
