import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mkulima/enums/connectivity_status.dart';
import 'package:mkulima/misc/colors.dart';
import 'package:mkulima/server/authentication.dart';
import 'package:mkulima/server/subscriptionsAPI.dart';
import 'package:mkulima/widgets/appbutton.dart';
import 'package:mkulima/widgets/apptext.dart';
import 'package:mkulima/widgets/headertext.dart';
import 'package:mkulima/widgets/snackbar.dart';
import 'package:mkulima/widgets/textfield.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MpesaPay extends StatefulWidget {
  const MpesaPay({Key? key, required this.price}) : super(key: key);
  final double price;

  @override
  State<MpesaPay> createState() => _MpesaPayState();
}

class _MpesaPayState extends State<MpesaPay> {
  TextEditingController phonenumberController = TextEditingController();
  bool defaultnumber = false;
  bool clickable = true;
  // var numberErrors = false;
  String defphone = '';
  String username = '';
  final _formKey = GlobalKey<FormState>();
  String phonenumber = '';

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    setState(() {
      username = user.getString('username') ?? '';
      defphone = user.getString('phone') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    // print('number errors are $numberErrors');
    // print('phonenumber s11 is $phonenumber');

    if (clickable == false) {
      Timer(const Duration(seconds: 15), () {
        Navigator.pop(context);
      });
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, size: 22, color: Colors.white)),
        title: const BoldText(
            text: "Lipa na mpesa", size: 20, color: Colors.green),
        backgroundColor: const Color.fromARGB(255, 4, 33, 56),
        elevation: 0,
      ),
      backgroundColor: AppColors.bluetheme,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 20, bottom: 20),
              width: w,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black45),
                borderRadius: BorderRadius.circular(20),
                color: Colors.white10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BoldText(
                      text: "Ksh ${widget.price.toString()}",
                      size: 25,
                      color: Colors.amber[700]),
                  const SizedBox(height: 30),
                  defaultnumber == false
                      ? Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const AppText(
                                text: "Enter phone number",
                                size: 18,
                                color: Colors.white54,
                              ),
                              const SizedBox(height: 20),
                              AppTextFormfield(
                                  controller: phonenumberController,
                                  hint: "2547123....",
                                  icon: Icons.phone,
                                  type: TextInputType.phone),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(height: 50),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: CheckboxListTile(
                      activeColor: Colors.pink[800],
                      value: defaultnumber,
                      onChanged: (newValue) {
                        setState(() {
                          defaultnumber = newValue!;
                          // print('use defaultnumber $defaultnumber');
                        });
                      },
                      title: AppText(
                          text: "Use default no. $defphone",
                          size: 16,
                          color: Colors.black87),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                  SizedBox(height: h * 0.2),
                  Center(
                      child: clickable == true
                          ? GestureDetector(
                              onTap: () {
                                if (defaultnumber == true) {
                                  if (_checkNumber(context, defphone) ==
                                      false) {
                                    var data = {
                                      "phonenumber": phonenumber,
                                      "username": username,
                                      "amount": widget.price
                                    };
                                    _subscribe(data, context);
                                  }
                                } else if (_formKey.currentState!.validate()) {
                                  if (_checkNumber(context,
                                          phonenumberController.text) ==
                                      false) {
                                    var data = {
                                      "phonenumber": phonenumber,
                                      "username": username,
                                      "amount": widget.price
                                    };
                                    _subscribe(data, context);
                                  }
                                }
                              },
                              child: AppButton(
                                  color: Colors.white,
                                  backgroundColor: Colors.green[900],
                                  text: "Subscribe",
                                  size: w * 0.7,
                                  borderColor: Colors.white38),
                            )
                          : const CircularProgressIndicator(
                              color: Colors.white54,
                            ))
                ],
              ),
            ),
            const SizedBox(height: 40),
            Container(
              height: 50,
              width: w * 0.6,
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      image: AssetImage('images/mpesa.jpeg'),
                      fit: BoxFit.fill)),
            )
          ],
        ),
      ),
    );
  }

  _checkNumber(BuildContext context, number) {
    var errors = false;
    if (number.length <= 9) {
      errors = true;
      Appsnackbar.snackbar(
          context, 'check your phone number and try again...', AppColors.pink);
    } else if (number.length == 10) {
      errors = false;
      setState(() {
        phonenumber = number.replaceFirst(RegExp('0'), '254');
        // print('phonenumber is $phonenumber');
      });
    } else if (number.length > 12) {
      errors = false;
      setState(() {
        phonenumber = number.replaceAll('+', '');
        // print('phonenumber is aaaa $phonenumber');
      });
    } else {
      setState(() {
        phonenumber = number;
        // print('phonenumber sww is $phonenumber');
      });
    }
    return errors;
  }

  _subscribe(data, context) {
    final subscribe =
        Provider.of<SubscriptionsProvider>(context, listen: false);
    final user = Provider.of<Authentication>(context, listen: false);
    final connection = Provider.of<ConnectivityStatus>(context, listen: false);

    if (connection != ConnectivityStatus.Offline) {
      subscribe.subscribeMpesa(data, context);
      Timer(const Duration(seconds: 20), () {
        user.getuser(data, context);
      });

      setState(() {
        clickable = false;
      });
    } else {
      Appsnackbar.snackbar(
          context,
          'Error: You are offline, please connect to the internet!',
          AppColors.pink);
    }
  }
}
