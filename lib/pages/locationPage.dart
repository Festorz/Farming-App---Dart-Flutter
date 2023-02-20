import 'package:flutter/material.dart';

import '../widgets/apptext.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
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
                    text: 'This is location page',
                    size: 16,
                    color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
