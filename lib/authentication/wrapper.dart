import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mkulima/data/data.dart';
import 'package:mkulima/model/pages_model.dart';
import 'package:mkulima/pages/admin_pages/unverifiedProducts.dart';
import 'package:mkulima/pages/home_Page/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  String newuser = '';

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () => isAuthenticated());
  }

  Future isAuthenticated() async {
    SharedPreferences loginData = await SharedPreferences.getInstance();
    newuser = (loginData.getString('username') ?? '');

    if (newuser == 'fez') {
      pages.add(PagesModel(
          title: 'Verify',
          page: const VerifyProducts(),
          icon: Icons.check,
          color: Colors.blue[700]));
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              newuser == '' ? const LoginPage() : const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      height: h,
      width: w,
      color: Colors.white,
      child: Center(
        child: Image.asset('images/mkulima.png'),
      ),
    );
  }
}
