import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as urllauncher;

import 'package:mkulima/misc/colors.dart';
import 'package:mkulima/server/marketNotifier.dart';
import 'package:mkulima/widgets/apptext.dart';
import 'package:mkulima/widgets/headertext.dart';

class MarketProduct extends StatefulWidget {
  const MarketProduct({Key? key, required this.product}) : super(key: key);
  final product;

  @override
  State<MarketProduct> createState() => _MarketProductState();
}

class _MarketProductState extends State<MarketProduct> {
  List similarItems = [];
  List userItems = [];

  @override
  Widget build(BuildContext context) {
    final market = Provider.of<MarketNotifier>(context);
    double w1 = MediaQuery.of(context).size.width;
    double h1 = MediaQuery.of(context).size.height;

    similarItems.clear();
    userItems.clear();

    for (var element in market.marketProducts) {
      if (element.title.toLowerCase() == widget.product.title.toLowerCase() &&
          element.id != widget.product.id) {
        similarItems.add(element);
      }
      if (element.username.toLowerCase() ==
              widget.product.username.toLowerCase() &&
          element.id != widget.product.id) {
        userItems.add(element);
      }
    }
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SizedBox(
        height: h1,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // product image
              Container(
                width: w1,
                height: h1 * 0.4,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  image: DecorationImage(
                      image: NetworkImage(widget.product.imageUrl),
                      fit: BoxFit.cover),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_outlined),
                        color: Colors.white,
                        iconSize: 22),
                  ),
                ),
              ),
              // product title, ...
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                width: w1,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: w1 * 0.6,
                          child: BoldText(
                            text: widget.product.title,
                            size: 25,
                            color: Colors.teal[900],
                          ),
                        ),
                        Expanded(child: Container()),
                        SizedBox(
                          width: w1 * 0.3,
                          child: Center(
                            child: BoldText(
                                text: 'Ksh. ${widget.product.price.toString()}',
                                color: Colors.pink,
                                size: 18),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                          text: "Quantity :  ",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.pink,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                                text: widget.product.quantity.toString(),
                                style: const TextStyle(
                                    fontSize: 17, color: Colors.black)),
                          ]),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: w1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const BoldText(
                              text: "Seller", size: 18, color: Colors.black),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              SizedBox(
                                width: w1 * 0.4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.person,
                                        color: Colors.pink, size: 30),
                                    AppText(
                                      text: widget.product.username,
                                      size: 16,
                                      lines: 2,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(child: Container()),
                              SizedBox(
                                width: w1 * 0.5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.location_on,
                                        color: Colors.pink, size: 30),
                                    AppText(
                                        text: widget.product.location,
                                        size: 16,
                                        lines: 2,
                                        color: Colors.black),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  urllauncher
                                      .launch('tel:+${widget.product.phone}');
                                },
                                child: Container(
                                  width: w1 * 0.4,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.green[800],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.phone,
                                          size: 17, color: Colors.white),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      AppText(
                                          text: "CALL SELLER",
                                          size: 14,
                                          color: Colors.white),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: w1 * 0.4,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.green[800],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    urllauncher.launch(
                                        "sms:+${widget.product.phone.toString()}");
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.message,
                                          size: 17, color: Colors.white),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      AppText(
                                          text: "SMS SELLER",
                                          size: 14,
                                          color: Colors.white),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    const BoldText(
                        text: "Product description",
                        size: 19,
                        color: Colors.black),
                    const SizedBox(height: 10),
                    AppText(
                        text: '- ${widget.product.description}',
                        size: 15,
                        lines: 100),
                    const SizedBox(height: 30),
                    SizedBox(
                        width: w1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                urllauncher
                                    .launch('tel:+${widget.product.phone}');
                              },
                              child: Container(
                                width: w1 * 0.4,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.green[800],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.phone,
                                        size: 17, color: Colors.white),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    AppText(
                                        text: "CALL SELLER",
                                        size: 14,
                                        color: Colors.white),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: w1 * 0.4,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.green[800],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: MaterialButton(
                                onPressed: () {
                                  urllauncher.launch(
                                      "sms:+${widget.product.phone.toString()}");
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.message,
                                        size: 17, color: Colors.white),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    AppText(
                                        text: "SMS SELLER",
                                        size: 14,
                                        color: Colors.white),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ),
              // similar items
              const SizedBox(height: 10),
              const Divider(color: Colors.black54),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BoldText(
                      text: "Similar products",
                      size: 20,
                      color: Colors.orange[700],
                    ),
                    SizedBox(
                      height: 180,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: similarItems.length,
                          itemBuilder: (BuildContext context, index) {
                            return GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => MarketProduct(
                                          product: similarItems[index]))),
                              child: Container(
                                margin:
                                    const EdgeInsets.only(right: 15, top: 10),
                                child: Column(children: [
                                  Container(
                                    width: 200,
                                    height: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              similarItems[index].imageUrl),
                                          fit: BoxFit.cover,
                                        )),
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
                                            text: similarItems[index]
                                                        .title
                                                        .length >
                                                    10
                                                ? "${similarItems[index].title.substring(0, 10)} ..."
                                                : similarItems[index].title,
                                            size: 16,
                                            bold: true,
                                          ),
                                          Expanded(child: Container()),
                                          AppText(
                                              text:
                                                  'Ksh ${similarItems[index].price}',
                                              size: 13,
                                              bold: true)
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  SizedBox(
                                    width: 190,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: AppText(
                                          text: similarItems[index].description,
                                          size: 14),
                                    ),
                                  )
                                ]),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 5),
              const Divider(color: Colors.black54),
              //   user more items
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BoldText(
                      text: "Other ${widget.product.username} items",
                      size: 20,
                      color: Colors.green[800],
                    ),
                    SizedBox(
                      height: 180,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: userItems.length,
                          itemBuilder: (BuildContext context, index) {
                            return GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => MarketProduct(
                                          product: userItems[index]))),
                              child: Container(
                                margin:
                                    const EdgeInsets.only(right: 15, top: 10),
                                child: Column(children: [
                                  Container(
                                    width: 200,
                                    height: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              userItems[index].imageUrl),
                                          fit: BoxFit.cover,
                                        )),
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
                                            text: userItems[index]
                                                        .title
                                                        .length >
                                                    10
                                                ? "${userItems[index].title.substring(0, 10)} ..."
                                                : userItems[index].title,
                                            size: 16,
                                            bold: true,
                                          ),
                                          Expanded(child: Container()),
                                          AppText(
                                              text:
                                                  'Ksh ${userItems[index].price}',
                                              size: 13,
                                              bold: true)
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  SizedBox(
                                    width: 190,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: AppText(
                                          text: userItems[index].description,
                                          size: 14),
                                    ),
                                  )
                                ]),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _call(String phone) {
    print('calling');
    urllauncher.launch('tel:$phone');
  }
}
