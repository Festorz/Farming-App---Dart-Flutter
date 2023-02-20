import 'package:flutter/material.dart';
import 'package:mkulima/misc/colors.dart';
import 'package:mkulima/pages/subscriptions_page/mpesa_pay.dart';
import 'package:mkulima/widgets/appbutton.dart';
import 'package:mkulima/widgets/headertext.dart';
import 'package:mkulima/widgets/subscribed.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/apptext.dart';

class SubscriptionsPage extends StatefulWidget {
  const SubscriptionsPage({Key? key}) : super(key: key);

  @override
  _SubscriptionsPageState createState() => _SubscriptionsPageState();
}

class _SubscriptionsPageState extends State<SubscriptionsPage> {
  bool addMore = false;
  bool premium = false;
  bool marketing = false;

  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    setState(() {
      addMore = user.getBool('upload')!;
      premium = user.getBool('premium')!;
      marketing = user.getBool("market")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, size: 22, color: Colors.white)),
        title: const BoldText(
            text: "Subscriptions", size: 20, color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 4, 33, 56),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Container(
        height: h,
        width: w,
        color: Colors.white,
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Container(
                  height: 150,
                  width: w,
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Color.fromARGB(255, 32, 138, 11),
                      Color.fromARGB(255, 37, 83, 10)
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.8),
                        blurRadius: 5,
                        offset: const Offset(4, 8),
                      )
                    ],
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const AppText(
                                text: "Market subscription",
                                size: 17,
                                color: Colors.white),
                            const SizedBox(width: 10),
                            Wrap(
                              children: List.generate(5, (index) {
                                return const Icon(Icons.star,
                                    color: Colors.amber, size: 16);
                              }),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        const AppText(
                          text: "Subscribe to upload more products to market.",
                          size: 14,
                          color: Colors.white70,
                          lines: 2,
                        ),
                        const SizedBox(height: 30),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: marketing == true
                              ? Subscribed(
                                  text: 'Subscribed',
                                  size: w * 0.5,
                                  borderColor: Colors.black)
                              : GestureDetector(
                                  onTap: () => showAlertDialog(context, 500),
                                  child: AppButton(
                                      color: Colors.blue[800],
                                      backgroundColor: Colors.white,
                                      text: "Pay",
                                      size: w * 0.4,
                                      borderColor: Colors.black54),
                                ),
                        )
                      ])),
              const SizedBox(height: 30),
              Container(
                  height: 150,
                  width: w,
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Color.fromARGB(255, 147, 30, 151),
                      Color.fromARGB(255, 71, 5, 49)
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.8),
                          blurRadius: 5,
                          offset: const Offset(4, 8))
                    ],
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const AppText(
                                text: "Go Premium",
                                size: 17,
                                color: Colors.white),
                            const SizedBox(width: 10),
                            Wrap(
                              children: List.generate(5, (index) {
                                return const Icon(Icons.star,
                                    color: Colors.amber, size: 16);
                              }),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        const AppText(
                          text:
                              "Upgrade your products to appear at the top and get customers instantly in market search .",
                          size: 14,
                          color: Colors.white70,
                          lines: 3,
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: premium
                              ? Subscribed(
                                  text: 'Subscribed',
                                  size: w * 0.5,
                                  borderColor: Colors.black)
                              : GestureDetector(
                                  onTap: () => showAlertDialog(context, 1000),
                                  child: AppButton(
                                      color: Colors.blue[800],
                                      backgroundColor: Colors.white,
                                      text: "Pay",
                                      size: w * 0.4,
                                      borderColor: Colors.black54),
                                ),
                        )
                      ])),
              const SizedBox(height: 30),
              Container(
                  height: 150,
                  width: w,
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Color.fromARGB(255, 30, 48, 151),
                      Color.fromARGB(255, 6, 5, 71)
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.8),
                          blurRadius: 5,
                          offset: const Offset(4, 8))
                    ],
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const AppText(
                                text: "More submissions",
                                size: 17,
                                color: Colors.white),
                            const SizedBox(width: 10),
                            Wrap(
                              children: List.generate(5, (index) {
                                return const Icon(Icons.star,
                                    color: Colors.amber, size: 16);
                              }),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        const AppText(
                          text: "Upgrade to add more products to your list.",
                          size: 14,
                          color: Colors.white70,
                          lines: 2,
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: addMore
                              ? Subscribed(
                                  text: 'Subscribed',
                                  size: w * 0.5,
                                  borderColor: Colors.black)
                              : GestureDetector(
                                  onTap: () => showAlertDialog(context, 200),
                                  child: AppButton(
                                      color: Colors.blue[800],
                                      backgroundColor: Colors.white,
                                      text: "Pay",
                                      size: w * 0.4,
                                      borderColor: Colors.black54),
                                ),
                        )
                      ])),
              const SizedBox(height: 30),
              Container(
                  height: 150,
                  width: w,
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Color.fromARGB(255, 30, 133, 151),
                      Color.fromARGB(255, 5, 58, 71)
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.8),
                          blurRadius: 5,
                          offset: const Offset(4, 8))
                    ],
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const AppText(
                                text: "Mkulima App AI",
                                size: 17,
                                color: Colors.white),
                            const SizedBox(width: 10),
                            Wrap(
                              children: List.generate(5, (index) {
                                return const Icon(Icons.star,
                                    color: Colors.amber, size: 16);
                              }),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        const AppText(
                          text:
                              "Subscribe to use our AI to diagnose plant and animal diseases.",
                          size: 14,
                          color: Colors.white70,
                          lines: 3,
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: AppButton(
                              color: Colors.blue[800],
                              backgroundColor: Colors.white,
                              text: "Pay",
                              size: w * 0.4,
                              borderColor: Colors.black54),
                        )
                      ])),
              const SizedBox(height: 10),
            ],
          ),
        ),
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
      backgroundColor: AppColors.bluetheme.withOpacity(0.9),
      title: BoldText(
          text: 'Ksh. ${amount.toString()}',
          size: 25,
          color: Colors.amber[600]),
      content: Container(
        height: h * 0.3,
        width: w,
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                    size: w * 0.7,
                    borderColor: Colors.black54),
              ),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MpesaPay(price: amount)));
                },
                child: AppButton(
                    color: Colors.blue[800],
                    backgroundColor: Colors.white,
                    text: "PayPal",
                    size: w * 0.7,
                    borderColor: Colors.black54),
              ),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MpesaPay(price: amount)));
                },
                child: AppButton(
                    color: Colors.red[800],
                    backgroundColor: Colors.white,
                    text: "Airtel Money",
                    size: w * 0.7,
                    borderColor: Colors.black54),
              ),
            ],
          ),
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
}
