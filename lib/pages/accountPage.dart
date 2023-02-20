import 'package:flutter/material.dart';

import '../widgets/apptext.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Center(
                child: AppText(
                    text: 'This is accounts page',
                    size: 16,
                    color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
