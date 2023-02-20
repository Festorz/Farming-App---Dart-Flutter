import 'package:flutter/material.dart';

import '../widgets/apptext.dart';

class ManagersPage extends StatefulWidget {
  const ManagersPage({Key? key}) : super(key: key);

  @override
  _ManagersPageState createState() => _ManagersPageState();
}

class _ManagersPageState extends State<ManagersPage> {
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
                    text: 'This is managers page',
                    size: 16,
                    color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
