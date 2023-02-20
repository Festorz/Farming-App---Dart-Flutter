import 'package:flutter/material.dart';
import 'package:mkulima/misc/colors.dart';
import 'package:mkulima/pages/productPage/addProduct.dart';
import 'package:mkulima/pages/productPage/viewProduct.dart';
import 'package:mkulima/pages/subscriptions_page/mpesa_pay.dart';
import 'package:mkulima/widgets/appbutton.dart';
import 'package:mkulima/widgets/apptext.dart';
import 'package:mkulima/widgets/headertext.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../server/farmerNotifier.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  bool defaultaddMore = false;
  bool addMore = false;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    setState(() {
      addMore = user.getBool('upload')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataNotifier = Provider.of<FarmerNotifier>(context);
    if (dataNotifier.products.isEmpty) {
      setState(() {
        defaultaddMore = true;
      });
    }
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
        title:
            const BoldText(text: "My Products", size: 20, color: Colors.white),
        elevation: 0,
        actions: [],
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
                    child: dataNotifier.dataLoaded
                        ? GridView.extent(
                            primary: true,
                            scrollDirection: Axis.vertical,
                            mainAxisSpacing: 5.0,
                            crossAxisSpacing: 10.0,
                            maxCrossAxisExtent: 200.0,
                            children: List.generate(
                                dataNotifier.products.length, (index) {
                              return GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => ViewProduct(
                                            product:
                                                dataNotifier.products[index]))),
                                child: Column(children: [
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    height: 130,
                                    width: w1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        image: NetworkImage(dataNotifier
                                            .products[index].imageUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: AppText(
                                        text: dataNotifier.products[index].title
                                                    .length >
                                                25
                                            ? "${dataNotifier.products[index].title.substring(0, 25)} ..."
                                            : dataNotifier
                                                .products[index].title,
                                        size: 16,
                                        bold: true),
                                  )
                                ]),
                              );
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (addMore || defaultaddMore) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const AddProduct()));
          } else {
            showAlertDialog(context, 200);
          }
        },
        backgroundColor: Colors.pink[800],
        tooltip: 'Add product',
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }

  showAlertDialog(BuildContext context, double amount) {
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
            const AppText(
                text: 'Subscribe to add more products',
                size: 14,
                color: Colors.white,
                lines: 3),
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

  Future<void> _pullRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    final products = Provider.of<FarmerNotifier>(context, listen: false);
    products.disposeValues();
    products.getProducts();
    // print('loading farm products');
  }
}
