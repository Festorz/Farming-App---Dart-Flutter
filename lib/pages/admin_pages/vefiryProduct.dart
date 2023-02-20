import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mkulima/server/UnverifiedNotifier.dart';
import 'package:mkulima/widgets/appbutton.dart';
import 'package:mkulima/widgets/apptext.dart';
import 'package:mkulima/widgets/headertext.dart';
import 'package:provider/provider.dart';

import '../../misc/colors.dart';

class VerifyProduct extends StatefulWidget {
  const VerifyProduct({Key? key, required this.unverifiedProduct})
      : super(key: key);
  final unverifiedProduct;

  @override
  State<VerifyProduct> createState() => _VerifyProductState();
}

class _VerifyProductState extends State<VerifyProduct> {
  bool showButton = true;

  @override
  Widget build(BuildContext context) {
    final unverifieds = Provider.of<UnverifiedNotifier>(context);

    double w1 = MediaQuery.of(context).size.width;
    double h1 = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
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
                      image: NetworkImage(widget.unverifiedProduct.imageUrl),
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
                  height: h1 - (h1 * 0.3),
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
                            text: widget.unverifiedProduct.title,
                            size: 25,
                            color: Colors.teal[900]),
                        const SizedBox(height: 20),
                        RichText(
                          text: TextSpan(
                              text: "Owner : ",
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pink),
                              children: <TextSpan>[
                                TextSpan(
                                    text: widget.unverifiedProduct.username,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              ]),
                        ),
                        const SizedBox(height: 20),
                        RichText(
                          text: TextSpan(
                              text: "Product Location : ",
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pink),
                              children: <TextSpan>[
                                TextSpan(
                                    text: widget.unverifiedProduct.location,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.black)),
                              ]),
                        ),
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
                                        "Ksh. ${widget.unverifiedProduct.price.toString()}",
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.black)),
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
                                    text: widget.unverifiedProduct.quantity
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.black)),
                              ]),
                        ),
                        const SizedBox(height: 20),
                        RichText(
                          text: TextSpan(
                              text: "Product type :  ",
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.pink,
                                  fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                TextSpan(
                                    text: widget.unverifiedProduct.type
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.black)),
                              ]),
                        ),
                        const SizedBox(height: 30),
                        BoldText(
                            text: "Product description",
                            size: 20,
                            color: Colors.teal[700]),
                        const SizedBox(height: 10),
                        AppText(
                            text: widget.unverifiedProduct.description,
                            size: 15,
                            lines: 100),
                        const SizedBox(height: 110),
                      ],
                    ),
                  ),
                )),
            Positioned(
                bottom: 5,
                left: 10,
                right: 10,
                child: showButton
                    ? widget.unverifiedProduct.verified == false
                        ? SizedBox(
                            width: w1,
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  var data = {
                                    "id": widget.unverifiedProduct.id,
                                    "setVerified":
                                        !widget.unverifiedProduct.verified
                                  };
                                  unverifieds.setVerified(data, context);

                                  setState(() {
                                    showButton = false;
                                  });
                                  for (var element in unverifieds.market) {
                                    if (element.id ==
                                        widget.unverifiedProduct.id) {
                                      element.isVerified(true);
                                    }
                                  }
                                },
                                child: AppButton(
                                    color: Colors.white,
                                    backgroundColor: Colors.black,
                                    text: "Verify to market",
                                    size: w1 * 0.75,
                                    borderColor: Colors.white30),
                              ),
                            ),
                          )
                        : const SizedBox.shrink()
                    : const SizedBox.shrink())
          ],
        ),
      ),
    );
  }
}
