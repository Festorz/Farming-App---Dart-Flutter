import 'package:flutter/material.dart';
import 'package:mkulima/misc/colors.dart';
import 'package:mkulima/pages/subscriptions_page/mpesa_pay.dart';
import 'package:mkulima/server/farmerNotifier.dart';
import 'package:mkulima/server/marketNotifier.dart';
import 'package:mkulima/widgets/appbutton.dart';
import 'package:mkulima/widgets/apptext.dart';
import 'package:mkulima/widgets/headertext.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewProduct extends StatefulWidget {
  const ViewProduct({Key? key, required this.product}) : super(key: key);
  final product;

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  bool showButton = true;
  bool marketing = false;
  bool defMarketing = true;
  bool isPremium = false;
  List marketproducts = [];

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    setState(() {
      marketing = user.getBool("market")!;
      isPremium = user.getBool("premium")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isMarket = widget.product.market;
    final marketNotifier = Provider.of<MarketNotifier>(context);
    final farmerNotifier = Provider.of<FarmerNotifier>(context);

    for (var prod in farmerNotifier.products) {
      if (prod.market == true) {
        marketproducts.add(prod);
        if (marketproducts.isNotEmpty) {
          setState(() {
            defMarketing = false;
          });
        }
      }
    }

    double w1 = MediaQuery.of(context).size.width;
    double h1 = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SizedBox(
        height: h1,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: w1,
                height: h1 * 0.4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.product.imageUrl),
                      fit: BoxFit.cover),
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
                top: 35,
                left: 10,
                child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_outlined,
                        color: Colors.white, size: 22))),
            Positioned(
                top: h1 * 0.375,
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  width: w1,
                  height: h1 - (h1 * 0.375),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Colors.white),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BoldText(
                            text: widget.product.title,
                            size: 25,
                            color: Colors.teal[900]),
                        const SizedBox(height: 20),
                        RichText(
                          text: TextSpan(
                              text: "Price : ",
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pink),
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                        "Ksh. ${widget.product.price.toString()}",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              ]),
                        ),
                        const SizedBox(height: 20),
                        RichText(
                          text: TextSpan(
                              text: "Quantity :  ",
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.pink,
                                  fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                TextSpan(
                                    text: widget.product.quantity.toString(),
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              ]),
                        ),
                        const SizedBox(height: 30),
                        const BoldText(
                            text: "Product description",
                            size: 18,
                            color: Colors.black),
                        const SizedBox(height: 10),
                        AppText(
                            text: widget.product.description,
                            size: 15,
                            lines: 100),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                )),
            Positioned(
                bottom: 5,
                left: 10,
                right: 10,
                child: showButton
                    ? SizedBox(
                        width: w1,
                        child: Center(
                            child: isMarket == false
                                ? GestureDetector(
                                    onTap: () {
                                      if (marketing || defMarketing) {
                                        var data = {
                                          "id": widget.product.id,
                                          "setMarket": true
                                        };
                                        marketNotifier.setMarket(data, context);
                                        // marketNotifier.marketProducts.add(
                                        //     MarketModel(
                                        //         id: widget.product.id,
                                        //         title: widget.product.title,
                                        //         price: widget.product.price,
                                        //         quantity:
                                        //             widget.product.quantity,
                                        //         description:
                                        //             widget.product.description,
                                        //         username:
                                        //             widget.product.username,
                                        //         location:
                                        //             widget.product.location,
                                        //         phone: widget.product.phone,
                                        //         type: widget.product.type,
                                        //         addedDate:
                                        //             widget.product.addedDate,
                                        //         imageUrl:
                                        //             widget.product.imageUrl,
                                        //         market: widget.product.market,
                                        //         premium: isPremium));
                                        for (var element
                                            in farmerNotifier.products) {
                                          if (element.id == widget.product.id) {
                                            element.isMarket(!isMarket);
                                          }
                                        }
                                        showAlertDialog2(context);
                                        setState(() {
                                          showButton = false;
                                        });
                                      } else {
                                        showAlertDialog(context, 500,
                                            'Subscribe to add more products to the market');
                                      }
                                    },
                                    child: AppButton(
                                        color: Colors.white,
                                        backgroundColor: Colors.black,
                                        text: "Add to market",
                                        size: w1 * 0.75,
                                        borderColor: Colors.white30))
                                : isPremium == false
                                    ? GestureDetector(
                                        onTap: () {
                                          showAlertDialog(context, 1000,
                                              'Subscribe to premium to boost your products to appear at top in market search.');
                                        },
                                        child: AppButton(
                                            color: Colors.white,
                                            backgroundColor: Colors.black,
                                            text: "Upgrade to premium",
                                            size: w1 * 0.75,
                                            borderColor: Colors.white30))
                                    : widget.product.premium == false
                                        ? GestureDetector(
                                            onTap: () {
                                              var data = {
                                                "id": widget.product.id,
                                                "setPremium": true
                                              };
                                              marketNotifier.setPremium(
                                                  data, context);
                                              for (var element
                                                  in farmerNotifier.products) {
                                                if (element.id ==
                                                    widget.product.id) {
                                                  element.isPremium(true);
                                                }
                                              }

                                              setState(() {
                                                showButton = false;
                                              });
                                            },
                                            child: AppButton(
                                                color: Colors.white,
                                                backgroundColor: Colors.black,
                                                text: "Set premium",
                                                size: w1 * 0.75,
                                                borderColor: Colors.white30))
                                        : const SizedBox.shrink()))
                    : const SizedBox.shrink())
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, double amount, String text) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    Widget closeButton = IconButton(
      icon: const Icon(Icons.close_outlined, color: Colors.white, size: 25),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alertDialog = AlertDialog(
      backgroundColor: AppColors.bluetheme.withOpacity(0.8),
      title: Center(
          child:
              BoldText(text: "Subscribe", size: 22, color: Colors.amber[700])),
      content: SizedBox(
        height: h * 0.25,
        width: w,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BoldText(
                text: 'Ksh. ${amount.toString()}',
                size: 18,
                color: Colors.lime),
            const SizedBox(height: 15),
            AppText(text: text, size: 14, color: Colors.white, lines: 3),
            const SizedBox(height: 10),
            Center(
              child: Wrap(
                children: List.generate(5, (index) {
                  return const Icon(Icons.star, color: Colors.amber, size: 16);
                }),
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MpesaPay(price: amount)));
              },
              child: AppButton(
                  color: Colors.teal[800],
                  backgroundColor: Colors.white,
                  text: "Lipa na mpesa",
                  size: w * 0.6,
                  borderColor: Colors.black54),
            ),
          ],
        ),
      ),
      actions: [closeButton],
    );

    showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  showAlertDialog2(BuildContext context) {
    Widget closeButton = TextButton(
      child: AppText(text: "Ok", size: 16, color: Colors.blue[600]),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.white,
      title: const Center(
          child: BoldText(text: "Alert", size: 22, color: Colors.black)),
      content: const AppText(
          text:
              'This product will appear in the market after it has been verified.',
          lines: 4,
          color: Colors.black,
          size: 16),
      actions: [closeButton],
    );

    showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  // _image(code) {
  //   Uint8List bytes = base64.decode(code.split(',').last);
  //   return bytes;
  // }
}
